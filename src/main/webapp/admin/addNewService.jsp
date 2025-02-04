<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    try {
        conn = DBConnection.getConnection();
        ps = conn.prepareStatement("SELECT * FROM service_category");
        rs = ps.executeQuery();
        
        ArrayList<String> categories = new ArrayList<>();

        while (rs.next()) {
     	   String category_name= rs.getInt("category_id") + " " + rs.getString("name");
     	   if (!categories.contains(category_name)) {
     		  categories.add(category_name);
            }
        }
        session.setAttribute("categories", categories);
        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='4'>Error fetching data: " + e.getMessage() + "</td></tr>");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Service</title>
</head>
<body class="m-3 p-2">
    <%@include file="../navbar/adminNavbar.jsp" %>
    <div class="mt-5 mb-3">
        <h2>Services</h2>
    </div>
    <div class="d-flex flex-row align-items-center justify-content-around" >
        <form method="post" class="row g-3 col-8 p-3 my-3 border border-secondary-subtle rounded-5" action="newService.jsp" name="service">
            <div class="col-md-12">
                <label for="serviceName" class="form-label">Service Name</label>
                <input type="text" class="form-control" id="serviceName" name="serviceName" required>
              </div>
              <div class="col-md-6">
                  <label for="category" class="form-label">Category</label>
                  <select class="form-select" id="category" name="category" required>
                    <option selected disabled value="">Select Category</option>
                    <%
			            ArrayList<String> categories = (ArrayList<String>) session.getAttribute("categories");
			            if (categories != null) {
			                for (String category : categories) {
			        %>
			                <option value="<%= category %>"><%= category %></option>
			        <%
			                }
			            } else {
			        %>
			                <option value="" disabled>No categories available</option>
			        <%
			            }
			        %>
                  </select>
                </div>
                <div class="col-md-4">
                    <label for="servicePrice" class="form-label">Price</label>
                    <input type="text" class="form-control" id="servicePrice" name="servicePrice" required>
                </div>
              <div class="col-md-12">
                <label for="serviceDescription" class="form-label">Service Description</label>
                <textarea class="form-control" id="serviceDescription" name="serviceDescription" rows="3" required></textarea>
            </div>
            <div class="col-12">
                <button class="btn btn-primary" type="submit">Add</button>
            </div>
        </form>
    </div>
   </body>
</html>