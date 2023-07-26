package controller;

import com.google.gson.Gson;
import dal.*;
import functionUtils.ScanTransaction;
import service.ScheduleScanTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@WebServlet(name = "BuyCardController", urlPatterns = "/buyCard")
public class BuyCardController extends HttpServlet {
    private final static ExecutorService executorService = Executors.newSingleThreadExecutor();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String price_raw = request.getParameter("price");
        String supplier = request.getParameter("supplier");
        String quantity_raw = request.getParameter("quantity");
        String note = request.getParameter("noteValue");
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("/login");
        } else {
            response.setContentType("application/json");

            Gson gson = new Gson();
            Map<String, String> map = new HashMap<>();
            int quantity = 0;
            int price = 0;
            if (quantity_raw != null) {
                quantity = Integer.parseInt(quantity_raw);
            }
            if (price_raw != null) {
                price = Integer.parseInt(price_raw);
            }
            if (note == null) {
                note = "";
            }
            String finalNote = note;

            if (user.getBalance() < (quantity * price)) {
                map.put("message", "Số dư trong tài khoản không đủ để thực hiện giao dịch vui lòng nạp tiền thêm!");
            } else {
                Product product = DAO.productDAO.findProductByPriceAndSupplier(price, Integer.parseInt(supplier));

                // Create new order and add order and order_detail to database
                Order newOrder = new Order();
                LocalDateTime orderCreatedAt = LocalDateTime.now();
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String time = orderCreatedAt.format(dtf);
                newOrder.setUser(user);
                newOrder.setStatus("Thất bại");
                newOrder.setTotalAmount(quantity * price);
                newOrder.setDelete(false);
                newOrder.setCreatedAt(Timestamp.valueOf(time));
                newOrder.setCreatedBy(user);
                newOrder.setProduct(product);
                newOrder.setQuantity(quantity);


                //Create new transaction
                Transactions transactions = new Transactions().builder()
                        .user(user)
                        .money(quantity * price)
                        .createAt(Timestamp.valueOf(time))
                        .createBy(user)
                        .note(finalNote)
                        .status(false)
                        .orderId(DAO.orderDAO.add(newOrder).getId())
                        .type(false)
                        .build();
                DAO.transactionsDAO.insert(transactions);
                map.put("message", "Giao dịch đang được xử lý vui lòng chờ");
            }
            executorService.execute(new ScanTransaction());
            response.getWriter().write(gson.toJson(map));
            response.getWriter().flush();
        }
    }
    @Override
    public void destroy() {
        super.destroy();
        executorService.shutdown();
    }
}
