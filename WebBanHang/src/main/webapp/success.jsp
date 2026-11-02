<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Đặt hàng thành công | Shop Phát An</title><link rel="stylesheet" href="<%= request.getContextPath() %>/style.css"></head>
<body>
<header class="simple-header"><a class="brand" href="<%= request.getContextPath() %>/home"><span class="brand-mark">PA</span><span>SHOP PHÁT AN<small>THỜI TRANG MỖI NGÀY</small></span></a><a class="text-link" href="<%= request.getContextPath() %>/home">Trang chủ</a></header>
<main class="page-wrap"><section class="success-card"><div class="success-icon">✓</div><span class="eyebrow">HOÀN TẤT</span><h1>Đặt hàng thành công!</h1><p>Cảm ơn bạn đã mua sắm tại Shop Phát An. Thông tin đơn hàng đã được ghi nhận.</p>
<% Integer orderId = (Integer) session.getAttribute("maDH"); if (orderId != null && orderId > 0) { %><div class="order-number">Mã đơn hàng <strong>#<%= orderId %></strong></div><% } %>
<a class="button button-primary" href="<%= request.getContextPath() %>/home">Tiếp tục mua sắm</a></section></main>
<footer class="site-footer"><p>© 2026 Shop Phát An</p></footer>
</body></html>
