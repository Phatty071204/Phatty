/*
    SHOP PHAT AN - SQL SERVER
    Chạy file này bằng SQL Server Management Studio (SSMS).
    Có thể chạy lại để bổ sung bảng/cột còn thiếu; dữ liệu sản phẩm mẫu
    chỉ được thêm khi bảng SanPham đang trống.
*/
IF DB_ID(N'WebBanHang') IS NULL
    CREATE DATABASE WebBanHang;
GO
USE WebBanHang;
GO

IF OBJECT_ID(N'dbo.SanPham', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.SanPham (
        MaSP INT IDENTITY(1,1) PRIMARY KEY,
        TenSP NVARCHAR(100) NOT NULL,
        Gia DECIMAL(18,0) NOT NULL CHECK (Gia >= 0),
        SoLuong INT NOT NULL CHECK (SoLuong >= 0),
        HinhAnh NVARCHAR(255) NULL,
        MoTa NVARCHAR(255) NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.DonHang', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.DonHang (
        MaDH INT IDENTITY(1,1) PRIMARY KEY,
        NgayDat DATETIME NOT NULL DEFAULT GETDATE(),
        TongTien DECIMAL(18,0) NOT NULL,
        TrangThai NVARCHAR(50) NOT NULL DEFAULT N'Đã đặt',
        TenKhachHang NVARCHAR(100) NULL,
        SoDienThoai NVARCHAR(20) NULL,
        DiaChi NVARCHAR(255) NULL
    );
END;
GO

IF COL_LENGTH('dbo.DonHang', 'TenKhachHang') IS NULL
    ALTER TABLE dbo.DonHang ADD TenKhachHang NVARCHAR(100) NULL;
IF COL_LENGTH('dbo.DonHang', 'SoDienThoai') IS NULL
    ALTER TABLE dbo.DonHang ADD SoDienThoai NVARCHAR(20) NULL;
IF COL_LENGTH('dbo.DonHang', 'DiaChi') IS NULL
    ALTER TABLE dbo.DonHang ADD DiaChi NVARCHAR(255) NULL;
GO

IF OBJECT_ID(N'dbo.ChiTietDonHang', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ChiTietDonHang (
        MaCT INT IDENTITY(1,1) PRIMARY KEY,
        MaDH INT NOT NULL,
        MaSP INT NOT NULL,
        SoLuong INT NOT NULL CHECK (SoLuong > 0),
        DonGia DECIMAL(18,0) NOT NULL,
        ThanhTien DECIMAL(18,0) NOT NULL,
        CONSTRAINT FK_ChiTietDonHang_DonHang FOREIGN KEY (MaDH) REFERENCES dbo.DonHang(MaDH),
        CONSTRAINT FK_ChiTietDonHang_SanPham FOREIGN KEY (MaSP) REFERENCES dbo.SanPham(MaSP)
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.SanPham)
BEGIN
    INSERT INTO dbo.SanPham (TenSP, Gia, SoLuong, HinhAnh, MoTa)
    VALUES
    (N'Áo thun nam basic', 120000, 30, N'ao-thun.jpg', N'Áo thun cotton thoáng mát, dễ phối đồ'),
    (N'Áo sơ mi trắng', 180000, 20, N'ao-so-mi.jpg', N'Áo sơ mi lịch sự, phù hợp đi học và đi làm'),
    (N'Áo khoác jean', 350000, 15, N'ao-khoac-jean.jpg', N'Áo khoác jean trẻ trung, cá tính'),
    (N'Quần jean nam', 300000, 18, N'quan-jean.jpg', N'Quần jean form đẹp, dễ mặc'),
    (N'Quần short kaki', 160000, 25, N'quan-short.jpg', N'Quần short thoải mái, phù hợp đi chơi'),
    (N'Mũ thời trang', 90000, 40, N'mu.jpg', N'Mũ lưỡi trai đơn giản, năng động');
END;
GO

SELECT * FROM dbo.SanPham;
SELECT * FROM dbo.DonHang ORDER BY MaDH DESC;
SELECT * FROM dbo.ChiTietDonHang ORDER BY MaCT DESC;
GO
