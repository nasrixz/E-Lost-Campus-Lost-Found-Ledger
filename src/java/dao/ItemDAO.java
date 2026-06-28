package dao;

import bean.Item;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
