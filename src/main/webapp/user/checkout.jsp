<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.DecimalFormat" %>
<%
if (session == null || session.getAttribute("useremail") == null) {
    response.sendRedirect("login.jsp?error=Please log in to checkout");
    return;
}

List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
if (cart == null || cart.isEmpty()) {
    response.sendRedirect("cart.jsp?error=Your cart is empty");
    return;
}

// Get selected confirmed bookings from the request
String[] selectedBookings = request.getParameterValues("selectedBookings");

if (selectedBookings == null || selectedBookings.length == 0) {
    response.sendRedirect("cart.jsp?error=You must select confirmed bookings to proceed.");
    return;
}

double totalAmount = 0.0;
List<Map<String, Object>> confirmedBookings = new ArrayList<>();

// Filter confirmed bookings based on selection
for (Map<String, Object> booking : cart) {
    String serviceName = (String) booking.get("serviceName");
    if (Arrays.asList(selectedBookings).contains(serviceName) && "Confirmed".equals(booking.get("status"))) {
        confirmedBookings.add(booking);
        totalAmount += (double) booking.get("price");
    }
}

// Calculate GST and total amount with GST
double gstRate = 0.10;
double gstAmount = totalAmount * gstRate;
double totalAmountWithGST = totalAmount + gstAmount;

DecimalFormat df = new DecimalFormat("#.00");
String formattedTotal = df.format(totalAmount);
String formattedTotalWithGST = df.format(totalAmountWithGST);
String formattedGSTAmount = df.format(gstAmount);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <script src="https://js.stripe.com/v3/"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../navbar/navbar.jsp"%>
    <div class="container mt-5">
        <h2 class="text-center">Checkout</h2>
        <p class="text-center">Total Amount (Without GST): <strong>$<%= formattedTotal %></strong></p>
        <p class="text-center">GST (10%): <strong>$<%= formattedGSTAmount %></strong></p>
        <p class="text-center">Total Amount (With GST): <strong>$<%= formattedTotalWithGST %></strong></p>

        <form id="payment-form" action="../PaymentServlet" method="POST" class="text-center">
            <!-- Send the selected bookings and amount with GST to the servlet -->
            <%
            // Add the selected service names to the form as hidden input
            for (String selectedService : selectedBookings) {
            %>
                <input type="hidden" name="selectedBookings" value="<%= selectedService %>">
            <%
            }
            %>
            <input type="hidden" name="amountWithGST" value="<%= formattedTotalWithGST %>">
            <button id="checkout-button" class="btn btn-primary mt-3">Pay Now</button>
        </form>
    </div>

    <script>
        var stripe = Stripe("sk_test_51Qofw8Im9NPq3CmanmgK8o2hyDMM2zZYsimgcjNbpkprMo0r09NxFlkyYiifjx7Ub6h0KmIwobtCiK1ABKtiy1Mv00XUU6rMN9"); // Replace with your Stripe public key

        document.getElementById("checkout-button").addEventListener("click", function(event) {
            event.preventDefault();
            fetch("../PaymentServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams(new FormData(document.getElementById("payment-form"))),
            })
            .then(response => response.json())
            .then(session => stripe.redirectToCheckout({ sessionId: session.id }))
            .catch(error => console.error("Error:", error));
        });
    </script>
</body>
</html>


