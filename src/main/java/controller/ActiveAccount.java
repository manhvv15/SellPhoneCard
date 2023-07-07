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

@WebServlet(name = "ActiveAccount", value = "/activeAccount")
public class ActiveAccount extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Function f = new Function();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String token = (String) session.getAttribute("optValue");
        if (token == null || token.isEmpty()) {
            token = f.tokenGenerate();
            String tokenValue = token;
            Thread thread = new Thread() {
                @Override
                public void run() {
                    f.authenEmail(user.getEmail(), tokenValue);
                }
            };
            thread.start();
            session.setAttribute("optValue", tokenValue);
        }
        request.getRequestDispatcher("activeAccount.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String tokenValue = (String) session.getAttribute("optValue");
        String tokenInput = request.getParameter("tokenInput");
        String option = request.getParameter("option");
        String captchaInput = request.getParameter("captchaInput");
        String captchaValue = (String) session.getAttribute("captchaValue");
        if (option.equals("confirm")) {
            if (captchaValue.equals(captchaInput)) {
                if (tokenValue != null && (!tokenValue.isEmpty()) && tokenValue.equals(tokenInput)) {
                    user.setActive(true);
                    UserDAO ud = new UserDAO();
                    ud.update(user, user.getId());
                    session.removeAttribute("captchaValue");
                    session.removeAttribute("optValue");
                    session.setAttribute("user", user);
                    response.sendRedirect("home");
                } else {
                    String tokenMessageErr = "Token is not correct! Please check again!";
                    request.setAttribute("tokenMessageErr", tokenMessageErr);
                    request.getRequestDispatcher("activeAccount.jsp").forward(request, response);
                }
            } else {
                String captchaMessageErr = "Captcha is not correct!";
                request.setAttribute("captchaMessageErr", captchaMessageErr);
                request.getRequestDispatcher("activeAccount.jsp").forward(request, response);
            }
        } else {
            doGet(request, response);
        }
    }
}
