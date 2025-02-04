<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%
	String role = (String)session.getAttribute("role");
	if (session == null || role == null || !role.equals("Admin")) {
        response.sendRedirect("../user/login.jsp?error=invalid");
    }
	
	Connection conn = null;
	PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Services</title>
</head>
<body class="m-3 p-2">
    <%@include file="../navbar/adminNavbar.jsp" %>
    <form method="post" action="addNewService.jsp" class="d-flex flex-row mt-5 mb-3 justify-content-between">
        <h2>Services</h2>
        <button class="btn btn-primary">Add New Service</button>
    </form>
    
    <div class="my=3">
        <table class="table table-striped-columns">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Description</th>
                    <th scope="col">Category ID</th>
                    <th scope="col">Price</th>
                    <th scope="col">Image Path</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <% 
                try {
                    conn = DBConnection.getConnection();
                    ps = conn.prepareStatement("SELECT * FROM services");
                    rs = ps.executeQuery();

                    while (rs.next()) {
                    	int id = rs.getInt("service_id");
                    	int category_id = rs.getInt("category_id");
                    	String name = rs.getString("name");
                    	String description = rs.getString("description");
                    	double price = rs.getDouble("price");
                    	String img_path = rs.getString("image_path");
                %>
                    <tr>
                        <th scope="row"><%= id %></th>
                        <td><%= name %></td>
                        <td><%= description %></td>
                        <td><%= category_id %></td>
                        <td><%= price %></td>
                        <td><%= img_path %></td>
                        <td class="button-group d-flex flex-row ">
                     <form action="editServiceForm.jsp" method="post" class="m-1">
                         <input type="hidden" name="id" value="<%= id%>">
                         <input type="hidden" name="name" value="<%= name %>">
                         <input type="hidden" name="description" value="<%= description%>">
         				<input type="hidden" name="category_id" value="<%= category_id%>">
         				<input type="hidden" name="price" value="<%= price%>">
         				<input type="hidden" name="img_path" value="<%= img_path%>">
                         <button type="submit" class="btn-submit">Update</button>
                     </form>
                     <form action="deleteServiceCategory.jsp" method="post" class="m-1">
                         <input type="hidden" name="id" value="<%= id %>">
                         <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this service?');">Delete</button>
                     </form>
                </td>
                    </tr>
                <% 
                        }
                        rs.close();
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='4'>Error fetching data: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
     </div>   
</body>
</html>

