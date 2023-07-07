package controller;

import functionUtils.Function;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        //Get information from user
        String account = req.getParameter("account");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String captchaValue = (String) session.getAttribute("captchaValue");
        String captchaInput = req.getParameter("captcha");

        //Create new user data access object
        UserDAO ud = new UserDAO();
        String messageErr;
        boolean success = true;

        try {
            if (!ud.isAccountAvailable(account)) {
                success = false;
                messageErr = "Account has been used!";
                req.setAttribute("accountMessageErr", messageErr);
            }
            if (!ud.isEmailAvailable(email)) {
                success = false;
                messageErr = "Email has been used!";
                req.setAttribute("emailMessageErr", messageErr);
            }
            if (!captchaInput.equals(captchaValue)) {
                success = false;
                messageErr = "Captcha is not correct!";
                req.setAttribute("captchaMessageErr", messageErr);
            }
            if (success) {
                Function f = new Function();
                Timestamp time = Timestamp.valueOf(LocalDateTime.now());
                User newUser = new User(account, f.hash(password), email, 1, false, false, time);
                ud.add(newUser);
                User activeUser = ud.getUser(account, f.hash(password));
                session.setAttribute("user", activeUser);
                resp.sendRedirect("activeAccount");
            } else {
                req.setAttribute("account", account);
                req.setAttribute("password", password);
                req.setAttribute("email", email);
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
