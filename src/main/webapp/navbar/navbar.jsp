<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // Check if user is logged in
    String loggedInUser = (String) session.getAttribute("user");
// Fetch the cart from session
List<Map<String, Object>> cart1 = (List<Map<String, Object>>) session.getAttribute("cart");
int cartItemCount = (cart1 != null) ? cart1.size() : 0;
 %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dynamic Navbar</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="../css/style.css" rel="stylesheet">
    <style>
        /* Navbar transparent style and scrolling effect */
        /*
        .transparent-navbar.scrolled {
            background-color: #fff;
            transition: background-color 0.3s ease-in-out;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .transparent-navbar {
            background-color: transparent;
            transition: background-color 0.3s ease-in-out;
        }
        */
        
        /* Dropdown menu style */
        /* .dropdown-menu.services {
            background-color: #dfeafe; 
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }
        .dropdown-menu.services a {
            color: #333;
            padding: 10px 15px;
        }
        .dropdown-menu.services a:hover {
            background-color: #bcd4f2; 
            color: #000;
        }
        */
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg fixed-top transparent-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Logo</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
                aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Logo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <ul class="navbar-nav justify-content-center flex-grow-1 pe-3">
                        <li class="nav-item"><a class="nav-link mx-lg-2 active" aria-current="page" href="../home/index.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link mx-lg-2" href="#">About</a></li>
                        <li class="nav-item"><a class="nav-link mx-lg-2" href="../service/services.jsp">Services</a></li>
                        <li class="nav-item"><a class="nav-link mx-lg-2" href="../submitFeedback.jsp">Feedback</a></li>
                        <li class="nav-item"><a class="nav-link mx-lg-2" href="#">Contact</a></li>
                    </ul>

                    <!-- User-specific buttons -->
                    <div class="d-flex">
                        <% if (loggedInUser == null) { %>
                            <!-- If not logged in -->
                            <a href="../user/login.jsp" class="btn btn-primary mx-2">Login</a>
                            <a href="../user/register.jsp" class="btn btn-secondary">Register</a>
                        <% } else { %>
                            <!-- If logged in -->
                            
                    	<a class="nav-link position-relative" href="cart.jsp">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            <%= cartItemCount %>
                        </span>
                    </a>
						<a href="../user/profile.jsp" class="btn btn-danger mx-2"><%=session.getAttribute("user") %></a>
                            <a href="../logout" class="btn btn-danger">Logout</a>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <script>
        // Change navbar background on scroll
        document.addEventListener("scroll", function () {
            const navbar = document.querySelector(".transparent-navbar");
            if (window.scrollY > 50) {
                navbar.classList.add("scrolled");
            } else {
                navbar.classList.remove("scrolled");
            }
        });
    </script>
</body>
</html>
