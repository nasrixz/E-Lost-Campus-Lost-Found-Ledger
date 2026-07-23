package dao;

import bean.Item;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class ItemDAO {

    public boolean addItem(Item item) {

        boolean status = false;

        try {

            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO items (item_name, category, report_type, date_lost_found, description, building, specific_loc, photo, status, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, item.getItemName());
            ps.setString(2, item.getCategory());
            ps.setString(3, item.getReportType());
            ps.setString(4, item.getDateLostFound());
            ps.setString(5, item.getDescription());
            ps.setString(6, item.getBuilding());
            ps.setString(7, item.getSpecificLoc());
            ps.setString(8, item.getPhoto());
            ps.setString(9, item.getStatus());
            ps.setInt(10, item.getUserId());

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
    
    public java.util.List<Item> getPendingItems() {
        java.util.List<Item> list = new java.util.ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT i.*, u.full_name, u.student_id AS reporter_sid FROM items i LEFT JOIN users u ON i.user_id = u.user_id WHERE i.status = 'Pending' ORDER BY i.item_id ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setCategory(rs.getString("category"));
                item.setStatus(rs.getString("status"));
                item.setUserId(rs.getInt("user_id"));
                // Store reporter info in description temporarily
                item.setDescription(rs.getString("full_name") + "||" + rs.getString("reporter_sid"));
                list.add(item);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateItemStatus(int itemId, String status) {
        boolean result = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE items SET status = ? WHERE item_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, itemId);
            result = ps.executeUpdate() > 0;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean deleteItem(int itemId) {
        boolean result = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM items WHERE item_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, itemId);
            result = ps.executeUpdate() > 0;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    public java.util.List<Item> getAllItems(int page, int pageSize) {
        java.util.List<Item> list = new java.util.ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            int offset = (page - 1) * pageSize;
            String sql = "SELECT * FROM items ORDER BY item_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setCategory(rs.getString("category"));
                item.setReportType(rs.getString("report_type"));
                item.setDateLostFound(rs.getString("date_lost_found"));
                item.setDescription(rs.getString("description"));
                item.setBuilding(rs.getString("building"));
                item.setSpecificLoc(rs.getString("specific_loc"));
                item.setStatus(rs.getString("status"));
                item.setUserId(rs.getInt("user_id"));
                list.add(item);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countItems() {
        int count = 0;
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM items");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
