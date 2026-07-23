package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:derby://localhost:1527/ELostDB";
    private static final String USER = "app";
    private static final String PASSWORD = "app";

    public static Connection getConnection() {
        Connection conn = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database Connected Successfully!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Database Connection Failed!");
            e.printStackTrace();
        }

        return conn;
    }
}