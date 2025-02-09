
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String USERNAME = "neondb_owner";
    String PASSWORD = "PCbckaliN31T";
    String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
    Class.forName("org.postgresql.Driver");
    Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);
    
    List<Map<String, Object>> bookings = new ArrayList<>();
    String sql = "SELECT b.booking_id, u.name AS user_name, s.name AS service_name, b.booking_date, b.booking_time, b.instructions, b.status " +
                 "FROM booking b " +
                 "JOIN users u ON b.user_id = u.user_id " +
                 "JOIN services s ON b.service_id = s.service_id";
    
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();

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
    rs.close();
    stmt.close();
    conn.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Manage Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../navbar/adminNavbar.jsp"%>
    <div class="container mt-4">
        <h2>Manage Bookings</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Service</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Instructions</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, Object> booking : bookings) { %>
                <tr>
                    <td><%= booking.get("user_name") %></td>
                    <td><%= booking.get("service_name") %></td>
                    <td><%= booking.get("booking_date") %></td>
                    <td><%= booking.get("booking_time") %></td>
                    <td><%= booking.get("instructions") %></td>
                    <td><%= booking.get("status") %></td>
                    <td>
                        <form action="../AdminBookingServlet" method="post">
                            <input type="hidden" name="booking_id" value="<%= booking.get("booking_id") %>">
                            <select name="status" class="form-select">
                                <option value="Pending" <%= "Pending".equals(booking.get("status")) ? "selected" : "" %>>Pending</option>
                                <option value="Confirmed" <%= "Confirmed".equals(booking.get("status")) ? "selected" : "" %>>Confirmed</option>
                                <option value="Cancelled" <%= "Cancelled".equals(booking.get("status")) ? "selected" : "" %>>Cancelled</option>
                                <option value="Completed" <%= "Completed".equals(booking.get("status")) ? "selected" : "" %>>Completed</option>
                            </select>
                            <button type="submit" name="action" value="update" class="btn btn-sm btn-primary mt-2">Update</button>
                            <button type="submit" name="action" value="delete" class="btn btn-sm btn-danger mt-2">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
