package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connect.DBConnection;
import model.SanPham;

public class SanPhamDAO {
    private SanPham map(ResultSet rs) throws java.sql.SQLException {
        SanPham sp = new SanPham();
        sp.setMaSP(rs.getInt("MaSP"));
        sp.setTenSP(rs.getString("TenSP"));
        sp.setGia(rs.getDouble("Gia"));
        sp.setSoLuong(rs.getInt("SoLuong"));
        sp.setHinhAnh(rs.getString("HinhAnh"));
        sp.setMoTa(rs.getString("MoTa"));
        return sp;
    }

    public List<SanPham> getAllSanPham() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT MaSP, TenSP, Gia, SoLuong, HinhAnh, MoTa FROM SanPham ORDER BY MaSP DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) {
            System.err.println("Không tải được danh sách sản phẩm: " + e.getMessage());
        }
        return list;
    }

    public SanPham getSanPhamById(int maSP) {
        String sql = "SELECT MaSP, TenSP, Gia, SoLuong, HinhAnh, MoTa FROM SanPham WHERE MaSP = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maSP);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) {
            System.err.println("Không lấy được sản phẩm: " + e.getMessage());
        }
        return null;
    }

    public List<SanPham> searchSanPham(String keyword) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT MaSP, TenSP, Gia, SoLuong, HinhAnh, MoTa FROM SanPham "
                   + "WHERE TenSP LIKE ? OR MoTa LIKE ? ORDER BY MaSP DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String key = "%" + keyword.trim() + "%";
            ps.setString(1, key);
            ps.setString(2, key);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) {
            System.err.println("Không tìm kiếm được sản phẩm: " + e.getMessage());
        }
        return list;
    }
}
