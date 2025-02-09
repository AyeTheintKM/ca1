
package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


@WebServlet("/AdminBookingServlet")
public class AdminBookingServlet extends HttpServlet {
    private static final String USERNAME = "neondb_owner";
    private static final String PASSWORD = "PCbckaliN31T";
    private static final String CONN_URL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(CONN_URL, USERNAME, PASSWORD);

            if ("update".equals(action)) {
                String status = request.getParameter("status");
                String sql = "UPDATE booking SET status = ? WHERE booking_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, status);
                stmt.setInt(2, bookingId);
                stmt.executeUpdate();
                stmt.close();
            } else if ("delete".equals(action)) {
                String sql = "DELETE FROM booking WHERE booking_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, bookingId);
                stmt.executeUpdate();
                stmt.close();
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin/adminBookings.jsp");
    }
}

