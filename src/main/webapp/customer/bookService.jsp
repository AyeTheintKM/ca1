<%-- 
<%@ page import="java.sql.*"%>
<%@ include file="../includes/header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<title>Book a Service</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar navbar-expand-lg fixed-top">
		<div class="container">
			<a class="navbar-brand me-auto" href="#">Logo</a>
			<div class="offcanvas offcanvas-end" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel">Logo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
						aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<ul class="navbar-nav justify-content-center flex-grow-1 pe-3">
						<li class="nav-item"><a class="nav-link mx-lg-2 active"
							aria-current="page" href="#">Home</a></li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">About</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">Services</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">Portfolio</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">Contact</a>
						</li>

					</ul>

				</div>
			</div>
			
			<a href="profile.jsp" class="login-button"><%=session.getAttribute("user") %></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			
			<a href="../logout" class="login-button">Logout</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			
		</div>
	</nav>
	<section class="book" id="book">
	<h1 class ="heading"><span>book</span> now </h1>
	<div class="row">
	<div class="image">
	<img src="../images/cleaning_994928.png" alt="">
	</div>
	</div>
	</section>
	<h2>Book a Service</h2>
	<form method="post" action="../BookingServlet">
		<label for="service">Select Service:</label> <select name="service_id"
			id="service" required>
			<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM services");
			while (rs.next()) {
			%>
			<option value="<%=rs.getInt("service_id")%>"><%=rs.getString("name")%></option>
			<%
			}
			conn.close();
			%>
		</select><br> <label for="date">Select Date:</label> <input type="date"
			name="date" id="date" required><br> <label for="time">Select
			Time:</label> <input type="time" name="time" id="time" required><br>

		<label for="address">Service Address:</label>
		<textarea name="address" id="address" required></textarea>
		<br>

		<button type="submit">Book Service</button>
	</form>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Service</title>
    <link rel="stylesheet" type="text/css" href="styles/style.css">
</head>
<body>
    <h2>Confirm Your Booking</h2>

    <%
        // Retrieve the service_id from the query parameter
        String serviceIdParam = request.getParameter("service_id");
        String categoryIdParam = request.getParameter("category_id");

        if (serviceIdParam == null || serviceIdParam.isEmpty()) {
            out.println("<p>Error: Service ID is missing. Please go back and try again.</p>");
            return;
        }

        int serviceId = Integer.parseInt(serviceIdParam);
        int categoryId = (categoryIdParam != null && !categoryIdParam.isEmpty()) ? Integer.parseInt(categoryIdParam) : 0;

        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);

        // Fetch service details
        String serviceQuery = "SELECT * FROM services WHERE service_id = ?";
        PreparedStatement serviceStmt = conn.prepareStatement(serviceQuery);
        serviceStmt.setInt(1, serviceId);
        ResultSet serviceRs = serviceStmt.executeQuery();

        String serviceName = "";
        double price = 0;
        if (serviceRs.next()) {
            serviceName = serviceRs.getString("name");
            price = serviceRs.getDouble("price");
        }

        serviceRs.close();
        serviceStmt.close();
        conn.close();
    %>

    <form action="BookingServlet" method="post">
        <p>Service: <strong><%= serviceName %></strong></p>
        <p>Price: $<%= price %></p>
        <p>Date: <input type="date" name="booking_date" required></p>
        <p>Time: <input type="time" name="booking_time" required></p>
        <p>Special Instructions:</p>
        <textarea name="instructions" rows="4" cols="50"></textarea>
        <input type="hidden" name="service_id" value="<%= serviceId %>">
        <input type="hidden" name="category_id" value="<%= categoryId %>">
        <button type="submit">Confirm Booking</button>
    </form>

    <% if (categoryId != 0) { %>
        <a href="../serviceDetails.jsp?category_id=<%= categoryId %>">Back to Service Details</a>
    <% } else { %>
        <a href="../services.jsp">Back to Services</a>
    <% } %>
</body>
</html>


