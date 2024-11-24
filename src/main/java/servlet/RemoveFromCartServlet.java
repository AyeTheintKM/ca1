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
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class RemoveFromCartServlet
 */
@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve the cart from session
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart != null) {
            String serviceNameToRemove = request.getParameter("serviceName");
            int userId = (int) session.getAttribute("userId"); // Assuming the User ID is stored in the session

            // Remove the booking from the database
            try {
                // Database connection
            	String USERNAME = "neondb_owner";
				 String PASSWORD = "PCbckaliN31T";
				Class.forName("org.postgresql.Driver");
	            String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
	            Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);
                // Delete the booking from the database
                String sql = "DELETE FROM bookings WHERE user_id = ? AND service_id = (SELECT service_id FROM services WHERE name = ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                stmt.setString(2, serviceNameToRemove);

                stmt.executeUpdate();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("user/cart.jsp?error=database_error");
                return;
            }

            // Remove the booking from the session cart
            cart.removeIf(booking -> serviceNameToRemove.equals(booking.get("serviceName")));
            session.setAttribute("cart", cart);
        }

        // Redirect back to the cart page
        response.sendRedirect("user/cart.jsp");
    }
}

