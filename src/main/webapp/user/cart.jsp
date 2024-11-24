<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
if (session == null || session.getAttribute("useremail") == null) {
    response.sendRedirect("login.jsp?error=Please log in to view your cart");
    return;
}

int userId = (int) session.getAttribute("userId");
List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

if (cart == null || cart.isEmpty()) {
    cart = new ArrayList<>();
    try {
        String USERNAME = "neondb_owner";
        String PASSWORD = "PCbckaliN31T";
        String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

        String sql = "SELECT s.name AS serviceName, s.price, b.booking_date, b.booking_time, b.instructions "
                   + "FROM booking b JOIN services s ON b.service_id = s.service_id WHERE b.user_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Map<String, Object> booking = new HashMap<>();
            booking.put("serviceName", rs.getString("serviceName"));
            booking.put("price", rs.getDouble("price"));
            booking.put("bookingDate", rs.getDate("booking_date").toString());
            booking.put("bookingTime", rs.getTime("booking_time").toString());
            booking.put("instructions", rs.getString("instructions"));
            cart.add(booking);
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    session.setAttribute("cart", cart);
}
%>


<!DOCTYPE html>
<html>
<head>
<title>Cart</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.container1 {
	max-width: 1000px;
	margin: 120px auto 50px;
	/* Adjust margin to avoid overlapping with navbar */
	background: #ffffff;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);

}
</style>
</head>
<body>
	<%@ include file="../navbar/navbar.jsp"%>
	<div class="container1">
		<h2 class="text-center mb-4">Your Cart</h2>
		<%
		if (cart.isEmpty()) {
		%>
		<p class="text-center">
			Your cart is empty. <a href="services.jsp">Book a service</a>.
		</p>
		<%
		} else {
		%>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>Service Name</th>
					<th>Price</th>
					<th>Booking Date</th>
					<th>Booking Time</th>
					<th>Special Instructions</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Map<String, Object> booking : cart) {
					String serviceName = (String) booking.get("serviceName");
					double price = (double) booking.get("price");
					String bookingDate = (String) booking.get("bookingDate");
					String bookingTime = (String) booking.get("bookingTime");
					String instructions = (String) booking.get("instructions");
				%>
				<tr>
					<td><%=serviceName%></td>
					<td>$<%=price%></td>
					<td><%=bookingDate%></td>
					<td><%=bookingTime%></td>
					<td><%=instructions%></td>
					<td>
						<form action="../RemoveFromCartServlet" method="post">
							<input type="hidden" name="serviceName"
								value="<%=serviceName%>">
							<button type="submit" class="btn btn-danger btn-sm">Remove</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<div class="text-center">
			<a href="checkout.jsp" class="btn btn-success">Proceed to
				Checkout</a>
		</div>
		<%
		}
		%>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


