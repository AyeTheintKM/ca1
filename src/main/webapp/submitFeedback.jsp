<%@ page import="java.sql.*" %>

<%
    // Session validation
    HttpSession session1 = request.getSession(false);
    String userEmail = (String) session.getAttribute("email");

    if (userEmail == null) {
        response.sendRedirect("customer/login.jsp");
        return;
    }

    // Get feedback from the form
    String feedback = request.getParameter("feedback");
    int userId = -1;

    // Database connection details
    Class.forName("com.mysql.cj.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);

    try {
        // Get user ID from email
        String userQuery = "SELECT customer_id FROM users WHERE email = ?";
        PreparedStatement userStmt = conn.prepareStatement(userQuery);
        userStmt.setString(1, userEmail);
        ResultSet userResult = userStmt.executeQuery();
        if (userResult.next()) {
            userId = userResult.getInt("id");
        }

        // Insert feedback into database
        if (userId != -1) {
            String feedbackQuery = "INSERT INTO feedback (user_id, feedback) VALUES (?, ?)";
            PreparedStatement feedbackStmt = conn.prepareStatement(feedbackQuery);
            feedbackStmt.setInt(1, userId);
            feedbackStmt.setString(2, feedback);
            feedbackStmt.executeUpdate();

            request.setAttribute("successMessage", "Your feedback has been submitted.");
        } else {
            request.setAttribute("errorMessage", "Unable to submit feedback. Please try again.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
    }

    // Redirect back to feedback page
    response.sendRedirect("Feedback.jsp");
%>
