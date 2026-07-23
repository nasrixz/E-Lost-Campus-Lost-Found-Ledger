package dao;

import bean.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBConnection;

public class UserDAO {

    public User login(String studentId, String password) {

        User user = null;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE student_id = ? AND password_hash = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, studentId);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setStudentId(rs.getString("student_id"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setFaculty(rs.getString("faculty"));
                user.setRole(rs.getString("role"));

            }

            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
        public boolean register(User user) {

    boolean status = false;

    try {

        Connection conn = DBConnection.getConnection();

        String sql = "INSERT INTO users (full_name, student_id, email, password_hash, phone, faculty, role) VALUES (?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, user.getFullName());
        ps.setString(2, user.getStudentId());
        ps.setString(3, user.getEmail());
        ps.setString(4, user.getPasswordHash());
        ps.setString(5, user.getPhone());
        ps.setString(6, user.getFaculty());
        ps.setString(7, user.getRole());

        int row = ps.executeUpdate();

        if (row > 0) {
            status = true;
        }

        conn.close();

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return status;
}
        
    public boolean verifyIdentity(String studentId, String email) {

        boolean found = false;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT student_id FROM users WHERE student_id = ? AND email = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, studentId);
            ps.setString(2, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                found = true;
            }

            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return found;
    }

    public boolean resetPassword(String studentId, String newPassword) {

        boolean status = false;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "UPDATE users SET password_hash = ? WHERE student_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, studentId);

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }
    public java.util.List<User> getAllUsers() {
        java.util.List<User> list = new java.util.ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM users ORDER BY user_id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setStudentId(rs.getString("student_id"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setFaculty(rs.getString("faculty"));
                user.setRole(rs.getString("role"));
                list.add(user);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteUser(int userId) {
        boolean result = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM users WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            result = ps.executeUpdate() > 0;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean updateUserRole(int userId, String newRole) {
        boolean result = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE users SET role = ? WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newRole);
            ps.setInt(2, userId);
            result = ps.executeUpdate() > 0;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    public boolean updateProfile(int userId, String fullName, String email, String phone, String faculty) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE users SET full_name = ?, email = ?, phone = ?, faculty = ? WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, faculty);
            ps.setInt(5, userId);
            int row = ps.executeUpdate();
            if (row > 0) {
                status = true;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String checkSql = "SELECT user_id FROM users WHERE user_id = ? AND password_hash = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, userId);
            checkPs.setString(2, oldPassword);
            ResultSet rs = checkPs.executeQuery();
            if (rs.next()) {
                String updateSql = "UPDATE users SET password_hash = ? WHERE user_id = ?";
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setString(1, newPassword);
                updatePs.setInt(2, userId);
                status = updatePs.executeUpdate() > 0;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }
    
    private static final String SMTP_EMAIL = "youractualemail@gmail.com";
    private static final String SMTP_PASSWORD = "abcdefghijklmnop";
}