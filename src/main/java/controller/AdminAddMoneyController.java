package controller;

import dal.AdminDAO;
import dal.DAO;
import dal.TransactionsDAO;
import dal.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Transactions;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminAddMoneyController", value = "/addmoney")
public class AdminAddMoneyController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        boolean isAdmin = false;
        if (session.getAttribute("isAdmin") != null) {
            isAdmin = (boolean) session.getAttribute("isAdmin");
        }
        if (isAdmin) {
            List<User> list;

            int  userId = Integer.parseInt(request.getParameter("userId"));
            User user  = DAO.userDAO.getUserById1(userId);
            request.setAttribute("user",user);
            request.getRequestDispatcher("admin/addmoney.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        Map<String, String> map = new HashMap<>();
        int  userId = Integer.parseInt(request.getParameter("userId"));
        int balance = Integer.parseInt(request.getParameter("balance"));
        String note = request.getParameter("note");
        if (note == null) {
            note = "";
        }
        String finalNote = note;
        AdminDAO addmoney = new AdminDAO();
        addmoney.AddMoneyUser(userId,balance);
        User user = DAO.userDAO.getUserById1(userId);
        Transactions transactions = new Transactions().builder()
                .user(user)
                .money(balance)
                .createAt(Timestamp.valueOf(LocalDateTime.now()))
                .createBy(admin)
                .note(finalNote)
                .status(true)
                .type(true)
                .build();
        new TransactionsDAO().insert(transactions);
        System.out.println("Insert new transaction success");
//        session.setAttribute("user", user);
        map.put("message", "Thực hiện giao dịch thành công vui lòng kiểm tra số dư của bạn!");

        response.sendRedirect("user");
    }
}