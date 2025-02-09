<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.DBConnection" %>

<%
// Check if the session is valid
if (session == null || session.getAttribute("userId") == null) {
	response.sendRedirect("login.jsp?error=Please log in to access your profile");
	return;
}

int userId = (int) session.getAttribute("userId");

// Database connection

String USERNAME = "neondb_owner";
String PASSWORD = "PCbckaliN31T";
					Class.forName("org.postgresql.Driver");
		            String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
		            Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

// Fetch user details
String sql = "SELECT * FROM users WHERE user_id = ?";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setInt(1, userId);
ResultSet rs = stmt.executeQuery();

String name = "", email = "", phone = "", postalCode = "", floor = "", unit = "", street = "", block = "";
if (rs.next()) {
	name = rs.getString("name");
	email = rs.getString("email");
	phone = rs.getString("phone");
	postalCode = rs.getString("postal_code");
	floor = rs.getString("floor");
	unit = rs.getString("unit");
	street = rs.getString("street");
	block = rs.getString("block");
}

rs.close();
stmt.close();
conn.close();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Your Profile</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Arial', sans-serif;
}


.profile-container {
	display: flex;
	justify-content: space-between;
	gap: 30px;
	margin: 120px auto 50px;
}

.profile-header {
	background: linear-gradient(135deg, #6c7bff, #4b61ff);
	padding: 40px;
	color: white;
	text-align: center;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	width: 300px; /* Fixed width for profile section */
	flex-shrink: 0; /* Prevents shrinking on small screens */
}

.profile-header img {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	object-fit: cover;
	border: 4px solid white;
	margin-bottom: 20px;
	transition: transform 0.3s ease-in-out;
}

.profile-header img:hover {
	transform: scale(1.1);
}

.profile-info {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	width: 100%; /* Flexes to fill available space */
	flex-grow: 1;
}

.profile-info h2 {
	font-size: 28px;
	font-weight: 600;
	color: #333;
	margin-bottom: 30px;
}

.profile-info .row {
	margin-bottom: 15px;
}

.profile-info .row label {
	font-weight: 600;
	color: #555;
}

.profile-info .row .col-md-6 {
	font-size: 16px;
	color: #777;
}

.form-control, .form-select {
	border-radius: 8px;
	border: 1px solid #e0e0e0;
	padding: 12px;
	font-size: 16px;
	background-color: #f9f9f9;
}

.form-control:focus, .form-select:focus {
	border-color: #6c7bff;
	box-shadow: 0 0 5px rgba(108, 123, 255, 0.5);
}

.btn-primary {
	background-color: #6c7bff;
	border: none;
	padding: 10px 30px;
	font-size: 16px;
	font-weight: 600;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.btn-primary:hover {
	background-color: #4b61ff;
}

.btn-danger {
	background-color: #ff4f5a;
	border: none;
	padding: 10px 30px;
	font-size: 16px;
	font-weight: 600;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.btn-danger:hover {
	background-color: #e53d4c;
}

.action-buttons {
	display: flex;
	gap: 20px;
	justify-content: space-between;
	margin-top: 30px;
}

.action-buttons .btn {
	flex-grow: 1;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.profile-container {
		flex-direction: column;
		align-items: center;
	}
	.profile-header {
		width: 100%;
		margin-bottom: 20px;
	}
	.profile-info {
		width: 100%;
	}
}
</style>
</head>
<body>
	<%@include file="../navbar/navbar.jsp"%>

	<div class="container profile-container">
		<!-- Profile Header -->
		<div class="profile-header">
			<img src="https://via.placeholder.com/150" alt="User Avatar">
			<h1 class="display-4">
				Hello,
				<%=name%>!
			</h1>
			<p>Welcome to your profile page. Here you can update your
				personal details.</p>
		</div>

		<!-- Profile Info Section -->
		<div class="profile-info">
			<h2>Profile Information</h2>
			<form action="../UpdateProfileServlet" method="post">
				<div class="row">
					<div class="col-md-6">
						<label for="name">Full Name</label> <input type="text"
							class="form-control" id="name" name="name" value="<%=name%>"
							required>
					</div>
					<div class="col-md-6">
						<label for="email">Email Address</label> <input type="email"
							class="form-control" id="email" name="email" value="<%=email%>"
							readonly>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="phone">Phone Number</label> <input type="text"
							class="form-control" id="phone" name="phone" value="<%=phone%>"
							required>
					</div>
					<div class="col-md-6">
						<label for="postalCode">Postal Code</label> <input type="text"
							class="form-control" id="postalCode" name="postalCode"
							value="<%=postalCode%>" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="floor">Floor</label> <input type="text"
							class="form-control" id="floor" name="floor" value="<%=floor%>">
					</div>
					<div class="col-md-6">
						<label for="unit">Unit</label> <input type="text"
							class="form-control" id="unit" name="unit" value="<%=unit%>">
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="street">Street</label> <input type="text"
							class="form-control" id="street" name="street"
							value="<%=street%>">
					</div>
					<div class="col-md-6">
						<label for="block">Block</label> <input type="text"
							class="form-control" id="block" name="block" value="<%=block%>">
					</div>
				</div>

				<div class="action-buttons">
					<button type="submit" class="btn btn-primary">Update
						Profile</button>
					<a href="../DeleteProfileServlet" class="btn btn-danger">Delete
						Account</a>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
