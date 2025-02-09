/*
package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/AddtoCartServlet")
public class AddtoCartServlet extends HttpServlet {
	@SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve cart from session or initialize a new one
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Retrieve booking details from the form
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        String serviceName = request.getParameter("service");
        String bookingDate = request.getParameter("booking_date");
        String bookingTime = request.getParameter("booking_time");
        String instructions = request.getParameter("instructions");
        double price = Double.parseDouble(request.getParameter("price").replace("$", ""));

        // Add booking details to the cart
        Map<String, Object> booking = new HashMap<>();
        booking.put("serviceId", serviceId);
        booking.put("serviceName", serviceName);
        booking.put("price", price);
        booking.put("bookingDate", bookingDate);
        booking.put("bookingTime", bookingTime);
        booking.put("instructions", instructions);
        cart.add(booking);

        // Save updated cart to session
        session.setAttribute("cart", cart);

        // Redirect to the cart page
        response.sendRedirect("user/cart.jsp");
    }
}
*/
package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/AddtoCartServlet")
public class AddtoCartServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve cart from session or initialize a new one
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Retrieve booking details from the form
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        String serviceName = request.getParameter("service");
        String bookingDate = request.getParameter("booking_date");
        String bookingTime = request.getParameter("booking_time");
        String instructions = request.getParameter("instructions");
        double price = Double.parseDouble(request.getParameter("price").replace("$", ""));
        String status = "Pending";  // Default status, you may want to update this based on actual logic

        // Add booking details to the cart
        Map<String, Object> booking = new HashMap<>();
        booking.put("serviceId", serviceId);
        booking.put("serviceName", serviceName);
        booking.put("price", price);
        booking.put("bookingDate", bookingDate);
        booking.put("bookingTime", bookingTime);
        booking.put("instructions", instructions);
        booking.put("status", status);  // Add status to the booking
        cart.add(booking);

        // Save updated cart to session
        session.setAttribute("cart", cart);

        // Redirect to the cart page
        response.sendRedirect("user/cart.jsp");
    }
}
