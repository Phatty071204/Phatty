package model;

public class DonHang {
    private int maDH;
    private String ngayDat;
    private double tongTien;
    private String trangThai;

    public DonHang() {
    }

    public DonHang(int maDH, String ngayDat, double tongTien, String trangThai) {
        this.maDH = maDH;
        this.ngayDat = ngayDat;
        this.tongTien = tongTien;
        this.trangThai = trangThai;
    }

    public int getMaDH() {
        return maDH;
    }

    public void setMaDH(int maDH) {
        this.maDH = maDH;
    }

    public String getNgayDat() {
        return ngayDat;
    }

    public void setNgayDat(String ngayDat) {
        this.ngayDat = ngayDat;
    }

    public double getTongTien() {
        return tongTien;
    }

    public void setTongTien(double tongTien) {
        this.tongTien = tongTien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
}