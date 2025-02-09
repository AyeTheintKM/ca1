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

@WebServlet("/DeleteFeedbackServlet")
public class DeleteFeedbackServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
    private static final String DB_USER = "neondb_owner";
    private static final String DB_PASS = "PCbckaliN31T";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("user/login.jsp?error=Please log in to manage feedback");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String deleteQuery = "DELETE FROM feedback WHERE feedback_id = ? AND user_id = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, feedbackId);
            stmt.setInt(2, userId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("user/feedback.jsp?success=Feedback deleted successfully!");
            } else {
                response.sendRedirect("user/feedback.jsp?error=Unauthorized action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/feedback.jsp?error=An error occurred.");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
