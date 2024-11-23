package servlet;

import java.io.IOException;
import java.sql.*;

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

        // Placeholder for logged-in user ID (replace with session-based retrieval in production)
        int customerId = 1; 

        // Database connection
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);
            // Insert booking record
            String sql = "INSERT INTO bookings (customer_id, service_id, booking_date, booking_time, instructions) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            stmt.setInt(2, serviceId);
            stmt.setString(3, bookingDate);
            stmt.setString(4, bookingTime);
            stmt.setString(5, instructions);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("customer/profile.jsp?success=1");
            } else {
                response.sendRedirect("bookService.jsp?service_id=" + serviceId + "&error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("bookService.jsp?service_id=" + serviceId + "&error=2");
        }
    }
}

//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//
//        if (session == null || session.getAttribute("user") == null) {
//            response.sendRedirect("customer/login.jsp");
//            return;
//        }
//
//        int customerId = (int) session.getAttribute("customer_id");
//        int serviceId = Integer.parseInt(request.getParameter("service_id"));
//        String date = request.getParameter("date");
//        String time = request.getParameter("time");
//        String address = request.getParameter("address");
//
//        try  {
//        	Class.forName("com.mysql.cj.jdbc.Driver");
//			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
//			Connection conn = DriverManager.getConnection(connURL);
//            PreparedStatement stmt = conn.prepareStatement(
//                "INSERT INTO bookings (customer_id, service_id, date, time, address) VALUES (?, ?, ?, ?, ?)");
//            stmt.setInt(1, customerId);
//            stmt.setInt(2, serviceId);
//            stmt.setString(3, date);
//            stmt.setString(4, time);
//            stmt.setString(5, address);
//            stmt.executeUpdate();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        response.sendRedirect("customer/profile.jsp");
//    }
//}
