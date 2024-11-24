<%
	String role = (String)session.getAttribute("role");
	if (session == null || role == null || !role.equals("Admin")) {
        response.sendRedirect("../user/login.jsp?error=invalid");
    }
%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Services</title>
</head>
<body>
    <%@include file="../navbar/adminNavbar.jsp" %>
    <div class="mt-5" id="">
        <h2>Services</h2>
    </div>
    <div class="d-flex flex-row align-items-start justify-content-around" >
        <form method="post" class="row g-3 border border-secondary-subtle rounded-5" action="../ManageServiceServlet" name="serviceCategory">
            <div class="col-md-12">
                <label for="categoryName" class="form-label">Category Name</label>
                <input type="text" class="form-control" id="categoryName" value="Mark" required>
              </div>
              <div class="col-md-12">
                <label for="categoryDescription" class="form-label">Category Description</label>
                <textarea class="form-control" id="categoryDescription" rows="3" required></textarea>
            </div>
            <div class="col-12">
                <button class="btn btn-primary" type="submit">Add</button>
            </div>
        </form>
        <form method="post" class="row g-3 border border-secondary-subtle rounded-5" action="../ManageServiceServlet" name="service">
            <div class="col-md-12">
                <label for="serviceName" class="form-label">Service Name</label>
                <input type="text" class="form-control" id="serviceName" value="Mark" required>
              </div>
              <div class="col-md-6">
                  <label for="category" class="form-label">Category</label>
                  <select class="form-select" id="category" required>
                    <option selected disabled value="">1</option>
                    <option>...</option>
                  </select>
                </div>
                <div class="col-md-4">
                    <label for="servicePrice" class="form-label">Price</label>
                    <input type="text" class="form-control" id="servicePrice" required>
                </div>
              <div class="col-md-12">
                <label for="serviceDescription" class="form-label">Service Description</label>
                <textarea class="form-control" id="serviceDescription" rows="3" required></textarea>
            </div>
            <div class="col-12">
                <button class="btn btn-primary" type="submit">Add</button>
            </div>
        </form>
    </div>
    
    <div>
    
    </div>
</body>
</html>

