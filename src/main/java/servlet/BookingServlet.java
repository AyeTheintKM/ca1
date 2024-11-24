package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.*;
import java.util.List;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        String bookingDate = request.getParameter("booking_date");
        String bookingTime = request.getParameter("booking_time");
        String instructions = request.getParameter("instructions");

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId"); // Retrieve logged-in user ID from session

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);

            // Check if the service is already booked by this customer
            String checkSql = "SELECT * FROM bookings WHERE user_id = ? AND service_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, serviceId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Service already booked, redirect with an error message
                response.sendRedirect("customer/bookService.jsp?service_id=" + serviceId + "&error=already_booked");
            } else {
                // Insert booking record
                String insertSql = "INSERT INTO bookings (user_id, service_id, booking_date, booking_time, instructions) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, serviceId);
                insertStmt.setString(3, bookingDate);
                insertStmt.setString(4, bookingTime);
                insertStmt.setString(5, instructions);

                int rows = insertStmt.executeUpdate();
                if (rows > 0) {
                	// Add to cart in session
                    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
                    if (cart == null) {
                        cart = new ArrayList<>();
                    }

                    Map<String, Object> booking = new HashMap<>();
                    booking.put("serviceId", serviceId);
                    booking.put("serviceName", request.getParameter("serviceName"));
                    booking.put("price", Double.parseDouble(request.getParameter("price")));
                    booking.put("bookingDate", bookingDate);
                    booking.put("bookingTime", bookingTime);
                    booking.put("instructions", instructions);

                    cart.add(booking);
                    session.setAttribute("cart", cart);

                    response.sendRedirect("customer/cart.jsp?success=booking_added");
                } else {
                    response.sendRedirect("customer/bookService.jsp?service_id=" + serviceId + "&error=booking_failed");
                }
                insertStmt.close();
            }

            // Close resources
            rs.close();
            checkStmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customer/bookService.jsp?service_id=" + serviceId + "&error=internal_error");
        }
    }
}
