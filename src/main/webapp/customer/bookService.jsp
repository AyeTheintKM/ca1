<%@ page import="java.sql.*" %>
<%-- <%@ include file="../includes/header.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Service</title>
    <link rel="stylesheet" href="../styles/style.css">
</head>
<body>
    <h2>Book a Service</h2>
    <form method="post" action="../BookingServlet">
        <label for="service">Select Service:</label>
        <select name="service_id" id="service" required>
            <% 
            	Class.forName("com.mysql.cj.jdbc.Driver");
				String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
				Connection conn = DriverManager.getConnection(connURL);
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM services");
                while (rs.next()) {
            %>
            <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %></option>
            <% } conn.close(); %>
        </select><br>

        <label for="date">Select Date:</label>
        <input type="date" name="date" id="date" required><br>

        <label for="time">Select Time:</label>
        <input type="time" name="time" id="time" required><br>

        <label for="address">Service Address:</label>
        <textarea name="address" id="address" required></textarea><br>

        <button type="submit">Book Service</button>
    </form>
</body>
</html>
