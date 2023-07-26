package controller;

import functionUtils.Function;
import dal.UserDAO;
import jakarta.servlet.http.HttpServlet;
import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import model.User;

/**
 * Servlet implementation class NewPassword
 */
@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("newPassword.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String newPassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        UserDAO ud = new UserDAO();
        Function f = new Function();
        RequestDispatcher dispatcher = null;
        if (user == null) {
            request.setAttribute("message", "Change reset password fail!");
            request.setAttribute("isModifyable", false);
        }
        if (user != null && newPassword != null && confPassword != null && newPassword.equals(confPassword)) {
            user.setPassword(f.hash(newPassword));
            Timestamp updateTime = Timestamp.valueOf(LocalDateTime.now());
            user.setUpdatedAt(updateTime);
            user.setUpdatedBy(user.getId());
            ud.update(user, user.getId());
            session.removeAttribute("user");
            response.sendRedirect("login");
        }else{
            request.getRequestDispatcher("newPassword.jsp").forward(request, response);
        }
    }

}
