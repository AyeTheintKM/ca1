<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.DBConnection" %>
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
	border: none;
	cursor: pointer;
	font-size: 16px;
}

.form-container form button:hover {
	background-color: #6dabe4;
}
</style>
</head>
<body>
	<header>
		<%@ include file="../navbar/navbar.jsp"%>
	</header>
	<%
	String userEmail = (String) session.getAttribute("useremail");

	if (session == null || session.getAttribute("useremail") == null) {
		// No session or user not logged in, redirect to login page
		response.sendRedirect("../user/login.jsp");
		return;
	}
	%>
	<div class="container1">
		<div class="booking-header">
            <h2>Book a Service</h2>
        </div>
		<%
		String error = request.getParameter("error");
		if ("already_booked".equals(error)) {
		%>
		<div class="alert alert-danger text-center" role="alert">This
			service is already in your cart. You cannot book it again.</div>
		<%
		} else if ("booking_failed".equals(error)) {
		%>
		<div class="alert alert-danger text-center" role="alert">Failed
			to book the service. Please try again.</div>
		<%
		} else if ("internal_error".equals(error)) {
		%>
		<div class="alert alert-danger text-center" role="alert">An
			internal error occurred. Please try again later.</div>
		<%
		}
		%>

		<div class="form-container">
			<%
			int serviceId = Integer.parseInt(request.getParameter("service_id"));
					String USERNAME = "neondb_owner";
					 String PASSWORD = "PCbckaliN31T";
					Class.forName("org.postgresql.Driver");
		            String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
		            Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

			String serviceName = "";
			double price = 0.0;

			String sql = "SELECT * FROM services WHERE service_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, serviceId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				serviceName = rs.getString("name");
				price = rs.getDouble("price");
			}

			rs.close();
			stmt.close();
			conn.close();
			%>

			<form action="../BookingServlet" method="post">
				<input type="hidden" name="service_id" value="<%=serviceId%>">
				<input type="hidden" name="serviceName" value="<%= serviceName %>">
            	<input type="hidden" name="price" value="<%= price %>">
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
				<button type="submit" class="btn btn-primary">Book Service</button>
			</form>
		</div>
	</div>

	 <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>