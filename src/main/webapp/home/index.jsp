<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ include file="includes/header.jsp" %> --%>

<!DOCTYPE html>
<html>
<head>
<title>Cleaning Service</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
<style>
/* About Section */
        .about {
            padding: 60px 20px;
            text-align: center;
        }
        .about h2 {
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: 600;
            color: #333;
        }
        .about p {
            font-size: 18px;
            line-height: 1.8;
            color: #555;
        }

        /* Services Section */
        .services {
            padding: 60px 20px;
            text-align: center;
        }
        .services h2 {
            font-size: 36px;
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
        }
        .services .service-card {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
            background: white;
            transition: transform 0.3s ease;
        }
        .services .service-card:hover {
            transform: scale(1.05);
        }
        .services img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .services .card-body {
            padding: 20px;
        }

        /* Contact Section */
        .contact {
            background-color: #444444;
            color: white;
            padding: 60px 20px;
            text-align: center;
        }
        .contact h2 {
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .contact p {
            margin-bottom: 30px;
            font-size: 16px;
        }
        .contact form input,
        .contact form textarea {
            width: 100%;
            padding: 15px;
            margin-bottom: 15px;
            border: none;
            border-radius: 5px;
        }
        .contact form button {
            background-color: #ff8c00;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }
        .contact form button:hover {
            background-color: #e67c00;
        }

        /* Footer */
        .footer {
            background-color: #333333;
            color: white;
            padding: 30px 20px;
            text-align: center;
        }
        .footer p {
            margin: 0;
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 36px;
            }
            .hero p {
                font-size: 16px;
            }</style>
</head>
<body>
	<%@include file="../navbar/navbar.jsp" %>
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
	<img src="../images/home-img.png" alt="img"></div>
	</div>
	</div>
	</section>
	  <section id="about" class="about">
        <div class="container">
            <h2>About Us</h2>
            <p>At Spotless Living, we believe in creating clean and healthy environments for homes and businesses. With years of experience and a team of dedicated professionals, we deliver unmatched cleaning services tailored to your needs. Trust us to make your space spotless!</p>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="services">
        <div class="container">
            <h2>Our Services</h2>
            <div class="row g-4">
                <!-- Service 1 -->
                <div class="col-md-4">
                    <div class="service-card">
                        <img src="https://via.placeholder.com/400x300" alt="Residential Cleaning">
                        <div class="card-body">
                            <h5>Residential Cleaning</h5>
                            <p>We keep your home spotless with thorough and customized cleaning solutions.</p>
                        </div>
                    </div>
                </div>
                <!-- Service 2 -->
                <div class="col-md-4">
                    <div class="service-card">
                        <img src="https://via.placeholder.com/400x300" alt="Office Cleaning">
                        <div class="card-body">
                            <h5>Office Cleaning</h5>
                            <p>Ensure a clean and professional work environment for your employees and clients.</p>
                        </div>
                    </div>
                </div>
                <!-- Service 3 -->
                <div class="col-md-4">
                    <div class="service-card">
                        <img src="https://via.placeholder.com/400x300" alt="Move-in/Move-out Cleaning">
                        <div class="card-body">
                            <h5>Move-in/Move-out Cleaning</h5>
                            <p>Stress-free cleaning for your moving experience, ensuring a fresh start.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact">
        <div class="container">
            <h2>Contact Us</h2>
            <p>Have a question or need to book our services? Fill out the form below, and we’ll get back to you shortly!</p>
            <form action="ContactServlet" method="post">
                <input type="text" name="name" placeholder="Your Name" required>
                <input type="email" name="email" placeholder="Your Email" required>
                <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
                <button type="submit">Submit</button>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; <%= new java.util.Date().getYear() + 1900 %> Spotless Living. All Rights Reserved.</p>
        </div>
    </footer>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

</body>
</html>
