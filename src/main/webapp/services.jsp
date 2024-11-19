<%@ page import="java.sql.*" %>
<%-- <%@ include file="includes/header.jsp" %> --%>

<!DOCTYPE html>
<html>
<head>
    <title>Our Services</title>
    <link rel="stylesheet" type="text/css" href="styles/style.css">
</head>
<body>
    <h2>Available Services</h2>
    <ul>
        <% 
            Connection conn = dao.DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM service_category");
            while (rs.next()) { 
        %>
        <li>
            <h3><%= rs.getString("name") %></h3>
            <p><%= rs.getString("description") %></p>
            <a href="serviceDetails.jsp?category_id=<%= rs.getInt("category_id") %>">View Services</a>
        </li>
        <% } %>
    </ul>
</body>
</html>
