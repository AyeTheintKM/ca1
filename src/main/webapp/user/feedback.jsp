<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>

<%
if (session == null || session.getAttribute("useremail") == null) {
    response.sendRedirect("login.jsp?error=Please log in to give feedback");
    return;
}

int userId = (int) session.getAttribute("userId");

String USERNAME = "neondb_owner";
String PASSWORD = "PCbckaliN31T";
String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";

Class.forName("org.postgresql.Driver");
Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

// Fetch user's completed bookings for feedback submission
String sql = "SELECT b.booking_id, s.name " +
             "FROM booking b " +
             "JOIN services s ON b.service_id = s.service_id " +
             "WHERE b.user_id = ? AND b.status = 'Completed'";

PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setInt(1, userId);
ResultSet rs = stmt.executeQuery();

// Fetch all feedback
String feedbackQuery = "SELECT f.feedback_id, f.rating, f.comments, u.name AS user_name, s.name AS service_name, f.user_id " +
                       "FROM feedback f " +
                       "JOIN users u ON f.user_id = u.user_id " +
                       "JOIN services s ON f.service_id = s.service_id " +
                       "ORDER BY f.feedback_id DESC";

Statement feedbackStmt = conn.createStatement();
ResultSet feedbackRs = feedbackStmt.executeQuery(feedbackQuery);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit & View Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 100px;
            max-width: 800px;
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .feedback-section {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <%@ include file="../navbar/navbar.jsp" %>

    <div class="container">
        <h2 class="text-center mb-4">Submit Your Feedback</h2>
        <form action="../FeedbackServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Select Completed Booking:</label>
                <select name="bookingId" class="form-select" required>
                    <% while (rs.next()) { %>
                        <option value="<%= rs.getInt("booking_id") %>">
                            <%= rs.getString("name") %> (Booking ID: <%= rs.getInt("booking_id") %>)
                        </option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Rating:</label>
                <select name="rating" class="form-select" required>
                    <option value="5">★★★★★ - Excellent</option>
                    <option value="4">★★★★☆ - Good</option>
                    <option value="3">★★★☆☆ - Average</option>
                    <option value="2">★★☆☆☆ - Poor</option>
                    <option value="1">★☆☆☆☆ - Very Bad</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Comments:</label>
                <textarea name="comments" class="form-control" rows="4" placeholder="Write your feedback..." required></textarea>
            </div>

            <button type="submit" class="btn btn-success w-100">Submit Feedback</button>
        </form>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success mt-3"><%= request.getParameter("success") %></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger mt-3"><%= request.getParameter("error") %></div>
        <% } %>
    </div>

    <div class="container feedback-section">
        <h2 class="text-center mt-5">All User Feedback</h2>
        <div class="table-responsive">
            <table class="table table-bordered mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>User</th>
                        <th>Service</th>
                        <th>Rating</th>
                        <th>Comments</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (feedbackRs.next()) { %>
                    <tr>
                        <td><%= feedbackRs.getString("user_name") %></td>
                        <td><%= feedbackRs.getString("service_name") %></td>
                        <td><%= feedbackRs.getInt("rating") %></td>
                        <td><%= feedbackRs.getString("comments") %></td>
                        <td>
                            <% if (feedbackRs.getInt("user_id") == userId) { %>
                                <form action="../DeleteFeedbackServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="feedbackId" value="<%= feedbackRs.getInt("feedback_id") %>">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
