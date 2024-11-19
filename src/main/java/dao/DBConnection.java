package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost/cleaning_services";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/ca1?user=root&password=root&serverTimezone=UTC";
            conn = DriverManager.getConnection(connURL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}