<%
	String role = (String)session.getAttribute("role");
    if (session == null || role == null || !role.equals("Admin")) {
        response.sendRedirect("../user/login.jsp?errCode=invalid");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Feedback</title>
</head>
<body>
	<%@include file="../navbar/adminNavbar.jsp" %>
    <div class="mt-5" id="">
        <h2>Manage Feedback</h2>
    </div>
</body>
</html>
