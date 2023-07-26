package dal;

import model.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public List<User> getAllUser() {
        List<User> userlist = new ArrayList<>();
        try {
            String query = "select * from user where   role = true;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                userlist.add(new User(rs.getInt("id"), rs.getString("account"), rs.getString("password"),
                        rs.getString("email"), rs.getInt("role"), rs.getString("phoneNumber"), rs.getInt("balance"),
                        rs.getBoolean("isDelete"), rs.getBoolean("isActive"), rs.getTimestamp("createdAt"),
                        rs.getInt("createdBy"), rs.getTimestamp("updatedAt"), rs.getInt("updatedBy"),
                        rs.getTimestamp("deletedAt"), rs.getInt("deletedBy")));
            }

        } catch (SQLException e) {
            System.out.println("getAllUser: " + e.getMessage());
        }
        return userlist;
    }

    public User getUserById1(int id) {
        try {
            String query = "SELECT * from user where id = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("account"), rs.getString("password"),
                        rs.getString("email"), rs.getInt("role"), rs.getString("phoneNumber"), rs.getInt("balance"),
                        rs.getBoolean("isDelete"), rs.getBoolean("isActive"), rs.getTimestamp("createdAt"),
                        rs.getInt("createdBy"), rs.getTimestamp("updatedAt"), rs.getInt("updatedBy"),
                        rs.getTimestamp("deletedAt"), rs.getInt("deletedBy"));
            }
        } catch (SQLException e) {
            System.out.println("getUserById: " + e.getMessage());
        }
        return null;
    }


    public User getUserById(int id) {
        try {
            String query = "SELECT * from user where id = ? and isDelete = false and isActive = true";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("account"), rs.getString("password"),
                        rs.getString("email"), rs.getInt("role"), rs.getString("phoneNumber"), rs.getInt("balance"),
                        rs.getBoolean("isDelete"), rs.getBoolean("isActive"), rs.getTimestamp("createdAt"),
                        rs.getInt("createdBy"), rs.getTimestamp("updatedAt"), rs.getInt("updatedBy"),
                        rs.getTimestamp("deletedAt"), rs.getInt("deletedBy"));
            }
        } catch (SQLException e) {
            System.out.println("getUserById: " + e.getMessage());
        }
        return null;
    }

    public boolean isEmailAvailable(String email) {
        try {
            String query = "SELECT * from user where email = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
            System.out.println("UserDAO-isEmailAvailable: " + e.getMessage());
        }
        return true;
    }

    public boolean isAccountAvailable(String account) {
        try {
            String query = "SELECT * from user where account = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
            System.out.println("UserDAO-isAccountAvailable: " + e.getMessage());
        }
        return true;
    }

    public User getUser(String account, String password) {
        try {
            String query = "SELECT * FROM user WHERE account = ? and password = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, account);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User().builder().id(rs.getInt("id"))
                        .account(rs.getString("account")).password(rs.getString("password"))
                        .email(rs.getString("email")).role(rs.getInt("role"))
                        .phoneNumber(rs.getString("phoneNumber")).balance(rs.getInt("balance"))
                        .isActive(rs.getBoolean("isActive")).isDelete(rs.getBoolean("isDelete"))
                        .createdAt(rs.getTimestamp("createdAt")).createdBy(rs.getInt("createdBy"))
                        .deletedAt(rs.getTimestamp("deletedAt")).deletedBy(rs.getInt("deletedBy"))
                        .updatedAt(rs.getTimestamp("updatedAt")).updatedBy(rs.getInt("updatedBy"))
                        .build();
            }
        } catch (SQLException e) {
            System.out.println("UserDao-isUserExist: " + e.getMessage());
        }
        return null;
    }

    public User getUserbyAccount(String account) {
        try {
            String query = "SELECT * FROM user WHERE account = ? and isActive = true";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, account);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User().builder().id(rs.getInt("id"))
                        .account(rs.getString("account")).password(rs.getString("password"))
                        .email(rs.getString("email")).role(rs.getInt("role"))
                        .phoneNumber(rs.getString("phoneNumber")).balance(rs.getInt("balance"))
                        .isActive(rs.getBoolean("isActive")).isDelete(rs.getBoolean("isDelete"))
                        .createdAt(rs.getTimestamp("createdAt")).createdBy(rs.getInt("createdBy"))
                        .deletedAt(rs.getTimestamp("deletedAt")).deletedBy(rs.getInt("deletedBy"))
                        .updatedAt(rs.getTimestamp("updatedAt")).updatedBy(rs.getInt("updatedBy"))
                        .build();
            }
        } catch (SQLException e) {
            System.out.println("UserDao-isUserExist: " + e.getMessage());
        }
        return null;
    }


    public void add(User user) {
        try {
            String query = "INSERT INTO user (account, password, email, role, isDelete, isActive, createdAt)" +
                    "VALUES(?, ?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, user.getAccount());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setInt(4, user.getRole());
            ps.setBoolean(5, user.isDelete());
            ps.setBoolean(6, user.isActive());
            ps.setTimestamp(7, user.getCreatedAt());
            ps.execute();
            System.out.println("Insert new user successfully!");
        } catch (SQLException e) {
            System.out.println("UserDAO-add: " + e.getMessage());
        }
    }

    public int update(User user, int id) {
        try {
            String query = "UPDATE user SET account = ?, password = ?, email = ?, role = ?,"
                    + "phoneNumber = ?, balance = ?, isDelete = ?, isActive = ?, createdAt = ?, createdBy = ?, updatedAt = ?, updatedBy = ?, "
                    + "deletedAt = ?, deletedBy = ? "
                    + "WHERE id = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getAccount());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setInt(4, user.getRole());
            ps.setString(5, user.getPhoneNumber());
            ps.setDouble(6, user.getBalance());
            ps.setBoolean(7, user.isDelete());
            ps.setBoolean(8, user.isActive());
            ps.setInt(15, id);
            ps.setTimestamp(9, user.getCreatedAt());
            ps.setInt(10, user.getId());
            ps.setTimestamp(11, user.getUpdatedAt());
            ps.setInt(12, user.getUpdatedBy());
            ps.setTimestamp(13, user.getDeletedAt());
            ps.setInt(14, user.getDeletedBy());
            ps.execute();
            System.out.println("Update user successfully!");
            return user.getId();
        } catch (SQLException e) {
            System.out.println("UserDAO-update: " + e.getMessage());
        }
        return -1;
    }


    public boolean checkUser(String account, String password) {
        try {
            String query = "SELECT * FROM user WHERE account = ? and password = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, account);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("UserDAO-checkUser: " + e.getMessage());
        }
        return false;
    }

    public boolean isAccountActive(String account) {
        try {
            String query = "SELECT * from user where account = ? and isActive = 1";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("UserDAO-isAccountAvailable: " + e.getMessage());
        }
        return false;
    }

    public int getTotalUsers(int id) {
        try {
            String query = "select count(id) from user where isDelete = false and id != ?;";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("count(id)");
            }
        } catch (SQLException e) {
            System.out.println("getTotalUsers: " + e.getMessage());
        }
        return 0;
    }

    public List<User> searchUsers(String searchName, int page, int isActive) {
        List<User> listUser = new ArrayList<>();

        try {
            String query = "select * from user where isDelete = false\n" +
                    " and account like ? " + (isActive >= 0 ? "and isActive = ?" : "\n") +
                    " limit 10 offset ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, searchName);
            if (isActive >= 0) {
                ps.setInt(2, isActive);
                ps.setInt(3, page);
            } else {
                ps.setInt(2, page);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listUser.add(new User().builder().id(rs.getInt("id")).account(rs.getString("account"))
                        .email(rs.getString("email")).phoneNumber(rs.getString("phoneNumber"))
                        .isActive(rs.getBoolean("isActive")).balance(rs.getInt("balance"))
                        .createdAt(rs.getTimestamp("createdAt")).createdBy(rs.getInt("createdBy")).build());
            }
        } catch (SQLException e) {
            System.out.println("searchUsers: " + e.getMessage());
        }
        return listUser;
    }
}
