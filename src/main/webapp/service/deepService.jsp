<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deep Cleaning Service</title>
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
			<img class="col-7 rounded-4" style="width: 30rem; height: auto;" alt="Deep Cleaning" src="../images/office-cleaning-home-page.jpg">
			<div class="d-flex flex-column col-5 align-items-center">
				<p class="fs-5 my-5">Experience the ultimate cleanliness with our deep cleaning service tailored for the apartments. We thoroughly clean bedrooms, living spaces, kitchens, and bathrooms, focusing on every detail, including scrubbing grout, disinfecting high-touch areas, and removing built-up dirt. Let us rejuvenate your home for a healthier, more comfortable space.</p>
				<a role="button" class="btn login-button" href="#detail-services">Available Services</a>
			</div>
		</div>
		<div class="d-flex flex-column align-items-center mt-5 w-100" id="detail-services" style="height: 70vh;">
			<h3 class="mt-5">Available Services</h3>
			<div class="d-flex flex-column w-100 justify-content-center">
				<div class="d-flex flex-column flex-wrap w-100 my-3 align-items-center">
					<div class="accordion mx-5 row w-75 my-0 justify-content-center" id="deepServiceAccordion">
					<%
						Connection conn = null;
						PreparedStatement ps = null;
			            ResultSet rs = null;
			            
			            try {
			                conn = DBConnection.getConnection();
			                ps = conn.prepareStatement("SELECT * FROM services where category_id=?");
			                ps.setInt(1, Integer.parseInt(request.getParameter("category_id")));
			                rs = ps.executeQuery();

			                int count = 1;
			                while (rs.next()) {
			        %>
			        	<div class="accordion-item col-10 p-0">
							<h2 class="accordion-header" style="background-color:#c6e4ff;">
							  <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-<%=count %>" aria-expanded="true" aria-controls="collapse-<%=count %>" style="background-color: #c6e4ff;">
							    <p class="fs-5 mb-0"><%=rs.getString("name") %></p>
							  </button>
							</h2>
							<div id="collapse-<%=count %>" class="accordion-collapse collapse p-4" data-bs-parent="#deepServiceAccordion">
							  <div class="accordion-body d-flex flex-row align-items-center justify-content-around">
							  	<img class="col-5 rounded-4" style="width: 23rem; height: auto;" alt="<%=rs.getString("name") %>" src="../images/<%=rs.getString("image_path") %>">
							  	<div class="col-5">
							     <p><%=rs.getString("description") %></p>
							     <p>Price: $<%=rs.getDouble("price") %></p>
							     <a role="button" class="btn btn-secondary m-auto w-25" href="booking.jsp?serviceId=<%=rs.getInt("service_id")%>">Book</a>
							      </div>
							    </div>
							  </div>
							</div>
			        <%
			        			count++;
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
								    <li>
								      <strong>Professional Team:</strong> Trained cleaners equipped with the latest tools and techniques.
								    </li>
								    <li>
								      <strong>Eco-Friendly Products:</strong> Safe for people and the environment.
								    </li>
								    <li>
								      <strong>Flexible Scheduling:</strong> Evening, weekend, or after-hours cleaning to minimize disruption.
								    </li>
								    <li>
									  <strong>Attention to Detail:</strong> We focus on every corner of your home, ensuring no spot is overlooked for a thorough clean.
									</li>
								</ul>
							</div>
							<div class="col-6">
								<img class="rounded-4" style="width: 26rem; height: auto;" alt="Professional Cleaning Team" src="../images/why-choose-us-office.jpg">
							</div>
						</div>
					</div>
					<div class="container w-75 mt-5 border border-secondary-subtle rounded-5 p-5">
						<div class="row">
							<div class="col-6">
								<h2>Get Started Today!</h2>
								<p>Ready to create a cleaner, healthier workspace? Contact us for a free consultation or book your first cleaning session online.</p>
								<p>Let us take care of the mess while you focus on growing your business!</p>
							</div>
						
							<div class="col-6 d-flex flex-column align-items-center justify-content-center text-decoration-none">
							  <p><strong>Call Us:</strong> <a href="tel:+6512345678">+65 1234 5678</a></p>
							  <p><strong>Email:</strong> <a href="mailto:info@cleanpro.sg">info@cleanpro.sg</a></p>
							  <p><strong>Book Online:</strong> <a href="../customer/bookService.jsp?service_id=<%= rs.getInt("service_id") %>">Click Here</a></p>
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