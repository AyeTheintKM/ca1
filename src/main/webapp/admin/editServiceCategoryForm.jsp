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
    <title>Edit Service Category form</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body class="m-3 p-2">
    <%@include file="../navbar/adminNavbar.jsp" %>
    <div class="mt-5 mb-3">
        <h2>Service Category</h2>
    </div>
    <div class="d-flex flex-column align-items-center justify-content-around" >
    
    <%
    	int id= Integer.parseInt(request.getParameter("id"));
	    String name = request.getParameter("name");
	    String description = request.getParameter("description");
    %>
		<form method="post" class="row g-3 col-5 p-3 my-3 border border-secondary-subtle rounded-5" action="editServiceCategory.jsp" name="serviceCategory">
            <div class="col-md-12">
            	<input type="hidden" name="id" value="<%= id %>">
                <label for="categoryName" class="form-label">Name</label>
                <input type="text" class="form-control" id="categoryName" name="categoryName" value="<%=name %>" required>
              </div>
              <div class="col-md-12">
                <label for="categoryDescription" class="form-label">Category Description</label>
                <textarea class="form-control" id="categoryDescription" name="categoryDescription" rows="3" required><%=description %></textarea>
            </div>
            <div class="col-12">
                <button class="btn btn-primary" type="submit">Update</button>
            </div>
        </form>
        <div class="m-3"><a class="btn btn-primary" href="manageServiceCategory.jsp">Cancel</a></div>
	</div>
</body>
</html>
