<%-- <%@ include file="../includes/header.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("user") %>!</h2>
    <p>Manage your bookings and view past services.</p>
    <a href="bookService.jsp">Book a New Service</a> | <a href="../LogoutServlet">Logout</a>
</body>
</html>
