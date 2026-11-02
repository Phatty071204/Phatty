package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import connect.DBConnection;
import model.CartItem;
import model.DonHang;

public class DonHangDAO {
    public int taoDonHang(List<CartItem> cart, String customerName, String phone, String address) {
        if (cart == null || cart.isEmpty()) return -1;

        String sqlOrder = "INSERT INTO DonHang (TongTien, TrangThai, TenKhachHang, SoDienThoai, DiaChi) "
                        + "VALUES (?, N'Đã đặt', ?, ?, ?)";
        String sqlDetail = "INSERT INTO ChiTietDonHang (MaDH, MaSP, SoLuong, DonGia, ThanhTien) VALUES (?, ?, ?, ?, ?)";
        String sqlStock = "UPDATE SanPham SET SoLuong = SoLuong - ? WHERE MaSP = ? AND SoLuong >= ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                double total = 0;
                for (CartItem item : cart) {
                    if (item == null || item.getSanPham() == null || item.getSoLuong() <= 0) {
                        throw new Exception("Dữ liệu giỏ hàng không hợp lệ.");
                    }
                    total += item.getThanhTien();
                }

                int orderId;
                try (PreparedStatement ps = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setDouble(1, total);
                    ps.setString(2, customerName);
                    ps.setString(3, phone);
                    ps.setString(4, address);
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) throw new Exception("Không lấy được mã đơn hàng.");
                        orderId = rs.getInt(1);
                    }
                }

                try (PreparedStatement detail = conn.prepareStatement(sqlDetail);
                     PreparedStatement stock = conn.prepareStatement(sqlStock)) {
                    for (CartItem item : cart) {
                        int id = item.getSanPham().getMaSP();
                        int quantity = item.getSoLuong();

                        stock.setInt(1, quantity);
                        stock.setInt(2, id);
                        stock.setInt(3, quantity);
                        if (stock.executeUpdate() != 1) {
                            throw new Exception("Sản phẩm " + item.getSanPham().getTenSP()
                                    + " không đủ số lượng trong kho.");
                        }

                        detail.setInt(1, orderId);
                        detail.setInt(2, id);
                        detail.setInt(3, quantity);
                        detail.setDouble(4, item.getSanPham().getGia());
                        detail.setDouble(5, item.getThanhTien());
                        detail.addBatch();
                    }
                    detail.executeBatch();
                }

                conn.commit();
                return orderId;
            } catch (Exception e) {
                conn.rollback();
                System.err.println("Không tạo được đơn hàng: " + e.getMessage());
                return -1;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (Exception e) {
            System.err.println("Lỗi kết nối khi tạo đơn hàng: " + e.getMessage());
            return -1;
        }
    }

    public List<DonHang> getAllDonHang() {
        List<DonHang> list = new ArrayList<>();
        String sql = "SELECT MaDH, NgayDat, TongTien, TrangThai FROM DonHang ORDER BY MaDH DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DonHang dh = new DonHang();
                dh.setMaDH(rs.getInt("MaDH"));
                dh.setNgayDat(rs.getString("NgayDat"));
                dh.setTongTien(rs.getDouble("TongTien"));
                dh.setTrangThai(rs.getString("TrangThai"));
                list.add(dh);
            }
        } catch (Exception e) {
            System.err.println("Không tải được đơn hàng: " + e.getMessage());
        }
        return list;
    }
}
