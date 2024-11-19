<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ include file="includes/header.jsp" %> --%>

<!DOCTYPE html>
<html>
<head>
<title>Cleaning Service</title>
<link rel="stylesheet" type="text/css" href="styles/style.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar navbar-expand-lg fixed-top">
		<div class="container">
			<a class="navbar-brand me-auto" href="#">Logo</a>
			<div class="offcanvas offcanvas-end" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel">Logo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
						aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<ul class="navbar-nav justify-content-center flex-grow-1 pe-3">
						<li class="nav-item"><a class="nav-link mx-lg-2 active"
							aria-current="page" href="#">Home</a></li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">About</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">Services</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">Portfolio</a>
						</li>
						<li class="nav-item"><a class="nav-link mx-lg-2" href="#">Contact</a>
						</li>

					</ul>

				</div>
			</div>
			<a href="customer/login.jsp" class="login-button">Login</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<a href="customer/register.jsp" class="login-button">Register</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</nav>
	<section class="home" id="home">
	<div class="container">
	<div class="grid">
	<div class="home-text">
	<h1>need cleaning services?</h1>
	<p></p>
	<div class="btn-wrap">
	<a href="#about" class="btn">Know more</a>
	</div>
	</div>
	<div class="home-img">
	<div class="circle-wrap">
	<div class="circle">
	</div>
	</div>
	<img src="images/home-img.png" alt="img"></div>
	</div>
	</div>
	</section>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
