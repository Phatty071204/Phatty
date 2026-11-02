package controller;

import java.io.IOException;
import java.util.List;
import dao.DonHangDAO;
import model.CartItem;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        String name = trim(request.getParameter("customerName"));
        String phone = trim(request.getParameter("phone"));
        String address = trim(request.getParameter("address"));

        if (name.isEmpty() || phone.isEmpty() || address.isEmpty()
                || !phone.matches("[0-9+ .()-]{9,16}")) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin và số điện thoại hợp lệ.");
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            return;
        }

        DonHangDAO dao = new DonHangDAO();
        int orderId = dao.taoDonHang(cart, name, phone, address);
        if (orderId <= 0) {
            request.setAttribute("error", "Chưa thể tạo đơn hàng. Hãy kiểm tra kết nối SQL Server và số lượng tồn kho rồi thử lại.");
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            return;
        }

        session.removeAttribute("cart");
        session.setAttribute("maDH", orderId);
        response.sendRedirect(request.getContextPath() + "/success.jsp");
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
