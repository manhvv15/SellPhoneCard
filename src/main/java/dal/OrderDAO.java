package dal;

import model.Order;
import model.Storage;
import model.Product;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public Order findOrderByTimeAndUser(int userId, String time) {

        try {
            String query = "select * from `order` where user = ? and createdAt = ? and isDelete = false;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, time);
            ps.executeQuery();
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                List<Storage> listStorage = DAO.orderDetailDAO.getListStorageBySearchProduct(rs.getLong("id"), "%");
                return new Order(rs.getLong("id"), DAO.userDAO.getUserById(rs.getInt("user")), rs.getString("status"), rs.getInt("totalAmount"),
                        DAO.productDAO.findProductById(rs.getInt("product")), rs.getInt("quantity"),
                        rs.getBoolean("isDelete"), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")), rs.getTimestamp("updatedAt"),
                        DAO.userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy")), listStorage);
            }
        } catch (SQLException e) {
            System.err.println("findOrderByTimeAndUser: " + e.getMessage());
        }

        return null;
    }

    public Order add(Order order) {
        try {
            String query = "insert into `order` (user, status, totalAmount, isDelete, createdAt, createdBy, product, quantity)\n" +
                    "value (?, ?, ?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = DAO.connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUser().getId());
            ps.setString(2, order.getStatus());
            ps.setInt(3, order.getTotalAmount());
            ps.setBoolean(4, order.isDelete());
            ps.setTimestamp(5, order.getCreatedAt());
            ps.setInt(6, order.getCreatedBy().getId());
            ps.setInt(7, order.getProduct().getId());
            ps.setInt(8, order.getQuantity());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return getOrderById(rs.getInt(1));
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO-add: " + e.getMessage());
        }
        return null;
    }

    public long totalOrder(String status, String search) {
        long result = 1;
        try {
            String sql = "select * from `order` where status like ? and isDelete = false";
            PreparedStatement ps = DAO.connection.prepareStatement(sql);
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            result = 0;
            while (rs.next()) {
                List<Storage> listStorage = DAO.orderDetailDAO.getListStorageBySearchProduct(rs.getLong("id"), search);
                if (listStorage.size() > 0) {
                    result += 1;
                }
            }

        } catch (SQLException e) {
            System.out.println("getAllOrder " + e.getMessage());
        }

        return result;
    }

    public long totalOrderByUser(String status, String search, int uid) {
        long result = 0;
        try {
            String sql = "select * from `order` where status like ? and isDelete = false and user = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, uid);
            ResultSet rs = ps.executeQuery();
            result = 0;
            while (rs.next()) {
                List<Storage> listStorage = DAO.orderDetailDAO.getListStorageBySearchProduct(rs.getLong("id"), search);
                if (listStorage.size() > 0) {
                    result += 1;
                }
            }

        } catch (SQLException e) {
            System.out.println("getAllOrder " + e.getMessage());
        }

        return result;
    }

    public List<Order> getAllOrder(String status, String search, int page) {
        List<Order> listOrder = new ArrayList<>();
        try {
            String sql = "select distinct od.`order`, o.* from `order` o\n" +
                    "right join order_detail od on o.id = od.`order`\n" +
                    "where status like ? and isDelete = false " +
                    "limit 10 offset ?";
            PreparedStatement ps = DAO.connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, page);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                List<Storage> listStorage = DAO.orderDetailDAO.getListStorageBySearchProduct(rs.getLong("order"), search);
                if (listStorage.size() > 0) {
                    listOrder.add(new Order(rs.getLong("id"), DAO.userDAO.getUserById(rs.getInt("user")), rs.getString("status"), rs.getInt("totalAmount"),
                            DAO.productDAO.findProductById(rs.getInt("product")), rs.getInt("quantity"),
                            rs.getBoolean("isDelete"), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")), rs.getTimestamp("updatedAt"),
                            DAO.userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy")), listStorage));

                }
            }

        } catch (SQLException e) {
            System.out.println("getAllOrder " + e.getMessage());
        }
        return listOrder;
    }

    public Order getOrderById(long id) {
        try {
            String sql = "select * from `order` where  isDelete = false and id = ?;";
            PreparedStatement ps = DAO.connection.prepareStatement(sql);
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Order(rs.getLong("id"), DAO.userDAO.getUserById(rs.getInt("user")), rs.getString("status"), rs.getInt("totalAmount"),
                        DAO.productDAO.findProductById(rs.getInt("product")), rs.getInt("quantity"),
                        rs.getBoolean("isDelete"), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")), rs.getTimestamp("updatedAt"),
                        DAO.userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy")));
            }

        } catch (SQLException e) {
            System.out.println("getOrderById" + e.getMessage());
        }
        return null;
    }

    public void delete(Order order) {
        try {
            String query = "update `order` " +
                    "set deletedAt = ?, deletedBy = ?, isDelete = ?\n" +
                    "where id = ?;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setTimestamp(1, order.getDeletedAt());
            ps.setInt(2, order.getDeletedBy().getId());
            ps.setBoolean(3, order.isDelete());
            ps.setLong(4, order.getId());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("Delete order: " + e.getMessage());
        }
    }

    public List<Product> getListDistinctProduct() {
        List<Product> list = new ArrayList<>();
        try {
            String query = "select distinct `order` from order_detail;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(DAO.productDAO.findProductById(rs.getInt("productId")));
            }
        } catch (SQLException e) {
            System.err.println("getListDistinctProduct: " + e.getMessage());
        }
        return list;
    }

    public Long getTotalOrder() {
        try {
            String query = "select count(id) from `order` where isDelete = false;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            System.out.println("getTotalOrder: " + e.getMessage());
        }
        return (long) -1;
    }

    public void deleteOrder(long oid) {
        try {
            String sql = "delete from `order` where id = ?;";
            PreparedStatement ps = DAO.connection.prepareStatement(sql);
            ps.setLong(1, oid);
            ps.execute();
            ps.close();
        } catch (SQLException e) {
            System.out.println("deleteOrder: " + e.getMessage());
        }
    }

    public List<String> getDistinctStatus() {
        List<String> list = new ArrayList<>();
        try {
            String query = "select distinct status from `order`;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("status"));
            }
        } catch (SQLException e) {
            System.err.println("getDistinctStatus: " + e.getMessage());
        }
        return list;
    }
    public List<Order> getAllOrderWithUser(String status, String search, int page,int userId) {
        List<Order> listOrder = new ArrayList<>();
        try {
            String sql = "select distinct od.`order`, o.* from `order` o\n" +
                    "right join order_detail od on o.id = od.`order`\n" +
                    "where status like ? and isDelete = false and user = ? " +
                    "limit 10 offset ?";
            PreparedStatement ps = DAO.connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, userId);
            ps.setInt(3, page);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                List<Storage> listStorage = DAO.orderDetailDAO.getListStorageBySearchProduct(rs.getLong("order"), search);
                if (listStorage.size() > 0) {
                    listOrder.add(new Order(rs.getLong("id"), DAO.userDAO.getUserById(rs.getInt("user")), rs.getString("status"), rs.getInt("totalAmount"),
                            DAO.productDAO.findProductById(rs.getInt("product")), rs.getInt("quantity"),
                            rs.getBoolean("isDelete"), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")), rs.getTimestamp("updatedAt"),
                            DAO.userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy")), listStorage));
                }
            }

        } catch (SQLException e) {
            System.out.println("getAllOrder " + e.getMessage());
        }
        return listOrder;
    }

    public void update(Order order) {
        try {
            String query = "update `order` set `user` = ?, status = ?, totalAmount = ?," +
                    " product = ?, quantity = ?, isDelete = ?, updatedAt = ?, updatedBy = ?" +
                    " where id = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setInt(1, order.getUser().getId());
            ps.setString(2, order.getStatus());
            ps.setInt(3, order.getTotalAmount());
            ps.setInt(4, order.getProduct().getId());
            ps.setInt(5, order.getQuantity());
            ps.setBoolean(6, order.isDelete());
            ps.setTimestamp(7, order.getUpdatedAt());
            ps.setInt(8, order.getUpdatedBy().getId());
            ps.setLong(9, order.getId());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("OrderDAO-update: " + e.getMessage());
        }
    }

}


