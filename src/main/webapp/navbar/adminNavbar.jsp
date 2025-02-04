<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
	String strRole = (String)session.getAttribute("role");
	if (session == null || strRole == null || !strRole.equals("Admin")) {
		response.sendRedirect("../user/login.jsp?errCode=invalid");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Navbar</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="../css/style.css" rel="stylesheet">
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
                        <!-- <li class="nav-item"><a class="nav-link mx-lg-2" href="../admin/dashboard.jsp">Dashboard</a></li> -->
                        <li class="nav-item"><a class="nav-link mx-lg-2" href="../admin/manageServiceCategory.jsp">Service Category</a></li>
                        <li class="nav-item"><a class="nav-link mx-lg-2" href="../admin/manageServices.jsp">Service</a></li>
                        <li class="nav-item"><a class="nav-link mx-lg-2" href="../admin/manageUser.jsp">User</a></li>
                        <li class="nav-item"><a class="nav-link mx-lg-2" href="../admin/manageFeedback.jsp">Feedback</a></li>
                    </ul>

                    <div class="d-flex">
						<a href="../user/profile.jsp" class="btn btn-danger mx-2"><%=session.getAttribute("user") %></a>
                       	<a href="../logout" onclick="clickBtnLogout()" class="btn btn-danger">Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <script>
        document.addEventListener("scroll", function () {
            const navbar = document.querySelector(".transparent-navbar");
            if (window.scrollY > 50) {
                navbar.classList.add("scrolled");
            } else {
                navbar.classList.remove("scrolled");
            }
        });
        
        document.addEventListener("DOMContentLoaded", () => {
        	clickBtnLogout = () => {
        		alert("clicked logout");
        		sessionStorage.removeItem("role_id");
        		sessionStorage.removeItem("userId");
        		sessionStorage.removeItem("user");
        		sessionStorage.removeItem("useremail");
        	}
        })
    </script>
</body>
</html>