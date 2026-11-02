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
<html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Đặt hàng | Shop Phát An</title><link rel="stylesheet" href="<%= request.getContextPath() %>/style.css"></head>
<body>
<header class="simple-header"><a class="brand" href="<%= request.getContextPath() %>/home"><span class="brand-mark">PA</span><span>SHOP PHÁT AN<small>THỜI TRANG MỖI NGÀY</small></span></a><a class="text-link" href="<%= request.getContextPath() %>/cart.jsp">← Quay lại giỏ hàng</a></header>
<main class="page-wrap">
    <div class="page-title"><span class="eyebrow">BƯỚC CUỐI</span><h1>Thông tin đặt hàng</h1><p>Nhập thông tin nhận hàng để hoàn tất đơn hàng.</p></div>
    <% String error = (String) request.getAttribute("error"); if (error != null) { %><div class="notice error"><%= esc(error) %></div><% } %>
    <div class="checkout-layout">
        <form class="form-panel" method="post" action="<%= request.getContextPath() %>/checkout">
            <h2>Thông tin người nhận</h2>
            <label for="customerName">Họ và tên</label><input id="customerName" name="customerName" required maxlength="100" value="<%= esc(request.getParameter("customerName")) %>" placeholder="Nhập họ tên người nhận">
            <label for="phone">Số điện thoại</label><input id="phone" name="phone" required maxlength="16" pattern="[0-9+ .()\-]{9,16}" value="<%= esc(request.getParameter("phone")) %>" placeholder="Ví dụ: 09xxxxxxxx">
            <label for="address">Địa chỉ nhận hàng</label><textarea id="address" name="address" rows="3" required maxlength="255" placeholder="Số nhà, đường, phường/xã, tỉnh/thành"><%= esc(request.getParameter("address")) %></textarea>
            <button class="button button-primary full-button" type="submit">Xác nhận đặt hàng →</button>
            <p class="secure-note">Đây là website học tập; hiện chưa tích hợp thanh toán trực tuyến.</p>
        </form>
        <aside class="summary-panel">
            <h2>Đơn hàng của bạn</h2>
            <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                double total = 0;
                if (cart != null) for (CartItem item : cart) { total += item.getThanhTien();
            %><div class="checkout-item"><span><%= esc(item.getSanPham().getTenSP()) %> <small>× <%= item.getSoLuong() %></small></span><b><%= String.format("%,.0f", item.getThanhTien()) %> đ</b></div><% } %>
            <div class="summary-total"><span>Tổng cộng</span><strong><%= String.format("%,.0f", total) %> đ</strong></div>
        </aside>
    </div>
</main><footer class="site-footer"><p>© 2026 Shop Phát An</p></footer>
</body></html>
