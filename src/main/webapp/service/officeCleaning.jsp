<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Office Cleaning Service</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
<link href="./css/service-style.css" rel="stylesheet">
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
				<h1>Office Cleaning</h1>
				<button type="button" class="btn login-button" href="#detail-services">Clean Now!</button>
			</div>
			<img class="col-7" alt="Office Cleaning" src="../images/office-cleaning-home-page.png">
		</div>
		<div class="detail-services d-flex flex-column align-items-center mt-5 w-100" style="height: 70vh;">
			<h3>Office Cleaning Services</h3>
			<div class="d-flex flex-column w-100 justify-content-center">
				<div class="d-flex flex-row w-100 my-3 align-items-center justify-content-around">
					<div class="card border-primary-subtle my-4" style="max-width: 25rem;">
						<div class="card-header">Header</div>
						<img src="../images-signup-image.jpg" class="card-img-top" alt="...">
					  	<div class="card-body text-primary">
					    	<h5 class="card-title">Primary card title</h5>
					    	<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  	</div>
					  	<div class="card-footer text-body-secondary">
					    	2 days ago
					  	</div>
					</div>
					
					<div class="card border-primary-subtle my-4" style="max-width: 25rem;">
						<div class="card-header">Header</div>
						<img src="../images-signup-image.jpg" class="card-img-top" alt="...">
					  	<div class="card-body text-primary">
					    	<h5 class="card-title">Primary card title</h5>
					    	<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  	</div>
					  	<div class="card-footer text-body-secondary">
					    	2 days ago
					  	</div>
					</div>
					
					<div class="card border-primary-subtle my-4" style="max-width: 25rem;">
						<div class="card-header">Header</div>
						<img src="../images-signup-image.jpg" class="card-img-top" alt="...">
					  	<div class="card-body text-primary">
					    	<h5 class="card-title">Primary card title</h5>
					    	<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  	</div>
					  	<div class="card-footer text-body-secondary">
					    	2 days ago
					  	</div>
					</div>
				</div>
				<div class="d-flex flex-row w-100 m-3 align-items-center justify-content-around">
					<div class="card border-primary-subtle my-4" style="max-width: 25rem;">
						<div class="card-header">Header</div>
						<img src="../images-signup-image.jpg" class="card-img-top" alt="...">
					  	<div class="card-body text-primary">
					    	<h5 class="card-title">Primary card title</h5>
					    	<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  	</div>
					  	<div class="card-footer text-body-secondary">
					    	2 days ago
					  	</div>
					</div>
					
					<div class="card border-primary-subtle my-4" style="max-width: 25rem;">
						<div class="card-header">Header</div>
						<img src="../images-signup-image.jpg" class="card-img-top" alt="...">
					  	<div class="card-body text-primary">
					    	<h5 class="card-title">Primary card title</h5>
					    	<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  	</div>
					  	<div class="card-footer text-body-secondary">
					    	2 days ago
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
</body>
</html>