package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class UpdateProfileServlet
 */
@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String postalCode = request.getParameter("postalCode");
        String floor = request.getParameter("floor");
        String unit = request.getParameter("unit");
        String street = request.getParameter("street");
        String block = request.getParameter("block");

        try {
            // Database connection
        	Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);

            String sql = "UPDATE user SET name = ?, phone = ?, postal_code = ?, floor = ?, unit = ?, street = ?, block = ? WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, phone);
            stmt.setString(3, postalCode);
            stmt.setString(4, floor);
            stmt.setString(5, unit);
            stmt.setString(6, street);
            stmt.setString(7, block);
            stmt.setInt(8, userId);

            stmt.executeUpdate();

            stmt.close();
            conn.close();

            response.sendRedirect("customer/profile.jsp?update=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customer/profile.jsp?update=fail");
        }
    }
}
