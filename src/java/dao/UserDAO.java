package dao;

import bean.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBConnection;

public class UserDAO {

    // LOGIN
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
}