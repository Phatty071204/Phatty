SHOP PHÁT AN - HƯỚNG DẪN CÀI ĐẶT VÀ CHẠY
=========================================

CÔNG NGHỆ
- Java JSP/Servlet
- Eclipse IDE for Enterprise Java and Web Developers
- Apache Tomcat 9
- SQL Server + SQL Server Management Studio (SSMS)
- JDBC Driver đã được đặt trong WEB-INF/lib

1. TẠO CƠ SỞ DỮ LIỆU
- Mở SQL Server Management Studio (SSMS).
- Kết nối tới SQL Server của bạn.
- Mở file database_WebBanHang.sql đi kèm gói này.
- Nhấn Execute.
- Script tạo database WebBanHang, các bảng, cột thông tin người nhận và dữ liệu sản phẩm mẫu.
- Nếu đã có database và dữ liệu, script không xóa dữ liệu sản phẩm hiện tại.

2. KIỂM TRA TÀI KHOẢN KẾT NỐI
Mở file:
WebBanHang/src/main/java/connect/DBConnection.java

Cấu hình mặc định:
- Server: localhost
- Port: 1433
- Database: WebBanHang
- Login: shopuser
- Password: 123456

Các giá trị trên phải khớp với SQL Server của bạn. Nếu bạn dùng tài khoản SQL Server khác,
hãy sửa user/password trong DBConnection.java. SQL Server cần bật TCP/IP và SQL Server
Authentication nếu bạn dùng tài khoản SQL login. Sau khi thay đổi, khởi động lại SQL Server
service nếu có thay đổi cấu hình mạng.

Lưu ý: tài khoản shopuser/123456 chỉ là giá trị mẫu cho bài tập. Không dùng mật khẩu mẫu
cho hệ thống triển khai thực tế.

3. IMPORT VÀO ECLIPSE
- Giải nén WebBanHang_ShopPhatAn_HoanThien.zip.
- Mở Eclipse.
- Chọn File > Import.
- Chọn General > Existing Projects into Workspace > Next.
- Chọn Select archive file nếu bạn muốn import từ file ZIP, hoặc Select root directory
  rồi chọn thư mục WebBanHang sau khi giải nén.
- Chọn dự án WebBanHang > Finish.
- Trong Project Explorer, nhấn chuột phải dự án > Properties > Targeted Runtimes.
- Đánh dấu Apache Tomcat v9.0. Nếu chưa có, cài Tomcat 9 và thêm server trong Eclipse.
- Đảm bảo JDK đã được cấu hình trong Window > Preferences > Java > Installed JREs.

4. KIỂM TRA DRIVER JDBC
Trong dự án phải có file:
src/main/webapp/WEB-INF/lib/mssql-jdbc-13.4.0.jre11.jar

File này đã được giữ trong gói. Nếu Eclipse báo lỗi thư viện:
- Nhấn chuột phải dự án > Build Path > Configure Build Path.
- Mở Libraries và kiểm tra JDBC JAR.
- Chọn Project > Clean để biên dịch lại.

5. CHẠY WEBSITE
- Nhấn chuột phải dự án > Run As > Run on Server.
- Chọn Apache Tomcat v9.0 > Finish.
- Mở địa chỉ thường dùng:
  http://localhost:8080/WebBanHang/home
  (Nếu context path khác, thay WebBanHang bằng tên context của bạn.)

CHỨC NĂNG ĐÃ HOÀN THIỆN
- Hiển thị danh sách sản phẩm lấy từ SQL Server.
- Tìm kiếm theo tên hoặc mô tả.
- Thêm sản phẩm vào giỏ hàng.
- Tăng/giảm số lượng, xóa sản phẩm khỏi giỏ.
- Kiểm tra số lượng tồn kho cơ bản.
- Nhập tên, số điện thoại và địa chỉ người nhận.
- Lưu đơn hàng và chi tiết đơn hàng trong một transaction.
- Trừ tồn kho khi đơn hàng được lưu thành công.
- Hiển thị mã đơn hàng sau khi đặt hàng thành công.
- Giao diện responsive cho máy tính và điện thoại.

NẾU GẶP LỖI
- HTTP 404: kiểm tra context path và URL /home.
- Lỗi đăng nhập SQL: kiểm tra tài khoản trong DBConnection.java.
- Connection refused: kiểm tra SQL Server service, TCP/IP và port 1433.
- Không tìm thấy driver: kiểm tra file JDBC trong WEB-INF/lib.
- Lỗi thiếu cột TenKhachHang/SoDienThoai/DiaChi: chạy lại database_WebBanHang.sql bằng SSMS.
- Trang không có sản phẩm: kiểm tra database WebBanHang, bảng SanPham và cửa sổ Console của Eclipse.

Ghi chú:
Gói này được chỉnh sửa dựa trên mã nguồn bạn gửi. Cần chạy thử trong môi trường SQL Server/Tomcat
trên máy của bạn để xác nhận thông tin kết nối, vì mình không truy cập trực tiếp được SQL Server
cục bộ của bạn từ đây.
