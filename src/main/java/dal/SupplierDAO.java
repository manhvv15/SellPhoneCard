/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Supplier;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * @author hp
 */
public class SupplierDAO {

    public Supplier getSuppierById(int id) {
        try {
            String strSelect = "select * from supplier where id =?";
            PreparedStatement ps = DAO.connection.prepareStatement(strSelect);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Supplier(rs.getInt("id"), rs.getString("name"), rs.getTimestamp("createdAt"),
                        rs.getTimestamp("deletedAt"), rs.getTimestamp("updatedAt"), rs.getBoolean("isDelete"),
                        rs.getString("image"), DAO.userDAO.getUserById(rs.getInt("createdBy")),
                        DAO.userDAO.getUserById(rs.getInt("deletedBy")), DAO.userDAO.getUserById(rs.getInt("createdBy")));
            }
        } catch (SQLException e) {
            System.out.println("getSuppierById: " + e.getMessage());
        }
        return null;
    }

    public ArrayList<Supplier> getListSupplier() {
        ArrayList<Supplier> list = new ArrayList<>();
        try {
            String strSelect = "select * from supplier where isDelete = false";
            PreparedStatement ps = DAO.connection.prepareStatement(strSelect);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Supplier(rs.getInt("id"), rs.getString("name"), rs.getTimestamp("createdAt"),
                        rs.getTimestamp("deletedAt"), rs.getTimestamp("updatedAt"), rs.getBoolean("isDelete"),
                        rs.getString("image"), DAO.userDAO.getUserById(rs.getInt("createdBy")),
                        DAO.userDAO.getUserById(rs.getInt("deletedBy")), DAO.userDAO.getUserById(rs.getInt("updatedBy"))));
            }
        } catch (SQLException e) {
            System.out.println("getListSupplier: " + e.getMessage());
        }
        return list;
    }

    public int insert(Supplier supplier) {
        try {
            String query = "insert into supplier (name, createdAt, createdBy, isDelete, image) values\n" +
                    "(?, ?, ?, ?, ?);";
            PreparedStatement ps = DAO.connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, supplier.getName());
            ps.setTimestamp(2, supplier.getCreatedAt());
            ps.setInt(3, supplier.getCreatedBy().getId());
            ps.setBoolean(4, supplier.isDelete());
            ps.setString(5, supplier.getImage());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("SupplierDAO-insert: " + e.getMessage());
        }
        return -1;
    }
}
