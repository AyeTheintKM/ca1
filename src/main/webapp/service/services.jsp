<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cleaning Services</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/service-style.css" rel="stylesheet">
<style>
body {
}
</style>
</head>
<body>
	<%@include file="../navbar/navbar.html" %>
	<div class="d-flex flex-column mt-5 align-items-center">
		<div class="d-flex flex-row align-items-center my-3">
			<div class="d-flex flex-column col-5 align-items-center">
				<h2 class="text-center m-4">Cleaning made easy – professional, reliable, and tailored to your needs.</h2>
				<a role="button" class="btn login-button" href="services.jsp#detail-services">View Services</a>
			</div>
			<img class="col-7" alt="Office Cleaning" src="../images/services-home-page.png">
		</div>
		<div class="d-flex flex-column align-items-center mt-5 w-100" id="detail-services" style="height: 70vh;">
			<h3 class="mt-5 pt-5">Available Cleaning Services</h3>
			<div class="d-flex flex-column w-100 justify-content-center">
				<div class="d-flex flex-row flex-wrap w-100 my-3 align-items-start justify-content-around">
					<%
						Connection conn = null;
						PreparedStatement ps = null;
			            ResultSet rs = null;
			            
			            try {
			                conn = DBConnection.getConnection();
			                ps = conn.prepareStatement("SELECT * FROM service_category");
			                rs = ps.executeQuery();

			                while (rs.next()) {
			                	String name = rs.getString("name");
			                	String serviceLink = name.replace(" Cleaning", "").toLowerCase();
			        %>
			        	<div class="card border-primary-subtle my-4" style="max-width: 23rem; height:fit-content; background-color:#c6e4ff;">
			        		<p class="text-center text-secondary fs-6 my-2"><%=name %> Service</p>
							<img src="../images/<%=serviceLink %>.jpg" class="card-img-top align-self-center" style="width: 100%; height: 15rem;" alt="...">
						  	<div class="card-body text-secondary d-flex flex-column align-items-center justify-content-center">
						  		<p><%=rs.getString("description") %></p>
						  		<a role="button" class="btn btn-secondary m-auto w-25" href="<%=serviceLink%>Service.jsp?category_id=<%=rs.getInt("category_id")%>">View</a>
						  	</div>
						</div>
			        <%
			                }
			            } catch (Exception e) {
			                out.println("<p>Error: " + e.getMessage() + "</p>");
			            } 
					%>
				</div>
			</div>
		</div>
	</div>
	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
</body>
</html>