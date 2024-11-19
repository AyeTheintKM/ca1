package servlet;

import java.io.IOException;
import java.sql.*;

import dao.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve username and password from the request
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate against database
        try  {
        	Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);
            // Prepare SQL query to check admin credentials
            String sql = "SELECT * FROM admin_users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password); // Consider hashing password for real-world applications

            ResultSet rs = stmt.executeQuery();

            // Check if credentials match
            if (rs.next()) {
                // If valid, create a session and store the admin username
                HttpSession session = request.getSession();
                session.setAttribute("admin", username);

                // Redirect to the admin dashboard
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                // If invalid, redirect back to login with an error message
                response.sendRedirect("admin/login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}