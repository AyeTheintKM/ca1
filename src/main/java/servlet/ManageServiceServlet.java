package servlet;

import java.io.IOException;
import java.sql.*;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ManageServiceServlet")
public class ManageServiceServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String email = request.getParameter("email");
      String password = request.getParameter("password");
      HttpSession session = request.getSession();
      RequestDispatcher dispatcher = null;

	  Connection conn = null;
	  PreparedStatement ps = null;
      ResultSet rs = null;
      
      try {
          conn = DBConnection.getConnection();
          ps = conn.prepareStatement("SELECT c.category_id, c.name as category_name, "
          		+ "c.description as category_description, "
          		+ "s.name as service_name, "
          		+ "s.description as service_description, "
          		+ "s.category_id as service_category_id, "
          		+ "s.price, s.image_path FROM service_category c JOIN services s ON c.category_id = s.category_id;");

          rs = ps.executeQuery();
          ResultSetMetaData rsMeta = rs.getMetaData();
          int columnCount = rsMeta.getColumnCount();

          while (rs.next()) {
              for (int i = 1; i <= columnCount; i++) { // Columns are 1-indexed
                  String columnName = rsMeta.getColumnName(i); // Get column name
                  String columnValue = rs.getString(i); // Get column value as String
                  System.out.println(columnName + ": " + columnValue);
              }
              System.out.println("----------------------------");
          }

          rs.close();
		
		  } catch (Exception e) {
		      e.printStackTrace();
		      response.sendRedirect("user/login.jsp?error=exception");
		  }
  }
}