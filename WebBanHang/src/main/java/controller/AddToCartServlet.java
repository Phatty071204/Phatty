package controller;

import java.io.IOException;
import java.util.ArrayList;
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

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/home?message=invalid");
            return;
        }

        SanPham sp = new SanPhamDAO().getSanPhamById(id);
        if (sp == null) {
            response.sendRedirect(request.getContextPath() + "/home?message=notfound");
            return;
        }
        if (sp.getSoLuong() <= 0) {
            response.sendRedirect(request.getContextPath() + "/home?message=outofstock");
            return;
        }

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getSanPham().getMaSP() == id) {
                if (item.getSoLuong() < sp.getSoLuong()) item.setSoLuong(item.getSoLuong() + 1);
                else {
                    response.sendRedirect(request.getContextPath() + "/home?message=stocklimit");
                    return;
                }
                item.setSanPham(sp);
                found = true;
                break;
            }
        }
        if (!found) cart.add(new CartItem(sp, 1));
        session.setAttribute("cart", cart);
        response.sendRedirect(request.getContextPath() + "/home?added=success");
    }
}
