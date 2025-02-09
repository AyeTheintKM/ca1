package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminBookingSummaryServlet")
public class AdminBookingSummaryServlet extends HttpServlet {
    private static final String USERNAME = "neondb_owner";
    private static final String PASSWORD = "PCbckaliN31T";
    private static final String CONN_URL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String month = request.getParameter("month");
        String serviceId = request.getParameter("service_id");

        List<Map<String, Object>> bookings = new ArrayList<>();
        List<Map<String, Object>> topCustomers = new ArrayList<>();
        List<Map<String, Object>> serviceBookings = new ArrayList<>();

        // Establish connection outside try-catch block to properly close resources in finally
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PreparedStatement topStmt = null;
        ResultSet topRs = null;
        PreparedStatement serviceStmt = null;
        ResultSet serviceRs = null;

        try {
            // Create connection
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(CONN_URL, USERNAME, PASSWORD);

            // Booking filtering by date/period/month
            String sql = "SELECT b.booking_id, u.name AS user_name, s.name AS service_name, b.booking_date, b.booking_time, b.instructions, b.status " +
                         "FROM booking b " +
                         "JOIN users u ON b.user_id = u.user_id " +
                         "JOIN services s ON b.service_id = s.service_id";

            if (startDate != null && endDate != null) {
                sql += " WHERE b.booking_date BETWEEN ? AND ?";
            } else if (month != null) {
                sql += " WHERE EXTRACT(MONTH FROM b.booking_date) = EXTRACT(MONTH FROM CAST(? AS DATE))";
            } else if (serviceId != null && !serviceId.isEmpty()) {
                sql += " WHERE b.service_id = ?";
            }

            stmt = conn.prepareStatement(sql);
            if (startDate != null && endDate != null) {
                stmt.setString(1, startDate);
                stmt.setString(2, endDate);
            } else if (month != null) {
                stmt.setString(1, month + "-01");  // Use the first day of the month for filtering
            } else if (serviceId != null && !serviceId.isEmpty()) {
                stmt.setInt(1, Integer.parseInt(serviceId));
            }

            rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("booking_id", rs.getInt("booking_id"));
                booking.put("user_name", rs.getString("user_name"));
                booking.put("service_name", rs.getString("service_name"));
                booking.put("booking_date", rs.getDate("booking_date"));
                booking.put("booking_time", rs.getTime("booking_time"));
                booking.put("instructions", rs.getString("instructions"));
                booking.put("status", rs.getString("status"));
                bookings.add(booking);
            }

            // Top 10 Customers by total value spent on bookings
            String topCustomersSQL = "SELECT u.name AS user_name, SUM(s.price) AS total_spent, COUNT(b.booking_id) AS booking_count " +
                                     "FROM booking b " +
                                     "JOIN users u ON b.user_id = u.user_id " +
                                     "JOIN services s ON b.service_id = s.service_id " +
                                     "WHERE b.status = 'Completed' " +  // Only count completed bookings
                                     "GROUP BY u.user_id ORDER BY total_spent DESC LIMIT 10";
            topStmt = conn.prepareStatement(topCustomersSQL);
            topRs = topStmt.executeQuery();
            while (topRs.next()) {
                Map<String, Object> customer = new HashMap<>();
                customer.put("user_name", topRs.getString("user_name"));
                customer.put("total_spent", topRs.getDouble("total_spent"));
                customer.put("booking_count", topRs.getInt("booking_count"));
                topCustomers.add(customer);
            }

            // Customers who booked specific service
            if (serviceId != null && !serviceId.isEmpty()) {
                String serviceBookingsSQL = "SELECT u.name AS user_name, b.booking_date, b.booking_time " +
                                            "FROM booking b " +
                                            "JOIN users u ON b.user_id = u.user_id " +
                                            "WHERE b.service_id = ? ORDER BY b.booking_date DESC";
                serviceStmt = conn.prepareStatement(serviceBookingsSQL);
                serviceStmt.setInt(1, Integer.parseInt(serviceId));
                serviceRs = serviceStmt.executeQuery();
                while (serviceRs.next()) {
                    Map<String, Object> serviceBooking = new HashMap<>();
                    serviceBooking.put("user_name", serviceRs.getString("user_name"));
                    serviceBooking.put("booking_date", serviceRs.getDate("booking_date"));
                    serviceBooking.put("booking_time", serviceRs.getTime("booking_time"));
                    serviceBookings.add(serviceBooking);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources in reverse order
            try {
                if (serviceRs != null) serviceRs.close();
                if (serviceStmt != null) serviceStmt.close();
                if (topRs != null) topRs.close();
                if (topStmt != null) topStmt.close();
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Set attributes and forward to the JSP
        request.setAttribute("bookings", bookings);
        request.setAttribute("topCustomers", topCustomers);
        request.setAttribute("serviceBookings", serviceBookings);
        request.getRequestDispatcher("/admin/adminBookingSummary.jsp").forward(request, response);
    }
}
