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
	     String postalCode = request.getParameter("postal_code");
	     String unit = request.getParameter("unit");
	     String floor = request.getParameter("floor");
	     String block = request.getParameter("block");
	     String street = request.getParameter("street");
		RequestDispatcher dispatcher = null;
		Connection conn = null;
		
		//PrintWriter out = response.getWriter();
		//out.print(uname);
		//out.print(uemail);
		//out.print(upwd);
		//out.print(umobile);
		
		try {
			String USERNAME = "neondb_owner";
			 String PASSWORD = "PCbckaliN31T";
			Class.forName("org.postgresql.Driver");
           String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
           conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);
			PreparedStatement pst = conn.prepareStatement("INSERT INTO users (name, email, password, phone, postal_code, unit, floor, block, street) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, phone);
            pst.setString(5, postalCode);
            pst.setString(6, unit);
            pst.setString(7, floor);
            pst.setString(8, block);
            pst.setString(9, street);

            int rowCount = pst.executeUpdate();

            if (rowCount > 0) {
                // Redirect to login page on success
                response.sendRedirect("user/login.jsp");
            } else {
                // Redirect to register page with failure message
                response.sendRedirect("user/register.jsp?error=failure");
            }

            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/register.jsp?error=exception");
        }
    }
}


