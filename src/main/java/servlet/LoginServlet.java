package servlet;

import java.io.IOException;
import java.sql.*;


//import dao.DBConnection;
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
			Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);
			PreparedStatement pst = conn.prepareStatement("SELECT * FROM customers WHERE email = ? AND password = ?");
			pst.setString(1,  email);
			pst.setString(2,  password);
			
			ResultSet rs = pst.executeQuery();
			if(rs.next()) {
				session.setAttribute("user", rs.getString("name"));
				response.sendRedirect("customer/profile.jsp");
				
			} else {
				response.sendRedirect("login.jsp?error=invalid");
			}
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
