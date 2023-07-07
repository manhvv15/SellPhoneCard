/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.Supplier;
import model.Transactions;
import model.User;

/**
 *
 * @author hp
 */
public class TransactionsDAO extends DAO {

    private static Transactions findTransactionsById(int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Transactions> findPendingTransaction() {
        List<Transactions> transactionsList = new ArrayList<>();
        try {
            String query = "select * from transactions where status = false" +
                    " order by createdAt";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                transactionsList.add(new Transactions(rs.getInt("id"), DAO.userDAO.getUserById(rs.getInt("user")),
                        rs.getLong("orderId"), rs.getInt("money"), rs.getString("note"),
                        rs.getBoolean("type"), rs.getBoolean("status"), rs.getTimestamp("updatedAt"),
                        DAO.userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy"))));
            }
        } catch (SQLException e) {
            System.out.println("findPendingTransaction: " + e.getMessage());
        }
        return transactionsList;
    }

    public void insert(Transactions transactions) {
        try {
            String query = "insert into transactions(user, orderId, money, note, type, status, createdAt, createdBy)\n" +
                    "value (?, ?, ?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, transactions.getUser().getId());
            ps.setLong(2, transactions.getOrderId());
            ps.setInt(3, transactions.getMoney());
            ps.setString(4, transactions.getNote());
            ps.setBoolean(5, transactions.isType());
            ps.setBoolean(6, transactions.isStatus());
            ps.setTimestamp(7, transactions.getCreateAt());
            ps.setInt(8, transactions.getCreateBy().getId());
            ps.execute();
        } catch (SQLException e) {
            System.err.println("Transactions-insert: " + e.getMessage());
        }
    }

    public List<Transactions> getListTransactionsForPage(int page) {
        List<Transactions> list = new ArrayList<>();
        try {
            String query = "select * from transactions limit 10 offset ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, page);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Transactions(rs.getInt("id"), userDAO.getUserById(rs.getInt("user")),
                        rs.getLong("orderId"), rs.getInt("money"), rs.getString("note"),
                        rs.getBoolean("type"), rs.getBoolean("status"), rs.getTimestamp("updatedAt"),
                        userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("createdAt"), userDAO.getUserById(rs.getInt("createdBy"))));
            }
        } catch (SQLException e) {
            System.out.println("getAllStorage: " + e.getMessage());
        }
        return list;

    }

    private UserDAO userDAO = new UserDAO();

    public ArrayList<Transactions> getListTransactions() {
        ArrayList<Transactions> list = new ArrayList<>();
        try {
            String strSelect = "select * from transactions ";
            PreparedStatement ps = connection.prepareStatement(strSelect);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Transactions(rs.getInt("id"), userDAO.getUserById(rs.getInt("user")),
                        rs.getLong("orderId"), rs.getInt("money"), rs.getString("note"),
                        rs.getBoolean("type"), rs.getBoolean("status"), rs.getTimestamp("updatedAt"),
                        userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("createdAt"), userDAO.getUserById(rs.getInt("createdBy"))));
            }
        } catch (SQLException e) {
            System.out.println("getListTransactions: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Transactions> getListTransactionsByUserId(int id) {
        ArrayList<Transactions> list = new ArrayList<>();
        try {
            String str = "SELECT * FROM transactions where user = ?";
            PreparedStatement ps = connection.prepareStatement(str);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Transactions(rs.getInt("id"), userDAO.getUserById(rs.getInt("user")),
                        rs.getLong("orderId"), rs.getInt("money"), rs.getString("note"),
                        rs.getBoolean("type"), rs.getBoolean("status"), rs.getTimestamp("updatedAt"),
                        userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("createdAt"), userDAO.getUserById(rs.getInt("createdBy"))));
            }
        } catch (SQLException e) {
            System.out.println("getListTransactions: " + e.getMessage());
        }
        return list;
    }

    public Long getTotalTransactions() {
        try {
            String query = "select count(id) from transactions;";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            System.out.println("getTotalTransactions: " + e.getMessage());
        }
        return (long) -1;
    }

    public List<Transactions> getListDistinctTransactions() {
        List<Transactions> list = new ArrayList<>();
        try {
            String query = "select distinct Id from transactions;";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(TransactionsDAO.findTransactionsById(rs.getInt("productId")));
            }
        } catch (SQLException e) {
            System.err.println("getListDistinctProduct: " + e.getMessage());
        }
        return list;
    }

    public List<Transactions> getListTransactionsById(int id, int start, int end) {
        List<Transactions> list = new ArrayList<>();
        List<Transactions> list1 = new ArrayList<>();
        TransactionsDAO td = new TransactionsDAO();

        list = td.getListTransactionsByUserId(id);
        for (int i = start; i < end; i++) {
            list1.add(list.get(i));
        }
        return list1;
    }

    public List<Transactions> searchTransactions(String type, String status, String search,int id) {
        List<Transactions> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM transactions "
                    + "where user=? " + (!type.isEmpty() ? "and type= ?" : "")
                    + (!status.isEmpty() ? " and status = ?" : "")
                    + (!search.isEmpty() ? " and note like ?" : "");

            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            int i = 2;
            if (!type.isEmpty()) {
                boolean x = false;
                if(type.equals("true")){
                    x = true;
                }
                ps.setBoolean(i,x);
                i++;
            }
            if (!status.isEmpty()) {
                boolean x =false;
                if(status.equals("true")){
                    x=true;
                }
                ps.setBoolean(i,x);
                i++;
            }
            if (!search.isEmpty()){
                ps.setString(i, "%"+search+"%");
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Transactions(rs.getInt("id"), userDAO.getUserById(rs.getInt("user")),
                        rs.getLong("orderId"), rs.getInt("money"), rs.getString("note"),
                        rs.getBoolean("type"), rs.getBoolean("status"), rs.getTimestamp("updatedAt"),
                        userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("createdAt"), userDAO.getUserById(rs.getInt("createdBy"))));
            }
        } catch (SQLException e) {
            System.err.println("searchStorage: " + e.getMessage());
        }
        return list;
    }

    public List<Transactions> getDetailHistory(int id) {
        List<Transactions> list = new ArrayList<>();
        try {
            String str = "SELECT * FROM transactions where id = ?";
            PreparedStatement ps = connection.prepareStatement(str);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Transactions(rs.getInt("id"), userDAO.getUserById(rs.getInt("user")),
                        rs.getLong("orderId"), rs.getInt("money"), rs.getString("note"),
                        rs.getBoolean("type"), rs.getBoolean("status"), rs.getTimestamp("updatedAt"),
                        userDAO.getUserById(rs.getInt("updatedBy")), rs.getTimestamp("createdAt"), userDAO.getUserById(rs.getInt("createdBy"))));
            }
        } catch (SQLException e) {
            System.out.println("getDetailHistory: " + e.getMessage());
        }
        return list;
    }

    public void update(Transactions transaction) {
        try {
            String query = "update transactions set `user` = ?, orderId = ?," +
                    " money = ?, note = ?, type = ?, status = ?, updatedAt = ?, updatedBy = ?" +
                    " where id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, transaction.getUser().getId());
            ps.setLong(2, transaction.getOrderId());
            ps.setInt(3, transaction.getMoney());
            ps.setString(4, transaction.getNote());
            ps.setBoolean(5, transaction.isType());
            ps.setBoolean(6, transaction.isStatus());
            ps.setTimestamp(7, transaction.getUpdatedAt());
            ps.setInt(8, transaction.getUpdatedBy().getId());
            ps.setInt(9, transaction.getId());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("TransactionsDAO-update: " + e.getMessage());
        }
    }
}
