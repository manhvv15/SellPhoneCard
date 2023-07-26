package dal;

import model.PaymentTransaction;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PaymentTransactionDAO {

    public PaymentTransaction getPaymentById(long id) {
        try {
            String query = "select * from paymentTransaction where id = ? and isDelete = false;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new PaymentTransaction().builder()
                        .id(rs.getLong("id")).type(rs.getBoolean("type"))
                        .status(rs.getBoolean("status")).amount(rs.getLong("amount"))
                        .isDelete(rs.getBoolean("isDelete"))
                        .createdAt(rs.getTimestamp("createdAt")).createdBy(DAO.userDAO.getUserById(rs.getInt("createdBy")))
                        .updatedAt(rs.getTimestamp("updatedAt")).updatedBy(DAO.userDAO.getUserById(rs.getInt("updatedBy")))
                        .deletedAt(rs.getTimestamp("deletedAt")).deletedBy(DAO.userDAO.getUserById(rs.getInt("deletedBy")))
                        .build();
            }
        } catch (SQLException e) {
            System.out.println("getPaymentById: "+ e.getMessage());
        }
        return null;
    }

    public Long insert(PaymentTransaction paymentTransaction) {
        try {
            String query = "insert into paymentTransaction(type, status, amount, isDelete, createdAt, createdBy) \n" +
                    "value (?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = DAO.connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setBoolean(1, paymentTransaction.isType());
            ps.setBoolean(2, paymentTransaction.isStatus());
            ps.setLong(3, paymentTransaction.getAmount());
            ps.setBoolean(4, paymentTransaction.isDelete());
            ps.setTimestamp(5, paymentTransaction.getCreatedAt());
            ps.setInt(6, paymentTransaction.getCreatedBy().getId());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            System.out.println("PaymentTransactionDAO-insert: " + e.getMessage());
        }

        return (long) 0;
    }

    public void update(PaymentTransaction paymentTransaction) {
        try {
            String query = "update paymentTransaction set type = ?, status = ?, amount = ?,\n" +
                    "isDelete = ?, updatedAt = ?, updatedBy = ?\n" +
                    "where id = ?;";
            PreparedStatement ps = DAO.connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setBoolean(1, paymentTransaction.isType());
            ps.setBoolean(2, paymentTransaction.isStatus());
            ps.setLong(3, paymentTransaction.getAmount());
            ps.setBoolean(4, paymentTransaction.isDelete());
            ps.setTimestamp(5, paymentTransaction.getUpdatedAt());
            ps.setInt(6, paymentTransaction.getUpdatedBy().getId());
            ps.setLong(7, paymentTransaction.getId());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("PaymentTransactionDAO-update: " + e.getMessage());
        }
    }
}
