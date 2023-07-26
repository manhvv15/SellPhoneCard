/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Product;
import model.Storage;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @author hp
 */
public class ProductDAO {

    public ArrayList<Product> getListProductBySupplier(int id) {
        ArrayList<Product> list = new ArrayList<>();
        try {
            String str = "select * from product where supplier = ? and isDelete = false";
            PreparedStatement ps = DAO.connection.prepareStatement(str);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getInt("price"),
                        DAO.supplierDAO.getSuppierById(rs.getInt("supplier")), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")),
                        rs.getBoolean("isDelete"), rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy")),
                        rs.getTimestamp("updatedAt"), DAO.userDAO.getUserById(rs.getInt("updatedBy"))));
            }
        } catch (SQLException e) {
            System.out.println("getListProductBySupplier: " + e.getMessage());
        }
        return list;
    }

    public Long getTotalQuanlityBySupplier(int supplier) {
        long quantity = 0;
        try {
            String query = "select quantity from product where supplier " + (supplier > 0 ? "= ?" : "");
            PreparedStatement ps = DAO.connection.prepareStatement(query);
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
            PreparedStatement ps = DAO.connection.prepareStatement(str);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getInt("price"),
                        DAO.supplierDAO.getSuppierById(rs.getInt("supplier")), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")),
                        rs.getBoolean("isDelete"), rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy")),
                        rs.getTimestamp("updatedAt"), DAO.userDAO.getUserById(rs.getInt("updatedBy")));
            }
        } catch (SQLException e) {
            System.out.println("findProductById: " + e.getMessage());
        }
        return product;
    }

    public int insert(Product product) {
        try {
            String query = "insert into product(`name`, quantity, price, supplier, createdAt, createdBy, isDelete)\n" +
                    "value (?, ?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = DAO.connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, product.getName());
            ps.setInt(2, product.getQuantity());
            ps.setInt(3, product.getPrice());
            ps.setInt(4, product.getSupplier().getId());
            ps.setTimestamp(5, product.getCreatedAt());
            ps.setInt(6, product.getCreatedBy().getId());
            ps.setBoolean(7, product.isDelete());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("ProductDAO-insert: " + e.getMessage());
        }
        return -1;
    }

    public void update(Product p, int id) {
        try {
            String query = "update product set name = ?, quantity = ?, price = ?,\n" +
                    "supplier = ?, updatedBy = ?, updatedAt = ?\n" +
                    "where id = ?;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
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
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setInt(1, finalPrice);
            ps.setInt(2, parseInt);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getInt("price"),
                        DAO.supplierDAO.getSuppierById(rs.getInt("supplier")), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")),
                        rs.getBoolean("isDelete"), rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy")),
                        rs.getTimestamp("updatedAt"), DAO.userDAO.getUserById(rs.getInt("updatedBy")));
            }
        } catch (SQLException e) {
            System.out.println("findProductByPriceAndSupplier: " + e.getMessage());
        }
        return null;
    }

    public List<Product> searchProduct(int supplier, String name, int price, int offset) {
        List<Product> list = new ArrayList<>();
        try {
            String query = "select * from product where isDelete = false" +
                    (supplier > 0 ? " and supplier = ? " : "") +
                    (price >= 0 ? " and price = ? " : "") +
                    (" and name like ? limit 10 offset ?");

            PreparedStatement ps = DAO.connection.prepareStatement(query);
            int i = 1;
            if (supplier > 0) {
                ps.setInt(i, supplier);
                i++;
            }
            if (price >= 0) {
                ps.setInt(i, price);
                i++;
            }
            ps.setString(i, name);
            i++;
            ps.setInt(i, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getInt("price"),
                        DAO.supplierDAO.getSuppierById(rs.getInt("supplier")), rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")),
                        rs.getBoolean("isDelete"), rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy")),
                        rs.getTimestamp("updatedAt"), DAO.userDAO.getUserById(rs.getInt("updatedBy"))));
            }
        } catch (SQLException e) {
            System.out.println("searchProduct: " + e.getMessage());
        }
        return list;
    }

    public List<Integer> getListPrice() {
        List<Integer> list = new ArrayList<>();
        try {
            String query = "select distinct price from product where isDelete = false;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                list.add(rs.getInt("price"));
            }
        } catch (SQLException e) {
            System.out.println("getListPrice: " + e.getMessage());
        }
        return list;
    }

    public int getTotalProduct(int supplierId, String name, int price) {
        try {
            String query = "select count(id) from product where isDelete = false" +
                    (supplierId > 0 ? " and supplier = ? " : "") +
                    (price >= 0 ? " and price = ? " : "") +
                    (" and name like ?");

            PreparedStatement ps = DAO.connection.prepareStatement(query);
            int i = 1;
            if (supplierId > 0) {
                ps.setInt(i, supplierId);
                i++;
            }
            if (price >= 0) {
                ps.setInt(i, price);
                i++;
            }
            ps.setString(i, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("count(id)");
            }
        } catch (SQLException e) {
            System.out.println("getTotalProduct: " + e.getMessage());
        }
        return 0;
    }

    public void delete(Product p, int id) {
        try {
            String query = "update product set deletedBy = ?, deletedAt = ?, isDelete = ?\n" +
                    "where id = ?;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setInt(1, p.getDeletedBy().getId());
            ps.setTimestamp(2, p.getUpdatedAt());
            ps.setBoolean(3, p.isDelete());
            ps.setInt(4, id);
            ps.execute();
            List<Storage> list = DAO.storageDAO.getStorageByProduct(id);
            for (Storage s : list) {
                s.setDeletedAt(p.getDeletedAt());
                s.setDeletedBy(p.getDeletedBy());
                s.setDelete(true);
                DAO.storageDAO.delete(s);
            }
        } catch (SQLException e) {
            System.out.println("ProductDAO-delete: " + e.getMessage());
        }
    }
}
