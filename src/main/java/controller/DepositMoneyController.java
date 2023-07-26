package controller;

import dal.DAO;
import functionUtils.ScanTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Transactions;
import model.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@WebServlet(name = "DepositMoneyController", value = "/deposit")
public class DepositMoneyController extends HttpServlet {
    private final ExecutorService executorService = Executors.newSingleThreadExecutor();

    @Override
    public void destroy() {
        super.destroy();
        executorService.shutdown();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String amount = request.getParameter("vnp_Amount");
        String code = request.getParameter("vnp_ResponseCode");

        if (code.equals("00")) {
            long money = Long.parseLong(amount)/100;
            // Insert new transaction
            Transactions transaction = new Transactions().builder()
                    .user(user)
                    .money((int) money)
                    .type(true)
                    .status(false)
                    .createAt(Timestamp.valueOf(LocalDateTime.now()))
                    .createBy(user)
                    .build();
            DAO.transactionsDAO.insert(transaction);

            executorService.execute(new ScanTransaction());
            response.sendRedirect("/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}