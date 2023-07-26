package dal;

import model.Notice;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NoticeDAO {

    public void insert(Notice notice) {
        try {
            String query = "insert into notice(subject, content, seen, user, isDelete, createdAt, createdBy)\n" +
                    "value (?, ?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, notice.getSubject());
            ps.setString(2, notice.getContent());
            ps.setBoolean(3, notice.isSeen());
            ps.setInt(4, notice.getUser().getId());
            ps.setBoolean(5, notice.isDelete());
            ps.setTimestamp(6, notice.getCreatedAt());
            ps.setInt(7, notice.getCreatedBy().getId());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("NoticeDAO-insert: " + e.getMessage());
        }
    }

    public void update(Notice notice) {
        try {
            String query = "update notice set subject = ?, content = ?, seen = ?," +
                    " isDelete = ?, updatedAt = ?, updatedBy = ?\n" +
                    "where id = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setString(1, notice.getSubject());
            ps.setString(2, notice.getContent());
            ps.setBoolean(3, notice.isSeen());
            ps.setBoolean(4, notice.isDelete());
            ps.setTimestamp(5, notice.getUpdatedAt());
            ps.setInt(6, notice.getUpdatedBy().getId());
            ps.setLong(7, notice.getId());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("NoticeDAO-update: " + e.getMessage());
        }
    }

    public List<Notice> getListNoticeByUser(int userId) {
        List<Notice> notices = new ArrayList<>();
        try {
            String query = "select * from notice where isDelete = false and seen = false and user = ?";
            PreparedStatement ps = DAO.connection.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                notices.add(new Notice(rs.getLong("id"), rs.getString("subject"), rs.getString("content"),
                        rs.getBoolean("seen"), DAO.userDAO.getUserById(rs.getInt("user")), rs.getBoolean("isDelete"),
                        rs.getTimestamp("createdAt"), DAO.userDAO.getUserById(rs.getInt("createdBy")),
                        rs.getTimestamp("updatedAt"), DAO.userDAO.getUserById(rs.getInt("updatedBy")),
                        rs.getTimestamp("deletedAt"), DAO.userDAO.getUserById(rs.getInt("deletedBy"))));
            }
        } catch (SQLException e) {
            System.out.println("getListNoticeByUser: " + e.getMessage());
        }
        return notices;
    }
}
