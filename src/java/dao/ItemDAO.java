package dao;

import bean.Item;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ItemDAO {

    // ADD ITEM
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

    // GET ALL ITEMS
    public ArrayList<Item> getAllItems() {

        ArrayList<Item> list = new ArrayList<>();

        try {

            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM items ORDER BY item_id DESC";

            PreparedStatement ps = conn.prepareStatement(sql);

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

                list.add(item);

            }

            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

}