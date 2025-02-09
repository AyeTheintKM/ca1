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

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
    private static final String DB_USER = "neondb_owner";
    private static final String DB_PASS = "PCbckaliN31T";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check if the user is logged in
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("/user/login.jsp?error=Please log in to give feedback");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comments = request.getParameter("comments");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Set up the connection
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Get the service_id from the booking table
            String serviceIdQuery = "SELECT service_id FROM booking WHERE booking_id = ?";
            stmt = conn.prepareStatement(serviceIdQuery);
            stmt.setInt(1, bookingId);
            rs = stmt.executeQuery();

            int serviceId = 0;
            if (rs.next()) {
                serviceId = rs.getInt("service_id");
            }

            // Check if service_id is found for the given booking_id
            if (serviceId == 0) {
                response.sendRedirect("user/feedback.jsp?error=Service not found for the given booking.");
                return;
            }

            // Insert the feedback data into the feedback table
            String insertFeedbackQuery = "INSERT INTO feedback (user_id, booking_id, service_id, rating, comments) " +
                    "VALUES (?, ?, ?, ?, ?)";

            stmt = conn.prepareStatement(insertFeedbackQuery);
            stmt.setInt(1, userId);
            stmt.setInt(2, bookingId);
            stmt.setInt(3, serviceId);
            stmt.setInt(4, rating);
            stmt.setString(5, comments);
            stmt.executeUpdate();

            response.sendRedirect("user/feedback.jsp?success=Feedback submitted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/feedback.jsp?error=An error occurred. Please try again.");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
