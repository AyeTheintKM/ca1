<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%
	String role = (String)session.getAttribute("role");
	if (session == null || role == null || !role.equals("Admin")) {
        response.sendRedirect("../user/login.jsp?error=invalid");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Service Category</title>
</head>
<body>
	<%
		int id= Integer.parseInt(request.getParameter("id"));
	    String name = request.getParameter("categoryName");
	    String description = request.getParameter("categoryDescription");
    
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement("UPDATE service_category SET name=?, description=? where category_id=?");
	   	
	        ps.setString(1, name);
	        ps.setString(2, description);
	        ps.setInt(3, id);
	        ps.executeUpdate();
            
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (ps != null) ps.close();
	        if (conn != null) conn.close();
	        response.sendRedirect("manageServiceCategory.jsp");
	    }
    %>
</body>
</html>