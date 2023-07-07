package controller;

import functionUtils.Function;
import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

/**
 * Servlet implementation class ForgotPassword
 */
@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        //get information user
        String account = request.getParameter("account");
        String captchaValue = (String) session.getAttribute("captchaValue");
        String captchaInput = request.getParameter("captcha");

        UserDAO ud = new UserDAO();
        String messageErr;
        boolean success = true;

        try {
            if (ud.isAccountAvailable(account)) {
                success = false;
                messageErr = "Account does not exist!";
                request.setAttribute("accountMessageErr", messageErr);
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);

            } else {
                if (!captchaValue.equals(captchaInput)) {
                    success = false;
                    messageErr = "Captcha is not correct!";
                    request.setAttribute("captchaMessageErr", messageErr);
                    request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);

                } else {
                    if (success = true) {
                        Function f = new Function();
                        User user = ud.getUserbyAccount(account);
                        String token = (String) session.getAttribute("optValue");
                        if (token == null || token.isEmpty()) {
                            session.setAttribute("user", user);
                            token = f.tokenGenerate();
                            String tokenValue = token;
                            Thread thread = new Thread() {
                                @Override
                                public void run() {
                                    f.resetPasswordMail(user.getEmail(), tokenValue);
                                }
                            };
                            thread.start();
                            session.setAttribute("optValue", tokenValue);
                        }
                        request.getRequestDispatcher("EnterOtp.jsp").forward(request, response);
                    } else {
                        request.setAttribute("account", account);
                        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
