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
    <title>Manage Service Category</title>
</head>
<body class="m-3 p-2">
    <%@include file="../navbar/adminNavbar.jsp" %>
    <div class="mt-5 mb-3">
        <h2>Service Category</h2>
    </div>
    <div class="d-flex flex-row align-items-start justify-content-around" >
        <form method="post" class="row g-3 col-5 p-3 my-3 border border-secondary-subtle rounded-5" action="addNewServiceCategory.jsp" name="serviceCategory">
            <div class="col-md-12">
                <label for="categoryName" class="form-label">Category Name</label>
                <input type="text" class="form-control" id="categoryName" name="categoryName" required>
              </div>
              <div class="col-md-12">
                <label for="categoryDescription" class="form-label">Category Description</label>
                <textarea class="form-control" id="categoryDescription" name="categoryDescription" rows="3" required></textarea>
            </div>
            <div class="col-12">
                <button class="btn btn-primary" type="submit">Add</button>
            </div>
        </form>
    </div>
    
    <div class="my=3">
        <table class="table table-striped-columns">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Description</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <% 
                try {
                    conn = DBConnection.getConnection();
                    ps = conn.prepareStatement("SELECT * FROM service_category");
                    rs = ps.executeQuery();

                    while (rs.next()) {
                    	int category_id = rs.getInt("category_id");
                    	String name = rs.getString("name");
                    	String description = rs.getString("description");
                %>
                    <tr>
                        <th scope="row"><%= category_id %></th>
                        <td><%= name %></td>
                        <td><%= description %></td>
                        <td class="button-group d-flex flex-row ">
                     <form action="editServiceCategoryForm.jsp" method="post" class="m-1">
                         <input type="hidden" name="id" value="<%= category_id%>">
                         <input type="hidden" name="name" value="<%= name %>">
                         <input type="hidden" name="description" value="<%= description%>">
         
                         <button type="submit" class="btn-submit">Update</button>
                     </form>
                     <form action="deleteServiceCategory.jsp" method="post" class="m-1">
                         <input type="hidden" name="id" value="<%= category_id %>">
                         <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this category?');">Delete</button>
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

