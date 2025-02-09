<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    // Database connection setup
    String url = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
    String user = "neondb_owner";
    String password = "PCbckaliN31T";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    // Get parameters for filtering
    String dateFilter = request.getParameter("date");
    String monthFilter = request.getParameter("month");
    String serviceId = request.getParameter("service_id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cleaning Service Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../navbar/adminNavbar.jsp" %>

    <div class="container mt-4">
        <h2 class="mb-4">Cleaning Service Report</h2>

        <!-- Filter Section -->
        <div class="card mb-4">
            <div class="card-header">Filter Bookings</div>
            <div class="card-body">
                <form method="get" class="row g-3">
                    <div class="col-md-4">
                        <label for="date" class="form-label">Booking Date</label>
                        <input type="date" id="date" name="date" class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label for="month" class="form-label">Booking Month</label>
                        <input type="number" id="month" name="month" min="1" max="12" class="form-control">
                    </div>
                    <div class="col-md-4 align-self-end">
                        <button type="submit" class="btn btn-primary w-100">Filter</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Top 10 Customers by Value -->
        <div class="card mb-4">
            <div class="card-header">Top 10 Customers by Booking Value</div>
            <div class="card-body">
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>User ID</th>
                            <th>Total Amount Spent</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                conn = DriverManager.getConnection(url, user, password);
                                stmt = conn.createStatement();

                                String query = "SELECT b.user_id, SUM(s.price * b.quantity) AS total_spent " +
                                               "FROM booking b " +
                                               "JOIN services s ON b.service_id = s.service_id " +
                                            	"WHERE b.status = 'Completed' " +
                                               "GROUP BY b.user_id " +
                                               "ORDER BY total_spent DESC " +
                                               "LIMIT 10";

                                rs = stmt.executeQuery(query);

                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("user_id") %></td>
                            <td>$<%= rs.getDouble("total_spent") %></td>
                        </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Bookings List -->
        <div class="card mb-4">
            <div class="card-header">Bookings List</div>
            <div class="card-body">
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>Booking ID</th>
                            <th>User ID</th>
                            <th>Service ID</th>
                            <th>Booking Date</th>
                            <th>Booking Time</th>
                            <th>Status</th>
                            <th>Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                conn = DriverManager.getConnection(url, user, password);
                                stmt = conn.createStatement();

                                String query = "SELECT * FROM booking WHERE 1=1";

                                if (dateFilter != null && !dateFilter.isEmpty()) {
                                    query += " AND booking_date = '" + dateFilter + "'";
                                }

                                if (monthFilter != null && !monthFilter.isEmpty()) {
                                    query += " AND EXTRACT(MONTH FROM booking_date) = " + monthFilter;
                                }

                                rs = stmt.executeQuery(query);

                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("booking_id") %></td>
                            <td><%= rs.getInt("user_id") %></td>
                            <td><%= rs.getInt("service_id") %></td>
                            <td><%= rs.getDate("booking_date") %></td>
                            <td><%= rs.getTime("booking_time") %></td>
                            <td><%= rs.getString("status") %></td>
                            <td><%= rs.getInt("quantity") %></td>
                        </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Customers Who Booked a Specific Service -->
        <div class="card mb-4">
            <div class="card-header">Customers Who Booked a Specific Service</div>
            <div class="card-body">
                <form method="get" class="row g-3">
                    <div class="col-md-8">
                        <label for="service_id" class="form-label">Service ID</label>
                        <input type="number" id="service_id" name="service_id" class="form-control">
                    </div>
                    <div class="col-md-4 align-self-end">
                        <button type="submit" class="btn btn-primary w-100">Show Customers</button>
                    </div>
                </form>

                <table class="table table-bordered mt-3">
                    <thead class="table-dark">
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (serviceId != null && !serviceId.isEmpty()) {
                                try {
                                    conn = DriverManager.getConnection(url, user, password);
                                    stmt = conn.createStatement();

                                    String customerQuery = "SELECT DISTINCT u.name, u.email, u.phone " +
                                                           "FROM booking b " +
                                                           "JOIN users u ON b.user_id = u.user_id " +
                                                           "WHERE b.service_id = " + serviceId;

                                    rs = stmt.executeQuery(customerQuery);

                                    while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("phone") %></td>
                        </tr>
                        <%
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</body>
</html>
