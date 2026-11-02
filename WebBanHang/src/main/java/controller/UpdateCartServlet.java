package controller;

import java.io.IOException;
import java.util.List;
import dao.SanPhamDAO;
import model.CartItem;
import model.SanPham;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            for (CartItem item : cart) {
                if (item.getSanPham().getMaSP() == id) {
                    if ("minus".equals(action)) item.setSoLuong(item.getSoLuong() - 1);
                    if ("plus".equals(action)) {
                        SanPham fresh = new SanPhamDAO().getSanPhamById(id);
                        if (fresh != null && item.getSoLuong() < fresh.getSoLuong()) {
                            item.setSoLuong(item.getSoLuong() + 1);
                            item.setSanPham(fresh);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/cart.jsp?message=stocklimit");
                            return;
                        }
                    }
                    break;
                }
            }
            cart.removeIf(item -> item.getSoLuong() <= 0);
            session.setAttribute("cart", cart);
        }
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
}
