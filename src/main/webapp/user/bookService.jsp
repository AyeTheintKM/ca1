<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
<title>Book Service</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
<style>
/* Your styles remain unchanged */
header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
	background-color: #ffffff;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.container1 {
	max-width: 800px;
	margin: 120px auto 50px;
	/* Adjust margin to avoid overlapping with navbar */
	background: #ffffff;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.booking-header {
	background-color: #6dabe4;
	color: white;
	padding: 20px;
	text-align: center;
}

.booking-header h2 {
	margin: 0;
}

.form-container {
	padding: 30px;
}

.form-container form {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.form-container form label {
	font-weight: bold;
}

.form-container form input, .form-container form textarea,
	.form-container form button {
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
}

.form-container form input:focus, .form-container form textarea:focus {
	outline: none;
	border-color: #4a90e2;
}

.form-container form button {
	background-color: #6dabe4;
	color: white;
	border:2px solid transparent;
	border-radius: 30px;
	cursor: pointer;
	font-size: 16px;
	vertical-align: middle;
	margin: 0;
}

.form-container form button:hover {
	background-color: transparent;
	color: #6dabe4;
	border-color: #6dabe4;
}

</style>
</head>
<body>
	<header>
		<%@ include file="../navbar/navbar.jsp"%>
	</header>
	<%
	// Ensure session is valid
	if (session == null || session.getAttribute("useremail") == null) {
		response.sendRedirect("../user/login.jsp");
		return;
	}

	// Fetch service details
	int serviceId = Integer.parseInt(request.getParameter("serviceId"));
	String serviceName = "";
	double price = 0.0;
	String imagePath = "";

	try {
		String USERNAME = "neondb_owner";
		String PASSWORD = "PCbckaliN31T";
		String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
		Class.forName("org.postgresql.Driver");
		Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

		String sql = "SELECT * FROM services WHERE service_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, serviceId);
		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			serviceName = rs.getString("name");
			price = rs.getDouble("price");
			imagePath = rs.getString("image_path");
		}

		rs.close();
		stmt.close();
		conn.close();
	} catch (Exception e) {
		out.println("<div class='alert alert-danger'>Error loading service details: " + e.getMessage() + "</div>");
		e.printStackTrace();
	}
	%>
	<div class="container1">
		<h2 class="booking-header">Book a Service</h2>
		<%
		String error = request.getParameter("error");
		if (error != null) {
			String errorMessage = "";
			if ("already_booked".equals(error)) {
				errorMessage = "This service is already in your cart. You cannot book it again.";
			} else if ("booking_failed".equals(error)) {
				errorMessage = "Failed to book the service. Please try again.";
			} else if ("internal_error".equals(error)) {
				errorMessage = "An internal error occurred. Please try again later.";
			}
		%>
		<div class="alert alert-danger text-center" role="alert"><%=errorMessage%></div>
		<%
		}
		%>
		<div class="form-container">
			<form action="../BookingServlet" method="post">
				<input type="hidden" name="service_id" value="<%=serviceId%>">
				<input type="hidden" name="serviceName" value="<%=serviceName%>">
				<input type="hidden" name="price" value="<%=price%>"> <input
					type="hidden" name="image" value="<%=imagePath%>">

				<div class="mb-3">
					<label for="serviceName" class="form-label">Service Name</label> <input
						type="text" class="form-control" id="serviceName"
						value="<%=serviceName%>" readonly>
				</div>
				<div class="mb-3">
					<label for="price" class="form-label">Price</label> <input
						type="text" class="form-control" id="price" value="$<%=price%>"
						readonly>
				</div>
				<div class="mb-3">
					<label for="bookingDate" class="form-label">Booking Date</label> <input
						type="date" class="form-control" id="bookingDate"
						name="booking_date" required>
				</div>
				<div class="mb-3">
					<label for="bookingTime" class="form-label">Booking Time</label> <input
						type="time" class="form-control" id="bookingTime"
						name="booking_time" required>
				</div>
				<div class="mb-3">
					<label for="instructions" class="form-label">Special
						Instructions</label>
					<textarea class="form-control" id="instructions"
						name="instructions" rows="3"></textarea>
				</div>
				<button type="submit" class="btn btn-primary">ADD TO CART</button>
			</form>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>