<%-- <%@ include file="../includes/adminHeader.jsp" %> --%>
<%
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <h2>Admin Dashboard</h2>
    <a href="manageServices.jsp">Manage Services</a> | <a href="../LogoutServlet">Logout</a>
</body>
</html>
