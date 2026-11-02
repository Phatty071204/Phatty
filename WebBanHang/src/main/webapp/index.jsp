<%@ page import="java.util.List" %>
<%@ page import="model.SanPham" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }
    private String iconFor(String name) {
        if (name == null) return "👕";
        String n = name.toLowerCase();
        if (n.contains("quần")) return "👖";
        if (n.contains("mũ")) return "🧢";
        if (n.contains("khoác")) return "🧥";
        if (n.contains("sơ mi")) return "👔";
        return "👕";
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shop Phát An | Thời trang mỗi ngày</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<header class="site-header">
    <div class="topbar">
        <a class="brand" href="<%= request.getContextPath() %>/home"><span class="brand-mark">PA</span><span>SHOP PHÁT AN<small>THỜI TRANG MỖI NGÀY</small></span></a>
        <form class="search-form" action="<%= request.getContextPath() %>/home" method="get">
            <input type="search" name="keyword" value="<%= esc((String)request.getAttribute("keyword")) %>" placeholder="Tìm áo, quần, phụ kiện..." aria-label="Tìm sản phẩm">
            <button type="submit">Tìm kiếm</button>
        </form>
        <a class="cart-link" href="<%= request.getContextPath() %>/cart.jsp">🛒 Giỏ hàng</a>
    </div>
</header>
<main>
    <section class="hero">
        <div class="hero-content">
            <span class="eyebrow">BỘ SƯU TẬP MỚI</span>
            <h1>Mặc đẹp theo<br>cách của bạn.</h1>
            <p>Những lựa chọn thời trang đơn giản, năng động và dễ phối mỗi ngày.</p>
            <a class="button button-light" href="#products">Khám phá sản phẩm <span>→</span></a>
        </div>
        <div class="hero-art" aria-hidden="true"><span class="hero-circle"></span><span class="hero-shirt">👕</span><span class="hero-tag">PHÁT AN<br>COLLECTION</span></div>
    </section>

    <section class="benefits">
        <div><span>🚚</span><p><b>Giao hàng tiện lợi</b><small>Đặt hàng nhanh chóng</small></p></div>
        <div><span>✦</span><p><b>Chọn đồ dễ dàng</b><small>Danh mục gọn gàng</small></p></div>
        <div><span>♡</span><p><b>Hỗ trợ tận tâm</b><small>Luôn sẵn sàng hỗ trợ</small></p></div>
    </section>

    <section class="products-section" id="products">
        <div class="section-heading">
            <div><span class="eyebrow">DÀNH RIÊNG CHO BẠN</span><h2>Sản phẩm nổi bật</h2><p>Chọn món đồ phù hợp với phong cách của bạn.</p></div>
            <span class="product-count">Bộ sưu tập Shop Phát An</span>
        </div>

        <%
            String message = request.getParameter("message");
            if ("invalid".equals(message) || "notfound".equals(message)) {
        %><div class="notice error">Sản phẩm không hợp lệ hoặc không còn tồn tại.</div><%
            } else if ("outofstock".equals(message)) {
        %><div class="notice error">Sản phẩm hiện đã hết hàng.</div><%
            } else if ("stocklimit".equals(message)) {
        %><div class="notice">Bạn đã chọn số lượng tối đa còn trong kho.</div><%
            } else if ("success".equals(request.getParameter("added"))) {
        %><div class="notice success">✓ Đã thêm sản phẩm vào giỏ hàng.</div><% } %>

        <div class="product-grid">
        <%
            List<SanPham> products = (List<SanPham>) request.getAttribute("danhSachSanPham");
            if (products != null && !products.isEmpty()) {
                for (SanPham sp : products) {
        %>
            <article class="product-card">
                <div class="product-art"><span class="product-emoji"><%= iconFor(sp.getTenSP()) %></span><span class="product-badge">PHÁT AN</span></div>
                <div class="product-info">
                    <p class="product-category">THỜI TRANG</p>
                    <h3><%= esc(sp.getTenSP()) %></h3>
                    <p class="product-description"><%= esc(sp.getMoTa()) %></p>
                    <div class="product-bottom">
                        <span class="price"><%= String.format("%,.0f", sp.getGia()) %><small>đ</small></span>
                        <% if (sp.getSoLuong() > 0) { %>
                            <span class="stock">Còn <%= sp.getSoLuong() %></span>
                        <% } else { %><span class="out-stock">Hết hàng</span><% } %>
                    </div>
                    <% if (sp.getSoLuong() > 0) { %>
                    <a class="button button-primary add-button" href="<%= request.getContextPath() %>/add-to-cart?id=<%= sp.getMaSP() %>">Thêm vào giỏ <span>＋</span></a>
                    <% } else { %><button class="button button-disabled" disabled>Hết hàng</button><% } %>
                </div>
            </article>
        <%
                }
            } else {
        %>
            <div class="empty-state"><span>🔎</span><h3>Chưa tìm thấy sản phẩm</h3><p>Thử từ khóa khác hoặc quay lại danh sách sản phẩm.</p><a href="<%= request.getContextPath() %>/home" class="button button-primary">Xem tất cả sản phẩm</a></div>
        <% } %>
        </div>
    </section>
</main>
<footer class="site-footer"><a class="brand footer-brand" href="<%= request.getContextPath() %>/home"><span class="brand-mark">PA</span><span>SHOP PHÁT AN<small>THỜI TRANG MỖI NGÀY</small></span></a><p>Đơn giản trong lựa chọn, tự tin trong phong cách.</p><small>© 2026 Shop Phát An. Website phục vụ mục đích học tập.</small></footer>
</body>
</html>
