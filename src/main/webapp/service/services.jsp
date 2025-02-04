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
	<%@include file="../navbar/navbar.jsp" %>
	<div class="d-flex flex-column mt-5 align-items-center">
	<!-- list group start -->
	<div class="row m-2 mt-4">
	  <div class="col-3 position-fixed">
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
            	String description = rs.getString("description");
            	int id = rs.getInt("category_id");
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
	    <nav id="services" class="h-100 flex-column align-items-stretch pe-4 border-end">
	      <nav class="nav nav-pills flex-column">
	        <a class="nav-link" href="#item-1">Introduction</a>
	        <a class="nav-link" href="#item-2">Home Service</a>
	        <nav class="nav nav-pills flex-column">
	          <a class="nav-link ms-3 my-1" href="#item-2-1">Whole House Cleaning</a>
	          <a class="nav-link ms-3 my-1" href="#item-2-2">Bedroom Cleaning</a>
	          <a class="nav-link ms-3 my-1" href="#item-2-3">Kitchen Cleaning</a>
	          <a class="nav-link ms-3 my-1" href="#item-2-4">Living Room/Common Area Cleaning</a>
	        </nav>
	        <a class="nav-link" href="#item-3">Deep Service</a>
	        <nav class="nav nav-pills flex-column">
	          <a class="nav-link ms-3 my-1" href="#item-3-1">1 Bedroom</a>
	          <a class="nav-link ms-3 my-1" href="#item-3-2">Item 3-2</a>
	        </nav>
	      </nav>
	    </nav>
	  </div>

	 <div class="col-9" style="margin-left: 30vw;">
	    <div data-bs-spy="scroll" data-bs-target="#services" data-bs-smooth-scroll="true" class="scrollspy-example-2" tabindex="0">
	      <div id="item-1">
	        <h4>Introduction</h4>
	        <div class="d-flex flex-column align-items-center my-3">
	        	<img alt="Office Cleaning" src="../images/services-home-page.png" class="w-75">
	        	<p>We take pride in providing top-notch cleaning and air conditioning services tailored to your needs. Our professional team is committed to delivering exceptional results, ensuring a clean, fresh, and comfortable environment for your home or business. Whether you need deep cleaning, regular maintenance, or aircon servicing, we use industry-leading techniques and eco-friendly products to guarantee satisfaction. With our reliable and skilled specialists, you can expect quality service, punctuality, and a hassle-free experience. Let us help you maintain a spotless and efficient space—because your comfort and hygiene matter to us!</p>
	        </div>
	      </div>
	      <div id="item-2">
	        <h4>Item 2</h4>
	        <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It's repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.
	
	Keep in mind that the JavaScript plugin tries to pick the right element among all that may be visible. Multiple visible scrollspy targets at the same time may cause some issues.</p>
	      </div>
	      <div id="item-3">
	        <h4>Item 3</h4>
	        <p>...</p>
	      </div>
	      <div id="item-3-1">
	        <h5>Item 3-1</h5>
	        <p>...</p>
	      </div>
	      <div id="item-3-2">
	        <h5>Item 3-2</h5>
	        <p>...</p>
	      </div>
	    </div>
	  </div>
	</div>
	
	
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