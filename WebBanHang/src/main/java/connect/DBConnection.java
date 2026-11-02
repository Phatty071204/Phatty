package connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {
    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Không tìm thấy JDBC Driver của SQL Server. Hãy kiểm tra mssql-jdbc trong WEB-INF/lib.", e);
        }

        String server = System.getProperty("shop.db.server", "localhost");
        String port = System.getProperty("shop.db.port", "1433");
        String database = System.getProperty("shop.db.name", "WebBanHang");
        String user = System.getProperty("shop.db.user", "shopuser");
        String password = System.getProperty("shop.db.password", "123456");

        String url = "jdbc:sqlserver://" + server + ":" + port
                + ";databaseName=" + database
                + ";encrypt=true;trustServerCertificate=true;loginTimeout=10";

        return DriverManager.getConnection(url, user, password);
    }
}
