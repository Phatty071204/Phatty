package controller;

import java.io.IOException;
import java.util.List;

import dao.SanPhamDAO;
import model.SanPham;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("keyword");
        SanPhamDAO dao = new SanPhamDAO();
        List<SanPham> products = (keyword != null && !keyword.trim().isEmpty())
                ? dao.searchSanPham(keyword) : dao.getAllSanPham();
        request.setAttribute("danhSachSanPham", products);
        request.setAttribute("keyword", keyword == null ? "" : keyword);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
