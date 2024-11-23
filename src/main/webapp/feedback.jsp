<%@ page import="java.sql.*" %>

<%
    // Session validation
    HttpSession session1 = request.getSession(false);
    String userEmail = (String) session.getAttribute("email"); // Get user email from session
    int userId = -1; // User ID placeholder
    boolean isEligible = false;

    // Database connection details
   Class.forName("com.mysql.cj.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);

    try {
        // Check if the user is logged in
        if (userEmail != null) {
            // Retrieve user ID based on session email
            String userQuery = "SELECT id FROM users WHERE email = ?";
            PreparedStatement userStmt = conn.prepareStatement(userQuery);
            userStmt.setString(1, userEmail);
            ResultSet userResult = userStmt.executeQuery();
            if (userResult.next()) {
                userId = userResult.getInt("id");
            }

            // Check if the user has completed a booking
            String bookingQuery = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND status = 'completed'";
            PreparedStatement bookingStmt = conn.prepareStatement(bookingQuery);
            bookingStmt.setInt(1, userId);
            ResultSet bookingResult = bookingStmt.executeQuery();
            if (bookingResult.next() && bookingResult.getInt(1) > 0) {
                isEligible = true; // User is eligible to give feedback
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Feedback</h2>
        <%
            if (userEmail == null) {
        %>
        <p class="text-danger">You must log in to leave feedback.</p>
        <a href="login.jsp" class="btn btn-primary">Login</a>
        <%
            } else if (!isEligible) {
        %>
        <p class="text-warning">You must complete a booking to leave feedback.</p>
        <%
            } else {
        %>
        <!-- Feedback Form -->
        <form action="SubmitFeedback.jsp" method="post" class="mb-5">
            <div class="mb-3">
                <label for="feedback" class="form-label">Your Feedback</label>
                <textarea class="form-control" id="feedback" name="feedback" rows="4" required></textarea>
            </div>
            <button type="submit" class="btn btn-success">Submit Feedback</button>
        </form>
        <%
            }
        %>

        <!-- Display Feedback -->
        <h3>What Others Say</h3>
        <div class="feedback-list">
            <%
                try {
                    String feedbackQuery = "SELECT u.name, f.feedback, f.created_at FROM feedback f INNER JOIN users u ON f.user_id = u.id ORDER BY f.created_at DESC";
                    Statement feedbackStmt = conn.createStatement();
                    ResultSet feedbackResult = feedbackStmt.executeQuery(feedbackQuery);
                    while (feedbackResult.next()) {
                        String name = feedbackResult.getString("name");
                        String feedbackText = feedbackResult.getString("feedback");
                        Timestamp createdAt = feedbackResult.getTimestamp("created_at");
            %>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title"><%= name %></h5>
                    <p class="card-text"><%= feedbackText %></p>
                    <small class="text-muted">Posted on <%= createdAt %></small>
                </div>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
</body>
</html>
