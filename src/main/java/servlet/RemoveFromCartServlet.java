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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ensure the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("useremail") == null) {
            response.sendRedirect("login.jsp?error=Please log in to remove bookings from your cart");
            return;
        }

        // Get the booking ID from the request
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int userId = (int) session.getAttribute("userId");

        try {
            // Database connection details
            String USERNAME = "neondb_owner";
            String PASSWORD = "PCbckaliN31T";
            String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

            // Check if the booking is pending before deleting it
            String checkStatusSql = "SELECT status FROM booking WHERE booking_id = ? AND user_id = ?";
            PreparedStatement checkStatusStmt = conn.prepareStatement(checkStatusSql);
            checkStatusStmt.setInt(1, bookingId);
            checkStatusStmt.setInt(2, userId);
            ResultSet rs = checkStatusStmt.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");

                if ("Pending".equals(status)) {
                    // Proceed to remove the pending booking from the cart
                    String deleteSql = "DELETE FROM booking WHERE booking_id = ? AND user_id = ? AND status = 'Pending'";
                    PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
                    deleteStmt.setInt(1, bookingId);
                    deleteStmt.setInt(2, userId);
                    deleteStmt.executeUpdate();
                    deleteStmt.close();
                }
            }

            rs.close();
            checkStatusStmt.close();
            conn.close();

            // Update the session cart (reload the bookings)
            List<Map<String, Object>> cart = new ArrayList<>();
            String sql = "SELECT s.name AS serviceName, s.price, b.booking_date, b.booking_time, b.instructions, b.status, b.booking_id "
                       + "FROM booking b JOIN services s ON b.service_id = s.service_id WHERE b.user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("bookingId", resultSet.getInt("booking_id"));
                booking.put("serviceName", resultSet.getString("serviceName"));
                booking.put("price", resultSet.getDouble("price"));
                booking.put("bookingDate", resultSet.getDate("booking_date").toString());
                booking.put("bookingTime", resultSet.getTime("booking_time").toString());
                booking.put("instructions", resultSet.getString("instructions"));
                booking.put("status", resultSet.getString("status"));
                cart.add(booking);
            }
            session.setAttribute("cart", cart);

            // Redirect back to the cart page
            response.sendRedirect("user/cart.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/cart.jsp?error=removal_failed");
        }
    }
}
