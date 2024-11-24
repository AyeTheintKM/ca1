package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String USERNAME = "neondb_owner";
    private static final String PASSWORD = "PCbckaliN31T";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
            conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}