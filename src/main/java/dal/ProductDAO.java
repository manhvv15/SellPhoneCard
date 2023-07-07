/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.xdevapi.Result;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import model.Product;

/**
 *
 * @author hp
 */
public class ProductDAO extends DAO {

    public ArrayList<Product> getListProductBySupplier(int id) {
        ArrayList<Product> list = new ArrayList<>();
        try {
            String str = "select * from product where supplier = ? and isDelete = false";
            PreparedStatement ps = connection.prepareStatement(str);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {                
                list.add(new Product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getInt("price"),
                        supplierDAO.getSuppierById(rs.getInt("supplier")),rs.getTimestamp("createdAt"), userDAO.getUserById(rs.getInt("createdBy")),
                        rs.getBoolean("isDelete"),rs.getTimestamp("deletedAt"), userDAO.getUserById(rs.getInt("deletedBy")),
                        rs.getTimestamp("updatedAt"), userDAO.getUserById(rs.getInt("updatedBy") )));
            }
        } catch (SQLException e) {
            System.out.println("getListProductBySupplier: " + e.getMessage());
        }return list;
    }

    public Long getTotalQuanlityBySupplier(int supplier) {
        long quantity = 0;
        try {
            String query = "select quantity from product where supplier " + (supplier > 0 ? "= ?" : "");
            PreparedStatement ps = connection.prepareStatement(query);
            if (supplier > 0) {
                ps.setInt(1, supplier);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                quantity += rs.getLong("quantity");
            }
        } catch (SQLException e) {
            System.out.println("getTotalQuanlityBySupplier: " + e.getMessage());
        }
        return quantity;
    }

    public Product findProductById(int id) {
        Product product = new Product();
        try {
            String str = "select * from product where id = ?";
            PreparedStatement ps = connection.prepareStatement(str);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getInt("price"),
                        supplierDAO.getSuppierById(rs.getInt("supplier")),rs.getTimestamp("createdAt"), userDAO.getUserById(rs.getInt("createdBy")),
                        rs.getBoolean("isDelete"),rs.getTimestamp("deletedAt"), userDAO.getUserById(rs.getInt("deletedBy")),
                        rs.getTimestamp("updatedAt"), userDAO.getUserById(rs.getInt("updatedBy")));
            }
        } catch (SQLException e) {
            System.out.println("findProductById: " + e.getMessage());
        }
        return product;
    }

    public void insert(Product product) {
        try {
           String query = "insert into product(`name`, quantity, price, supplier, createdAt, createdBy, isDelete)\n" +
                   "value (?, ?, ?, ?, ?, ?, ?);";
           PreparedStatement ps = connection.prepareStatement(query);
           ps.setString(1, product.getName());
           ps.setInt(2, product.getQuantity());
           ps.setInt(3, product.getPrice());
           ps.setInt(4, product.getSupplier().getId());
           ps.setTimestamp(5, product.getCreatedAt());
           ps.setInt(6, product.getCreatedBy().getId());
           ps.setBoolean(7, product.isDelete());
           ps.execute();
        } catch (SQLException e) {
            System.out.println("ProductDAO-insert: " + e.getMessage());
        }
    }

    public void update(Product p, int id) {
        try {
            String query = "update product set name = ?, quantity = ?, price = ?,\n" +
                    "supplier = ?, updatedBy = ?, updatedAt = ?\n" +
                    "where id = ?;";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, p.getName());
            ps.setInt(2, p.getQuantity());
            ps.setInt(3, p.getPrice());
            ps.setInt(4, p.getSupplier().getId());
            ps.setInt(5, p.getUpdatedBy().getId());
            ps.setTimestamp(6, p.getUpdatedAt());
            ps.setInt(7, id);
            ps.execute();
        } catch (SQLException e) {
            System.out.println("ProductDAO-update: " + e.getMessage());
        }
    }

    public Product findProductByPriceAndSupplier(int finalPrice, int parseInt) {
        try {
            String query = "select * from product where isDelete = false\n" +
                    "and price = ? and supplier = ?;";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, finalPrice);
            ps.setInt(2, parseInt);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getInt("price"),
                        supplierDAO.getSuppierById(rs.getInt("supplier")),rs.getTimestamp("createdAt"), userDAO.getUserById(rs.getInt("createdBy")),
                        rs.getBoolean("isDelete"),rs.getTimestamp("deletedAt"), userDAO.getUserById(rs.getInt("deletedBy")),
                        rs.getTimestamp("updatedAt"), userDAO.getUserById(rs.getInt("updatedBy")));
            }
        } catch (SQLException e) {
            System.out.println("findProductByPriceAndSupplier: " + e.getMessage());
        }
        return null;
    }

    public int findQuanlity(int finalPrice, int supplier) {
        try {
            String query = "select quantity from product where price = ? and supplier = ?" +
                    " and isDelete = false";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, finalPrice);
            ps.setInt(2, supplier);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("quantity");
            }
        } catch (SQLException e) {
            System.out.println("findQuanlity: " + e.getMessage());
        }

        return 0;
    }
}
