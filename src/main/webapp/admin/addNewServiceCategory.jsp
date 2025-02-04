<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
	String role = (String)session.getAttribute("role");
	if (session == null || role == null || !role.equals("Admin")) {
	    response.sendRedirect("../user/login.jsp?error=invalid");
	}

    String name = request.getParameter("categoryName");
    String description = request.getParameter("categoryDescription");
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
    	conn = DBConnection.getConnection();
        String sql = "INSERT INTO service_category (name, description) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, description);
        pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
        response.sendRedirect("manageServiceCategory.jsp");
    }
%>
