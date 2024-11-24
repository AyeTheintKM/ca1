<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    if (session == null || session.getAttribute("useremail") == null) {
        response.sendRedirect("login.jsp?error=Please log in to view your cart");
        return;
    }

    // Retrieve the cart from the session
    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../navbar/navbar.jsp" %>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Your Cart</h2>
        <%
            if (cart.isEmpty()) {
        %>
        <p class="text-center">Your cart is empty. <a href="services.jsp">Book a service</a>.</p>
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
                    <td><%= serviceName %></td>
                    <td>$<%= price %></td>
                    <td><%= bookingDate %></td>
                    <td><%= bookingTime %></td>
                    <td><%= instructions %></td>
                    <td>
                        <form action="../RemoveFromCartServlet" method="post">
                            <input type="hidden" name="serviceName" value="<%= serviceName %>">
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
            <a href="checkout.jsp" class="btn btn-success">Proceed to Checkout</a>
        </div>
        <%
            }
        %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


