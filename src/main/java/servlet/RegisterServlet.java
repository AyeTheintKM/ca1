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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//PrintWriter out = response.getWriter();
		//out.print("Working");
		 String name = request.getParameter("name");
	     String email = request.getParameter("email");
	     String password = request.getParameter("password");
	     String phone = request.getParameter("phone");
		RequestDispatcher dispatcher = null;
		Connection conn = null;
		
		//PrintWriter out = response.getWriter();
		//out.print(uname);
		//out.print(uemail);
		//out.print(upwd);
		//out.print(umobile);
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/cleaning-services?user=root&password=root&serverTimezone=UTC";
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pst = conn.prepareStatement("INSERT INTO customers (name, email, password, phone) VALUES (?, ?, ?, ?)");
			pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, phone);
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("register.jsp");
			if(rowCount > 0) {
				response.sendRedirect("customer/login.jsp");
            } else {
                response.sendRedirect("register.jsp?error=failure");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


