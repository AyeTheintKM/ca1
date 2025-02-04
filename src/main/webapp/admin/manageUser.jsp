<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%
	String role = (String)session.getAttribute("role");
	if (session == null || role == null || !role.equals("Admin")) {
        response.sendRedirect("../user/login.jsp?error=invalid");
    }
	
	Connection conn = null;
	PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
</head>
<body class="m-3 p-2">
    <%@include file="../navbar/adminNavbar.jsp" %>
    <form method="post" class="d-flex flex-row mt-5 mb-3 justify-content-between">
        <h2>Users</h2>
    </form>
    
    <div class="my=3">
        <table class="table table-striped-columns">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Role ID</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Postal Code</th>
                    <th scope="col">Floor</th>
                    <th scope="col">Unit</th>
                    <th scope="col">Street</th>
                    <th scope="col">Block</th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <% 
                try {
                    conn = DBConnection.getConnection();
                    ps = conn.prepareStatement("SELECT * FROM users");
                    rs = ps.executeQuery();

                    while (rs.next()) {
                    	int id = rs.getInt("user_id");
                    	int role_id = rs.getInt("role_id");
                    	String name = rs.getString("name");
                    	String email = rs.getString("email");
                    	String phone = rs.getString("phone");
                    	String postal_code = rs.getString("postal_code");
                    	String floor = rs.getString("floor");
                    	String unit = rs.getString("unit");
                    	String street = rs.getString("street");
                    	String block = rs.getString("block");
                %>
                    <tr>
                        <th scope="row"><%= id %></th>
                        <td><%= role_id %></td>
                        <td><%= name %></td>
                        <td><%= email %></td>
                        <td><%= phone %></td>
                        <td><%= postal_code %></td>
                        <td><%= floor %></td>
                        <td><%= unit %></td>
                        <td><%= street %></td>
                        <td><%= block %></td>
                        <td class="button-group d-flex flex-row ">
                     <form action="deleteUser.jsp" method="post" class="m-1">
                         <input type="hidden" name="id" value="<%= id %>">
                         <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to ban this user?');">Ban</button>
                     </form>
                </td>
                    </tr>
                <% 
                        }
                        rs.close();
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='4'>Error fetching data: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
     </div>   
</body>
</html>

