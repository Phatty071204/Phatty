package connect;

import java.sql.Connection;
import java.sql.SQLException;

public class TestConnection {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("Đã kết nối thành công đến database WebBanHang.");
        } catch (SQLException e) {
            System.out.println("Chưa kết nối được database WebBanHang.");
            System.out.println("Kiểm tra SQL Server, cổng 1433, tên database và tài khoản trong DBConnection.java.");
            e.printStackTrace();
        }
    }
}
