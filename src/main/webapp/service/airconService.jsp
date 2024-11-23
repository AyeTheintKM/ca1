<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Aircon Service</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
<link href="./css/service-style.css" rel="stylesheet">
</head>
<body>
	<%@include file="../navbar/navbar.jsp" %>
	<div class="d-flex flex-column mt-5 align-items-center">
		<div class="d-flex flex-row align-items-center">
			<div class="d-flex flex-column col-5">
				<h1>Aircon Service</h1>
				<p>Call now</p>
			</div>
			<img class="col-7" alt="Aircon Service" src="../images/office-cleaning-home-page.png">
		</div>
	</div>
	<ul>
        <% 
	        Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);
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
	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
</body>
</html>