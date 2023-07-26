/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Transactions;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author hp
 */
public class TransactionsController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TransactionsController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TransactionsController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            request.getRequestDispatcher("login").forward(request, response);
        } else {
            boolean isAdmin = false;
            if (session.getAttribute("isAdmin") != null) {
                isAdmin = (boolean) session.getAttribute("isAdmin");
            }
            String type = "";
            String search = "";
            int page = 1;
            String status = "";
            if (isAdmin) {
                request.getRequestDispatcher("/admin/transaction.jsp").forward(request, response);
            } else {
                List<Transactions> list = new ArrayList<>();
                User u = (User) session.getAttribute("user");
                User user = DAO.userDAO.getUserById(u.getId());
                session.setAttribute("user", user);
                type = request.getParameter("type");
                status = request.getParameter("status");
                search = request.getParameter("search");
                String page_raw = request.getParameter("page");
                if (page_raw != null && !page_raw.equals("1")) {
                    page = Integer.parseInt(page_raw);
                }

                if (type == null) {
                    type = "";
                }
                if (status == null) {
                    status = "";
                }
                if (search == null) {
                    search = "";
                }

                list = DAO.transactionsDAO.searchTransactions(type, status, search, user.getId(), (page - 1) * 10);

                long totalTransactions = DAO.transactionsDAO.getTotalTransactions(type, status, search, user.getId());
                double totalPage = Math.ceil((double) totalTransactions / 10);
                request.setAttribute("pageNumber", page);
                request.setAttribute("totalPageNumbers", totalPage);
                request.setAttribute("list", list);
                request.getRequestDispatcher("transactions.jsp").forward(request, response);
            }

        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        TransactionsDAO td = new TransactionsDAO();
//        Transactions tran = new Transactions();
//        User u = new User();
//        List<Transactions> listDetail = td.getDetailHistory(tran.getId());
//        request.setAttribute("listDetail", listDetail);
//        request.getRequestDispatcher("transactions").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
