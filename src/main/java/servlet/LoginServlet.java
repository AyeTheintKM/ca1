//package servlet;
//
//import java.io.IOException;
//import java.sql.*;
//
//
////import dao.DBConnection;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/LoginServlet")
//public class LoginServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//    
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String email = request.getParameter("email");
//		String password = request.getParameter("password");
//		HttpSession session = request.getSession();
//		RequestDispatcher dispatcher = null;
//		try {
//			String USERNAME = "neondb_owner";
//			 String PASSWORD = "PCbckaliN31T";
//			Class.forName("org.postgresql.Driver");
//           String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
//           Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);
//			PreparedStatement pst = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
//			pst.setString(1,  email);
//			pst.setString(2,  password);
//			
//			ResultSet rs = pst.executeQuery();
//			if(rs.next()) {
//				session.setAttribute("userId", rs.getInt("user_id"));
//				session.setAttribute("user", rs.getString("name"));
//				session.setAttribute("useremail", rs.getString("email"));
//				response.sendRedirect("user/profile.jsp");
//				
//			} else {
//				response.sendRedirect("user/login.jsp?error=invalid");
//			}
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}

package servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;

        try {
            String USERNAME = "neondb_owner";
            String PASSWORD = "PCbckaliN31T";
            Class.forName("org.postgresql.Driver");
            String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
            Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

            // Query to check login credentials and get user details
            String sql = "SELECT u.user_id, u.name, u.email, u.role_id, r.name AS role_name " +
                         "FROM users u " +
                         "JOIN role r ON u.role_id = r.role_id " +
                         "WHERE u.email = ? AND u.password = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                int roleId = rs.getInt("role_id");
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("user", rs.getString("name"));
                session.setAttribute("useremail", rs.getString("email"));
                session.setAttribute("role", rs.getString("role_name"));

                // Redirect based on the user's role
                if (roleId == 1) {
                    // Admin role
                    response.sendRedirect("user/dashboard.jsp");
                } else if (roleId == 2) {
                    // Customer role
                    response.sendRedirect("user/profile.jsp");
                } else {
                    // Role not recognized
                    response.sendRedirect("user/login.jsp?error=role_invalid");
                }
            } else {
                // Invalid credentials
                response.sendRedirect("user/login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/login.jsp?error=exception");
        }
    }
}

