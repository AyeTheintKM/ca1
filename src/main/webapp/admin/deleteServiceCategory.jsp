<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%
	String role = (String)session.getAttribute("role");
	if (session == null || role == null || !role.equals("Admin")) {
        response.sendRedirect("../user/login.jsp?error=invalid");
    }
	
    String id = request.getParameter("id");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
    	conn = DBConnection.getConnection();
        String sql = "DELETE FROM service_category WHERE category_id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
        response.sendRedirect("manageServiceCategory.jsp");
    }
%>
