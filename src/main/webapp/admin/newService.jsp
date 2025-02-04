<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
	String role = (String)session.getAttribute("role");
	if (session == null || role == null || !role.equals("Admin")) {
	    response.sendRedirect("../user/login.jsp?error=invalid");
	}

    String serviceName = request.getParameter("serviceName");
    String category = request.getParameter("category");
    String serviceDescription = request.getParameter("serviceDescription");
    double price = Double.parseDouble(request.getParameter("servicePrice"));
    
    int category_id = Integer.parseInt(category.split(" ")[0]);
    
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
    	conn = DBConnection.getConnection();
        String sql = "INSERT INTO services (name, description, category_id, price, image_path) VALUES (?,?,?,?,?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, serviceName);
        pstmt.setString(2, serviceDescription);
        pstmt.setInt(3, category_id);
        pstmt.setDouble(4, price);
        pstmt.setString(5, "home.jpg");
        pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
        response.sendRedirect("manageServices.jsp");
    }
%>
