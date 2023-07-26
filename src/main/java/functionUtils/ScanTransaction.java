package functionUtils;

import dal.DAO;
import model.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class ScanTransaction implements Runnable{
    @Override
    public void run() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        List<Transactions> transactionsList = DAO.transactionsDAO.findPendingTransaction();
        for (Transactions transaction : transactionsList) {

            // Get order and user from transaction
            Order order = DAO.orderDAO.getOrderById(transaction.getOrderId());
            User user = transaction.getUser();
            if (transaction.isType()) {
                // Create subject and content to send mail
                String subject = "[THÔNG BÁO] Hoạt động nạp tiền";
                String content = "Giao dịch nạp tiền vào lúc " +
                        transaction.getCreateAt().toLocalDateTime().format(dtf) +
                        " đã thành công vui lòng vào trang web và tận hưởng dịch vụ chúng tôi";

                Function f = new Function();
                f.send(user.getEmail(), subject, content);

                // Update balance
                user = DAO.userDAO.getUserById(user.getId());
                user.setBalance(user.getBalance() + transaction.getMoney());
                DAO.userDAO.update(user, user.getId());

                // Update Transaction
                transaction.setStatus(true);
                transaction.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                transaction.setUpdatedBy(DAO.userDAO.getUserById(1));
                DAO.transactionsDAO.update(transaction);

                Notice newNotice = new Notice().builder()
                        .subject("Thông báo!")
                        .content("Giao dịch nạp tiền " +
                                "lúc " + transaction.getCreateAt().toLocalDateTime().format(dtf) +
                                " thành công")
                        .createdAt(Timestamp.valueOf(LocalDateTime.now()))
                        .createdBy(DAO.userDAO.getUserById(1))
                        .isDelete(false)
                        .seen(false)
                        .user(user)
                        .build();
                DAO.noticeDAO.insert(newNotice);
            } else {
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
                    product.setQuantity(product.getQuantity() - order.getQuantity());
                    product.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));
                    product.setUpdatedBy(user);
                    DAO.productDAO.update(product, product.getId());

                    // Update balance
                    user = DAO.userDAO.getUserById(user.getId());
                    user.setBalance(user.getBalance() - transaction.getMoney());
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
    }
}
