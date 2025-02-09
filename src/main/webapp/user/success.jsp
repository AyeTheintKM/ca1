<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
if (session == null || session.getAttribute("useremail") == null) {
    response.sendRedirect("login.jsp?error=Please log in");
    return;
}

List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

if (cart == null || cart.isEmpty()) {
    response.sendRedirect("cart.jsp?error=No recent payments found");
    return;
}

int userId = (int) session.getAttribute("userId");

try {
    String USERNAME = "neondb_owner";
    String PASSWORD = "PCbckaliN31T";
    String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
    Class.forName("org.postgresql.Driver");
    Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

    for (Map<String, Object> booking : cart) {
        String sql = "INSERT INTO payments (user_id, service_name, amount, payment_date) VALUES (?, ?, ?, NOW())";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        stmt.setString(2, (String) booking.get("serviceName"));
        stmt.setDouble(3, (double) booking.get("price"));
        stmt.executeUpdate();
        stmt.close();
    }

    conn.close();
    session.removeAttribute("cart");
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("checkout.jsp?error=Payment recording failed");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../navbar/navbar.jsp"%>
    <div class="container mt-5">
        <h2 class="text-center text-success">Payment Successful</h2>
        <p class="text-center">Thank you for your booking! Your payment has been received.</p>
        <div class="text-center">
            <a href="../home/index.jsp" class="btn btn-primary">Return to Home</a>
        </div>
    </div>
</body>
</html>
