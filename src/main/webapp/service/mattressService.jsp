<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mattress Cleaning Service</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
<link href="./css/service-style.css" rel="stylesheet">
</head>
<body>
	<%@include file="../navbar/navbar.jsp" %>
	<div class="d-flex flex-column mt-5 align-items-center">
		<div class="d-flex flex-row align-items-center justify-content-around mt-5 pt-5">
			<img class="col-7 rounded-4" style="width: 30rem; height: auto;" alt="Mattress Cleaning" src="../images/mattress-home-page.jpg">
			<div class="d-flex flex-column col-5 align-items-center">
  				<p class="fs-5 my-5">Transform your sleep environment with our expert mattress cleaning services. We remove dust mites, allergens, stains, and odors, ensuring a hygienic surface for restful nights. Regular cleaning improves sleep quality and extends the life of your mattress. Trust us to keep your mattress fresh and healthier for you and your family.</p>
				<a role="button" class="btn login-button" href="#detail-services">Available Services</a>
			</div>
		</div>
		<div class="d-flex flex-column align-items-center mt-5 w-100" id="detail-services" style="height: 70vh;">
			<h3 class="mt-5">Available Services</h3>
			<div class="d-flex flex-column w-100 justify-content-center">
				<div class="d-flex flex-column flex-wrap w-100 my-3 align-items-center">
					<div class="d-flex flex-row flex-wrap w-100 my-3 align-items-center justify-content-around">
					<%
						Connection conn = null;
						PreparedStatement ps = null;
			            ResultSet rs = null;
			            
			            try {
			                conn = DBConnection.getConnection();
			                ps = conn.prepareStatement("SELECT * FROM services where category_id=?");
			                ps.setInt(1, Integer.parseInt(request.getParameter("category_id")));
			                rs = ps.executeQuery();

			                while (rs.next()) {
			        %>
			        	<div class="card border-primary-subtle my-4 mx-2" style="width: 18rem; height:fit-content; background-color:#c6e4ff;">
			        		<p class="text-center card-header fs-5 text-secondary my-2"><%=rs.getString("name") %></p>
						  	<div class="card-body text-secondary d-flex flex-column align-items-center justify-content-center">
						  		<p>Price: $<%=rs.getDouble("price") %></p>
						  		<a role="button" class="btn btn-secondary m-auto" href="booking.jsp?serviceId=<%=rs.getInt("service_id")%>">Book</a>
						  	</div>
						</div>
			        <%
			                }
			            } catch (Exception e) {
			                out.println("<p>Error: " + e.getMessage() + "</p>");
			            } 
					%>
					</div>
					<div class="container w-75 mt-5 border border-secondary-subtle rounded-5 p-5">
						<div class="row d-flex flex-row justify-content-around">
							<div class="col-6">
								<p class="fs-3">Why Choose Us?</p>
								<ul>
								  <li><strong>Professional Service:</strong> Our skilled technicians use advanced cleaning methods for deep sanitization.</li>
								  <li><strong>Allergen & Dust Removal:</strong> We effectively eliminate dust mites, allergens, and bacteria for a healthier sleep environment.</li>
								  <li><strong>Eco-Friendly Products:</strong> We use safe, non-toxic cleaning solutions that are gentle on your mattress and the environment.</li>
								  <li><strong>Stain & Odor Removal:</strong> We target tough stains and eliminate odors, leaving your mattress fresh and clean.</li>
								  <li><strong>Extended Mattress Life:</strong> Regular cleaning improves the longevity and comfort of your mattress.</li>
								</ul>
							</div>
							<div class="col-6 d-flex justify-content-center align-items-center">
								<img class="rounded-4" style="width: 26rem; height: auto;" alt="Professional Cleaning Team" src="../images/why-choose-us-office.jpg">
							</div>
						</div>
					</div>
					<div class="container w-75 mt-5 border border-secondary-subtle rounded-5 p-5">
						<div class="row">
							<div class="col-7">
								<h2>Get a Better Night's Sleep Today!</h2>
								<p>Ready to refresh your mattress and enjoy a cleaner, healthier sleep environment? Contact us for a free consultation or book your mattress cleaning session online.</p>
								<p>Let us handle the cleaning while you rest easy and wake up refreshed!</p>
							</div>
						
							<div class="col-5 d-flex flex-column align-items-center justify-content-center text-decoration-none">
							  <p><strong>Call Us:</strong> <a href="tel:+6512345678">+65 1234 5678</a></p>
							  <p><strong>Email:</strong> <a href="mailto:info@cleanpro.sg">info@cleanpro.sg</a></p>
							  <p><strong>Book Online:</strong> <a href="#detail-services">Click Here</a></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
	<script src="../js/services.js"></script>
	
</body>
</html>