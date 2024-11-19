<%-- <%@ include file="../includes/adminHeader.jsp" %> --%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Services</title>
</head>
<body>
    <h2>Service Management</h2>
    <form method="post" action="../AdminServiceServlet">
        <label>Service Name:</label>
        <input type="text" name="name" required><br>
        <label>Description:</label>
        <textarea name="description" required></textarea><br>
        <label>Category:</label>
        <select name="category">
            <% 
            	Class.forName("com.mysql.cj.jdbc.Driver");
				String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
				Connection conn = DriverManager.getConnection(connURL);
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM service_category");
                while (rs.next()) { 
            %>
            <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %></option>
            <% } conn.close(); %>
        </select><br>
        <button type="submit">Add Service</button>
    </form>
</body>
</html>
