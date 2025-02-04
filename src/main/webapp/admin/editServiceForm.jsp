<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<% 
	String role = (String) session.getAttribute("role");
	if (session == null || !role.equals("Admin")) {
		response.sendRedirect("../user/login.jsp?errCode=invalidAccess");
	} else if (role == null){
		response.sendRedirect("../user/login.jsp?errCode=invalidAccess");
	}
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Service form</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body class="m-3 p-2">
    <%@include file="../navbar/adminNavbar.jsp" %>
    <div class="mt-5 mb-3">
        <h2>Service</h2>
    </div>
    <div class="d-flex flex-column align-items-center justify-content-around" >
    
    <%
    	int id= Integer.parseInt(request.getParameter("id"));
	    String name = request.getParameter("name");
	    String description = request.getParameter("description");
	    int category_id= Integer.parseInt(request.getParameter("category_id"));
	    String price = request.getParameter("price");
	    String img_path = request.getParameter("img_path");
	    String category_name = "";
	    
	    ArrayList<String> categories = (ArrayList<String>) session.getAttribute("categories");
	    if (categories != null) {
	    	for (String category : categories) {
	    		if (category.)
	    	}
	    }
    %>
		<form method="post" class="row g-3 col-8 p-3 my-3 border border-secondary-subtle rounded-5" action="editService.jsp" name="service">
            <div class="col-md-12">
            	<input type="hidden" name="service_id" value="<%= id %>">
                <label for="serviceName" class="form-label">Service Name</label>
                <input type="text" class="form-control" id="serviceName" name="serviceName" value="<%=name %>" required>
              </div>
              <div class="col-md-6">
                  <label for="category" class="form-label">Category</label>
                  <select class="form-select" id="category" name="category" required>
                    <option selected disabled value="<%=category_id %> <%=%>">Select Category</option>
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
                    <input type="text" class="form-control" id="servicePrice" value="<%=price %>" name="servicePrice" required>
                </div>
              <div class="col-md-12">
                <label for="serviceDescription" class="form-label">Service Description</label>
                <textarea class="form-control" id="serviceDescription" value="<%=description %>" name="serviceDescription" rows="3" required></textarea>
            </div>
            <div class="col-12">
                <button class="btn btn-primary" type="submit">Update</button>
            </div>
        </form>
        <div class="m-3"><a class="btn btn-primary" href="manageService.jsp">Cancel</a></div>
	</div>
</body>
</html>
