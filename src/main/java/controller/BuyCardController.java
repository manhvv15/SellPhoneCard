package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.*;
import functionUtils.Function;
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
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

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
            response.sendRedirect("logout");
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
            int finalQuantity = quantity;
            int finalPrice = price;
            if (note == null) {
                note = "";
            }
            String finalNote = note;

            if (user.getBalance() < (finalQuantity * finalPrice)) {
                map.put("message", "Số dư trong tài khoản không đủ để thực hiện giao dịch vui lòng nạp tiền thêm!");
            } else {
                Product product = DAO.productDAO.findProductByPriceAndSupplier(finalPrice, Integer.parseInt(supplier));

                // Create new order and add order and order_detail to database
                Order newOrder = new Order();
                LocalDateTime orderCreatedAt = LocalDateTime.now();
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String time = orderCreatedAt.format(dtf);
                newOrder.setUser(user);
                newOrder.setStatus("Thất bại");
                newOrder.setTotalAmount(finalQuantity * finalPrice);
                newOrder.setDelete(false);
                newOrder.setCreatedAt(Timestamp.valueOf(time));
                newOrder.setCreatedBy(user);
                newOrder.setProduct(product);
                newOrder.setQuantity(quantity);


                //Create new transaction
                Transactions transactions = new Transactions().builder()
                        .user(user)
                        .money(finalQuantity * finalPrice)
                        .createAt(Timestamp.valueOf(time))
                        .createBy(user)
                        .note(finalNote)
                        .status(false)
                        .orderId(DAO.orderDAO.add(newOrder).getId())
                        .type(false)
                        .build();
                new TransactionsDAO().insert(transactions);
                map.put("message", "Giao dịch đang được xử lý vui lòng chờ");
            }
            Runnable runnable = new Runnable() {
                @Override
                public void run() {
                    try {
                        TimeUnit.MILLISECONDS.sleep(1000);
                    } catch (InterruptedException e) {
                        throw new RuntimeException(e);
                    }
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    List<Transactions> transactionsList = DAO.transactionsDAO.findPendingTransaction();
                    for (Transactions transaction : transactionsList) {

                        // Get order and user from transaction
                        Order order = DAO.orderDAO.getOrderById(transaction.getOrderId());
                        User user = transaction.getUser();

                        if (order.getQuantity() > order.getProduct().getQuantity()) {

                            Notice newNotice = new Notice().builder()
                                    .subject("Thông báo!")
                                    .content("Giao dịch mua hàng " +
                                            "lúc " + transaction.getCreateAt().toLocalDateTime().format(dtf) +
                                            " thất bại. Số lượng không đủ, chỉ còn " +
                                            order.getProduct().getQuantity() + " sản phẩm!")
                                    .createdAt(Timestamp.valueOf(LocalDateTime.now()))
                                    .createdBy(DAO.userDAO.getUserById(1))
                                    .isDelete(false)
                                    .seen(false)
                                    .user(user)
                                    .build();
                            DAO.noticeDAO.insert(newNotice);

                            // Update transaction
                            transaction.setStatus(true);
                            transaction.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                            transaction.setUpdatedBy(DAO.userDAO.getUserById(1));
                            DAO.transactionsDAO.update(transaction);

                            // Update order
                            order.setStatus("Thất bại");
                            order.setDelete(true);
                            order.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                            order.setUpdatedBy(DAO.userDAO.getUserById(1));
                            DAO.orderDAO.update(order);
                        } else {

                            // Get list storage with quantity and product
                            List<Storage> listStorage = DAO.storageDAO.getListStorageWithNearestExpiredAt(order.getProduct().getId(), order.getQuantity());
                            LocalDateTime now = LocalDateTime.now();
                            for (Storage storage : listStorage) {
                                storage.setUpdatedAt(Timestamp.valueOf(now));
                                storage.setUpdatedBy(DAO.userDAO.getUserById(1));
                                storage.setUsed(true);

                                // Add to order detail
                                DAO.orderDetailDAO.add(order, storage);
                            }

                            // Create subject and content to send mail
                            String subject = "[THÔNG BÁO] Thông tin các thẻ điện thoại mà bạn đã mua";
                            String content = "Cảm ơn bạn đã mua thẻ của chúng tôi dưới đây là tên nhà phát hành, các số seri và mã thẻ cũng như ngày hêt hạn của chúng:\n";
                            for (int i = 0; i < listStorage.size(); i++) {
                                // Update each storage set isUsed to true
                                listStorage.get(i).setUsed(true);
                                listStorage.get(i).setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                                listStorage.get(i).setUpdatedBy(user);
                                DAO.storageDAO.update(listStorage.get(i));

                                // Add phone card's info to content in mail
                                content += ((i + 1) + ". " + listStorage.get(i).getProduct().getSupplier().getName() +
                                        " - " + listStorage.get(i).getSerialNumber() + " - " +
                                        listStorage.get(i).getCardNumber() + " - " +
                                        listStorage.get(i).getExpiredAt() + "\n");
                            }

                            Function f = new Function();
                            f.send(user.getEmail(), subject, content);

                            // Minus quantity in product
                            Product product = order.getProduct();
                            product.setQuantity(product.getQuantity() - finalQuantity);
                            product.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                            product.setUpdatedBy(user);
                            DAO.productDAO.update(product, product.getId());

                            // Update balance
                            user = DAO.userDAO.getUserById(user.getId());
                            user.setBalance(user.getBalance() - (finalQuantity * finalPrice));
                            DAO.userDAO.update(user, user.getId());

                            // Update Order
                            order.setStatus("Thành công");
                            order.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                            order.setUpdatedBy(DAO.userDAO.getUserById(1));
                            DAO.orderDAO.update(order);

                            // Update Transaction
                            transaction.setStatus(true);
                            transaction.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                            transaction.setUpdatedBy(DAO.userDAO.getUserById(1));
                            DAO.transactionsDAO.update(transaction);

                            Notice newNotice = new Notice().builder()
                                    .subject("Thông báo!")
                                    .content("Giao dịch mua hàng " +
                                            "lúc " + transaction.getCreateAt().toLocalDateTime().format(dtf) +
                                            " thành công. Vui lòng mở email để xem chi tiết ")
                                    .createdAt(Timestamp.valueOf(LocalDateTime.now()))
                                    .createdBy(DAO.userDAO.getUserById(1))
                                    .isDelete(false)
                                    .seen(false)
                                    .user(user)
                                    .build();
                            DAO.noticeDAO.insert(newNotice);
                        }
                    }
                }
            };
            executorService.execute(runnable);
            response.getWriter().write(gson.toJson(map));
            response.getWriter().flush();
        }
    }
}
