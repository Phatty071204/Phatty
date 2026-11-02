<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Giỏ hàng | Shop Phát An</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<header class="simple-header"><a class="brand" href="<%= request.getContextPath() %>/home"><span class="brand-mark">PA</span><span>SHOP PHÁT AN<small>THỜI TRANG MỖI NGÀY</small></span></a><a class="text-link" href="<%= request.getContextPath() %>/home">← Tiếp tục mua sắm</a></header>
<main class="page-wrap">
    <div class="page-title"><span class="eyebrow">ĐƠN HÀNG CỦA BẠN</span><h1>Giỏ hàng</h1><p>Kiểm tra sản phẩm trước khi đặt hàng.</p></div>
    <% if ("stocklimit".equals(request.getParameter("message"))) { %><div class="notice">Số lượng bạn chọn đã đạt giới hạn tồn kho.</div><% } %>
    <%
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double total = 0;
        if (cart != null && !cart.isEmpty()) {
    %>
    <div class="cart-layout">
        <section class="cart-panel">
            <div class="cart-table-wrap"><table class="cart-table">
                <thead><tr><th>Sản phẩm</th><th>Đơn giá</th><th>Số lượng</th><th>Thành tiền</th><th></th></tr></thead>
                <tbody>
                <% for (CartItem item : cart) { total += item.getThanhTien(); %>
                <tr>
                    <td><div class="cart-product"><span class="mini-art">👕</span><span><b><%= esc(item.getSanPham().getTenSP()) %></b><small>Mã SP: <%= item.getSanPham().getMaSP() %></small></span></div></td>
                    <td><%= String.format("%,.0f", item.getSanPham().getGia()) %> đ</td>
                    <td><div class="quantity"><a aria-label="Giảm số lượng" href="<%= request.getContextPath() %>/update-cart?id=<%= item.getSanPham().getMaSP() %>&action=minus">−</a><span><%= item.getSoLuong() %></span><a aria-label="Tăng số lượng" href="<%= request.getContextPath() %>/update-cart?id=<%= item.getSanPham().getMaSP() %>&action=plus">+</a></div></td>
                    <td class="line-total"><%= String.format("%,.0f", item.getThanhTien()) %> đ</td>
                    <td><a class="remove-link" href="<%= request.getContextPath() %>/remove-from-cart?id=<%= item.getSanPham().getMaSP() %>" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">Xóa</a></td>
                </tr>
                <% } %>
                </tbody>
            </table></div>
        </section>
        <aside class="summary-panel">
            <h2>Tóm tắt đơn hàng</h2><div class="summary-row"><span>Tạm tính</span><span><%= String.format("%,.0f", total) %> đ</span></div>
            <div class="summary-row"><span>Phí giao hàng</span><span>Trao đổi khi giao</span></div>
            <div class="summary-total"><span>Tổng cộng</span><strong><%= String.format("%,.0f", total) %> đ</strong></div>
            <a class="button button-primary full-button" href="<%= request.getContextPath() %>/checkout">Tiến hành đặt hàng →</a>
            <p class="secure-note">✓ Kiểm tra thông tin trước khi xác nhận đơn.</p>
        </aside>
    </div>
    <% } else { %>
        <div class="empty-cart"><span>🛒</span><h2>Giỏ hàng đang trống</h2><p>Hãy chọn vài món đồ bạn yêu thích nhé.</p><a class="button button-primary" href="<%= request.getContextPath() %>/home">Khám phá sản phẩm</a></div>
    <% } %>
</main>
<footer class="site-footer"><p>© 2026 Shop Phát An</p></footer>
</body></html>
