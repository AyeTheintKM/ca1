package servlet;

import java.io.IOException;
import java.sql.*;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminServiceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("category"));

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);
            if ("add".equals(action)) {
                PreparedStatement stmt = conn.prepareStatement("INSERT INTO services (name, description, category_id) VALUES (?, ?, ?)");
                stmt.setString(1, name);
                stmt.setString(2, description);
                stmt.setInt(3, categoryId);
                stmt.executeUpdate();
            } else if ("update".equals(action)) {
                int serviceId = Integer.parseInt(request.getParameter("service_id"));
                PreparedStatement stmt = conn.prepareStatement("UPDATE services SET name = ?, description = ?, category_id = ? WHERE id = ?");
                stmt.setString(1, name);
                stmt.setString(2, description);
                stmt.setInt(3, categoryId);
                stmt.setInt(4, serviceId);
                stmt.executeUpdate();
            } else if ("delete".equals(action)) {
                int serviceId = Integer.parseInt(request.getParameter("service_id"));
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM services WHERE id = ?");
                stmt.setInt(1, serviceId);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("dashboard.jsp");
    }
}
