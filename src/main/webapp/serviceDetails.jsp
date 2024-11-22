<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Service Details</title>
    <link rel="stylesheet" type="text/css" href="../styles/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Service Details</h1>
        </header>

        <nav>
            <a href="index.jsp">Home</a> |
            <a href="services.jsp">All Services</a> |
            <a href="customer/bookService.jsp">Book Now</a>
        </nav>

        <main>
            <%
                // Get the service ID from the request parameter
                String serviceId = request.getParameter("category_id");

                if (serviceId == null) {
                    out.println("<p>Service ID is missing. Please go back and select a valid service.</p>");
                } else {
                    try {
                    	Class.forName("com.mysql.cj.jdbc.Driver");
            			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
            			Connection conn = DriverManager.getConnection(connURL);
                        // SQL query to fetch service details
                        String sql = "SELECT s.service_id, s.name, s.description, s.price, s.image_path, c.category_name " +
                                     "FROM services s " +
                                     "JOIN service_category c ON s.category_id = c.category_id " +
                                     "WHERE s.service_id = ?";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        stmt.setString(1, serviceId);
                        ResultSet rs = stmt.executeQuery();

                        if (rs.next()) {
                            String name = rs.getString("name");
                            String description = rs.getString("description");
                            double price = rs.getDouble("price");
                            String imagePath = rs.getString("image_path");
                            String categoryName = rs.getString("category_name");

                            // Display service details
                            %>
                            <div class="service-details">
                                <h2><%= name %></h2>
                                <img src="<%= imagePath %>" alt="<%= name %>" class="service-image">
                                <p><strong>Category:</strong> <%= categoryName %></p>
                                <p><strong>Description:</strong> <%= description %></p>
                                <p><strong>Price:</strong> $<%= price %></p>

                                <a href="customer/bookService.jsp?id=<%= serviceId %>" class="button">Book This Service</a>
                            </div>
                            <%
                        } else {
                            out.println("<p>Service not found. Please go back and select a valid service.</p>");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Error fetching service details. Please try again later.</p>");
                    }
                }
            %>
        </main>

        <footer>
            <p>&copy; 2024 Cleaning Services</p>
        </footer>
    </div>
</body>
</html>
title>Insert title here</title>
</head>
<body>

</body>
</html>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Service Details</title>
    <link rel="stylesheet" type="text/css" href="styles/style.css">
</head>
<body>
    <h2>Services in Selected Category</h2>

    <% 
        // Retrieve the category_id from the query parameter
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);

        // Fetch category name
        String categoryName = "";
        String categoryQuery = "SELECT name FROM service_category WHERE category_id = ?";
        PreparedStatement categoryStmt = conn.prepareStatement(categoryQuery);
        categoryStmt.setInt(1, categoryId);
        ResultSet categoryRs = categoryStmt.executeQuery();
        if (categoryRs.next()) {
            categoryName = categoryRs.getString("name");
        }
    %>
    <h3>Category: <%= categoryName %></h3>

    <ul>
        <%
            // Fetch services for the selected category
            String serviceQuery = "SELECT * FROM services WHERE category_id = ?";
            PreparedStatement serviceStmt = conn.prepareStatement(serviceQuery);
            serviceStmt.setInt(1, categoryId);
            ResultSet serviceRs = serviceStmt.executeQuery();

            // Display each service
            while (serviceRs.next()) {
        %>
        <li>
            <h4><%= serviceRs.getString("name") %></h4>
            <p><%= serviceRs.getString("description") %></p>
            <p>Price: $<%= serviceRs.getDouble("price") %></p>
            <img src="<%= serviceRs.getString("image") %>" alt="<%= serviceRs.getString("name") %>" width="200">
        </li>
        <%
            }
            serviceRs.close();
            serviceStmt.close();
            conn.close();
        %>
    </ul>

    <a href="services.jsp">Back to Services</a>
</body>
</html>

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Service Details</title>
    <link rel="stylesheet" type="text/css" href="styles/style.css">
</head>
<body>
    <h2>Services in Selected Category</h2>

    <% 
        // Retrieve the category_id from the query parameter
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);

        // Fetch category name
        String categoryName = "";
        String categoryQuery = "SELECT name FROM service_category WHERE category_id = ?";
        PreparedStatement categoryStmt = conn.prepareStatement(categoryQuery);
        categoryStmt.setInt(1, categoryId);
        ResultSet categoryRs = categoryStmt.executeQuery();
        if (categoryRs.next()) {
            categoryName = categoryRs.getString("name");
        }
    %>
    <h3>Category: <%= categoryName %></h3>

    <ul>
        <%
            // Fetch services for the selected category
            String serviceQuery = "SELECT * FROM services WHERE category_id = ?";
            PreparedStatement serviceStmt = conn.prepareStatement(serviceQuery);
            serviceStmt.setInt(1, categoryId);
            ResultSet serviceRs = serviceStmt.executeQuery();

            // Display each service
            while (serviceRs.next()) {
                int serviceId = serviceRs.getInt("service_id");
        %>
        <li>
            <h4><%= serviceRs.getString("name") %></h4>
            <p><%= serviceRs.getString("description") %></p>
            <p>Price: $<%= serviceRs.getDouble("price") %></p>
            <img src="<%= serviceRs.getString("image") %>" alt="<%= serviceRs.getString("name") %>" width="200">
            <br>
            <!-- Booking button -->
            <a href="customer/bookService.jsp?service_id=<%= serviceId %>">Book Now</a>
        </li>
        <%
            }
            serviceRs.close();
            serviceStmt.close();
            conn.close();
        %>
    </ul>

    <a href="services.jsp">Back to Services</a>
</body>
</html>


