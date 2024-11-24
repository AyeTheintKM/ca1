package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class DeleteProfileServlet
 */
@WebServlet("/DeleteProfileServlet")
public class DeleteProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try {
            // Database connection
        	String USERNAME = "neondb_owner";
			 String PASSWORD = "PCbckaliN31T";
			Class.forName("org.postgresql.Driver");
           String connURL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
           Connection conn = DriverManager.getConnection(connURL, USERNAME, PASSWORD);

            // SQL to delete the profile
            String sql = "DELETE FROM users WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            stmt.executeUpdate();
            stmt.close();
            conn.close();

            // Invalidate the session
            session.invalidate();

            response.sendRedirect("user/login.jsp?delete=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/profile.jsp?delete=fail");
        }
    }
}