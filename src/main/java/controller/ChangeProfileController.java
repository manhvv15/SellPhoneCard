/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import functionUtils.Function;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * @author tuana
 */
@WebServlet("/changeProfile")
public class ChangeProfileController extends HttpServlet {

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
            out.println("<title>Servlet changeProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet changeProfile at " + request.getContextPath() + "</h1>");
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
        User user = (User) session.getAttribute("user");
        boolean isAdmin = false;
        if (session.getAttribute("isAdmin") != null) {
            isAdmin = (boolean) session.getAttribute("isAdmin");
        }
        if (isAdmin) {
            request.getRequestDispatcher("admin/user.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("profile.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPhonenumber = request.getParameter("phone-number");
        HttpSession session = request.getSession();
        Timestamp updateTime = Timestamp.valueOf(LocalDateTime.now());
        User user = (User) session.getAttribute("user");
        String oldPassword = request.getParameter("old-password");
        String newPassword = request.getParameter("new-password");
        String rePassword = request.getParameter("re-type-password");
        String option = request.getParameter("option");
        boolean isAdmin = (session.getAttribute("isAdmin") != null) ? ((boolean) session.getAttribute("isAdmin")) : false;
        UserDAO ud = new UserDAO();
        Function f = new Function();
        if (option.equals("changePassword")) {
            if (f.hash(oldPassword).equals(user.getPassword())) {
                if (rePassword.equals(newPassword)) {
                    user.setPassword(f.hash(newPassword));
                    user.setUpdatedAt(updateTime);
                    user.setUpdatedBy(user.getId());
                    ud.update(user, user.getId());
                    session.setAttribute("user", user);
                    request.setAttribute("message", "Cập nhật thành công!");
                } else {
                    String rePasswordErr = "Mật khẩu không trùng khớp";
                    request.setAttribute("rePasswordErr", rePasswordErr);
                }
            } else {
                String oldPasswordErr = "Mật khẩu không đúng";
                request.setAttribute("oldPasswordErr", oldPasswordErr);
            }
        } else {
            user.setPhoneNumber(newPhonenumber);
            user.setUpdatedAt(updateTime);
            user.setUpdatedBy(user.getId());
            ud.update(user, user.getId());
            session.setAttribute("user", user);
            request.setAttribute("message", "Cập nhật thành công!");
        }
        if (isAdmin) {
            request.getRequestDispatcher("admin/user.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
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