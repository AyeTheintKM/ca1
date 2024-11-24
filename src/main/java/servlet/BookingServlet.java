//package servlet;
//
//import java.io.IOException;
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.*;
//import java.util.List;
//
//import dao.DBConnection;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/BookingServlet")
//public class BookingServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Retrieve form data
//        int serviceId = Integer.parseInt(request.getParameter("service_id"));
//        String bookingDate = request.getParameter("booking_date");
//        String bookingTime = request.getParameter("booking_time");
//        String instructions = request.getParameter("instructions");
//
//        HttpSession session = request.getSession();
//        int userId = (int) session.getAttribute("userId"); // Retrieve logged-in user ID from session
//
//        try {
//        	String USERNAME = "neondb_owner";
//			 String PASSWORD = "PCbckaliN31T";
//			Class.forName("org.postgresql.Driver");
//           String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
//           Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);
//
//            // Check if the service is already booked by this customer
//            String checkSql = "SELECT * FROM bookings WHERE user_id = ? AND service_id = ?";
//            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
//            checkStmt.setInt(1, userId);
//            checkStmt.setInt(2, serviceId);
//            ResultSet rs = checkStmt.executeQuery();
//
//            if (rs.next()) {
//                // Service already booked, redirect with an error message
//                response.sendRedirect("user/bookService.jsp?service_id=" + serviceId + "&error=already_booked");
//            } else {
//                // Insert booking record
//                String insertSql = "INSERT INTO bookings (user_id, service_id, booking_date, booking_time, instructions) VALUES (?, ?, ?, ?, ?)";
//                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
//                insertStmt.setInt(1, userId);
//                insertStmt.setInt(2, serviceId);
//                insertStmt.setString(3, bookingDate);
//                insertStmt.setString(4, bookingTime);
//                insertStmt.setString(5, instructions);
//
//                int rows = insertStmt.executeUpdate();
//                if (rows > 0) {
//                	// Add to cart in session
//                    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
//                    if (cart == null) {
//                        cart = new ArrayList<>();
//                    }
//
//                    Map<String, Object> booking = new HashMap<>();
//                    booking.put("serviceId", serviceId);
//                    booking.put("serviceName", request.getParameter("serviceName"));
//                    booking.put("price", Double.parseDouble(request.getParameter("price")));
//                    booking.put("bookingDate", bookingDate);
//                    booking.put("bookingTime", bookingTime);
//                    booking.put("instructions", instructions);
//
//                    cart.add(booking);
//                    session.setAttribute("cart", cart);
//
//                    response.sendRedirect("user/cart.jsp?success=booking_added");
//                } else {
//                    response.sendRedirect("user/bookService.jsp?service_id=" + serviceId + "&error=booking_failed");
//                }
//                insertStmt.close();
//            }
//
//            // Close resources
//            rs.close();
//            checkStmt.close();
//            conn.close();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("user/bookService.jsp?service_id=" + serviceId + "&error=internal_error");
//        }
//    }
//}

package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("../user/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        String bookingDate = request.getParameter("booking_date");
        String bookingTime = request.getParameter("booking_time");
        String instructions = request.getParameter("instructions");

        try {
            String USERNAME = "neondb_owner";
            String PASSWORD = "PCbckaliN31T";
            String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

            // Check for existing booking
            String checkSql = "SELECT * FROM booking WHERE user_id = ? AND service_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, serviceId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("user/bookService.jsp?serviceId=" + serviceId + "&error=already_booked");
            } else {
                // Convert bookingDate to java.sql.Date
                java.sql.Date sqlBookingDate = java.sql.Date.valueOf(bookingDate);

                // Convert bookingTime to java.sql.Time
                java.sql.Time sqlBookingTime = java.sql.Time.valueOf(bookingTime + ":00");

                // Insert booking record
                String insertSql = "INSERT INTO booking (user_id, service_id, booking_date, booking_time, instructions) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, serviceId);
                insertStmt.setDate(3, sqlBookingDate); // Correctly handled booking_date
                insertStmt.setTime(4, sqlBookingTime); // Correctly handled booking_time
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
                    response.sendRedirect("user/cart.jsp?success=booking_added");
                } else {
                    response.sendRedirect("user/bookService.jsp?serviceId=" + serviceId + "&error=booking_failed");
                }
                insertStmt.close();
            }
            rs.close();
            checkStmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/bookService.jsp?serviceId=" + serviceId + "&error=internal_error");
        }
    }
}
