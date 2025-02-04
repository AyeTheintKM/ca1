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
<title>Edit Service</title>
</head>
<body>
	<%
		int id= Integer.parseInt(request.getParameter("id"));
		int category_id= Integer.parseInt(request.getParameter("category_id"));
	    String name = request.getParameter("name");
	    String description = request.getParameter("description");
	    double price = Double.parseDouble(request.getParameter("price"));
	    String img_path = request.getParameter("img_path");
    
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement("UPDATE services SET name=?, description=?, category_id=?, price=?, img_path=? where service_id=?");
	   	
	        ps.setString(1, name);
	        ps.setString(2, description);
	        ps.setInt(3, category_id);
	        ps.setDouble(4, price);
	        ps.setString(5, img_path);
	        ps.executeUpdate();
            
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (ps != null) ps.close();
	        if (conn != null) conn.close();
	        response.sendRedirect("manageServices.jsp");
	    }
    %>
</body>
</html>