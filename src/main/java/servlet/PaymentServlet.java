/*
package servlet;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("user/cart.jsp?error=Cart is empty");
            return;
        }

        // Retrieve the amount with GST from the form (sent from checkout.jsp)
        double totalAmountWithGST = Double.parseDouble(request.getParameter("amountWithGST"));

        // Set Stripe secret key
        Stripe.apiKey = "sk_test_51Qofw8Im9NPq3CmanmgK8o2hyDMM2zZYsimgcjNbpkprMo0r09NxFlkyYiifjx7Ub6h0KmIwobtCiK1ABKtiy1Mv00XUU6rMN9"; // Replace with actual key

        List<SessionCreateParams.LineItem> lineItems = new ArrayList<>();
        for (Map<String, Object> item : cart) {
            lineItems.add(
                SessionCreateParams.LineItem.builder()
                    .setQuantity(1L)
                    .setPriceData(
                        SessionCreateParams.LineItem.PriceData.builder()
                            .setCurrency("usd")
                            .setUnitAmount((long) ((double) item.get("price") * 100)) // Convert to cents
                            .setProductData(
                                SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                    .setName((String) item.get("serviceName"))
                                    .build()
                            )
                            .build()
                    )
                    .build()
            );
        }

        try {
            // Create Stripe Checkout session
            SessionCreateParams params = SessionCreateParams.builder()
            	.addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD)
                .setMode(SessionCreateParams.Mode.PAYMENT)
                .setSuccessUrl(request.getRequestURL().toString().replace("PaymentServlet", "user/success.jsp"))
                .setCancelUrl(request.getRequestURL().toString().replace("PaymentServlet", "user/cart.jsp"))
                .addAllLineItem(lineItems)
                .build();

            // Create the Stripe session
            Session stripeSession = Session.create(params);
            response.sendRedirect(stripeSession.getUrl());
        } catch (StripeException e) {
            e.printStackTrace();
            response.sendRedirect("user/cart.jsp?error=Payment failed. Please try again.");
        }
    }
}
*/


/*
package servlet;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("user/cart.jsp?error=Cart is empty");
            return;
        }

        // Retrieve the amount with GST from the form (sent from checkout.jsp)
        double totalAmountWithGST = Double.parseDouble(request.getParameter("amountWithGST"));

        // Filter only confirmed bookings
        List<Map<String, Object>> confirmedBookings = new ArrayList<>();
        for (Map<String, Object> item : cart) {
            if ("Confirmed".equals(item.get("status"))) {
                confirmedBookings.add(item);
            }
        }

        if (confirmedBookings.isEmpty()) {
            response.sendRedirect("user/cart.jsp?error=No confirmed bookings selected.");
            return;
        }

        // Set Stripe secret key
        Stripe.apiKey = "sk_test_51Qofw8Im9NPq3CmanmgK8o2hyDMM2zZYsimgcjNbpkprMo0r09NxFlkyYiifjx7Ub6h0KmIwobtCiK1ABKtiy1Mv00XUU6rMN9"; // Replace with actual key

        List<SessionCreateParams.LineItem> lineItems = new ArrayList<>();
        for (Map<String, Object> item : confirmedBookings) {
            lineItems.add(
                SessionCreateParams.LineItem.builder()
                    .setQuantity(1L)
                    .setPriceData(
                        SessionCreateParams.LineItem.PriceData.builder()
                            .setCurrency("usd")
                            .setUnitAmount((long) ((double) item.get("price") * 100)) // Convert to cents
                            .setProductData(
                                SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                    .setName((String) item.get("serviceName"))
                                    .build()
                            )
                            .build()
                    )
                    .build()
            );
        }

        try {
            // Create Stripe Checkout session
            SessionCreateParams params = SessionCreateParams.builder()
                .addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD)
                .setMode(SessionCreateParams.Mode.PAYMENT)
                .setSuccessUrl(request.getRequestURL().toString().replace("PaymentServlet", "user/success.jsp"))
                .setCancelUrl(request.getRequestURL().toString().replace("PaymentServlet", "user/cart.jsp"))
                .addAllLineItem(lineItems)
                .build();

            // Create the Stripe session
            Session stripeSession = Session.create(params);
            response.sendRedirect(stripeSession.getUrl());
        } catch (StripeException e) {
            e.printStackTrace();
            response.sendRedirect("user/cart.jsp?error=Payment failed. Please try again.");
        }
    }
}
*/
package servlet;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:postgresql://ep-muddy-shape-a1pi44zq.ap-southeast-1.aws.neon.tech/cleaning-service?sslmode=require";
    private static final String DB_USER = "neondb_owner";
    private static final String DB_PASS = "PCbckaliN31T";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("user/cart.jsp?error=Cart is empty");
            return;
        }

        String[] selectedBookings = request.getParameterValues("selectedBookings");
        /*if (selectedBookings == null || selectedBookings.length == 0) {
            response.sendRedirect("user/cart.jsp?error=No confirmed bookings selected.");
            return;
        }
        */

        double totalAmount = 0.0;
        List<Map<String, Object>> confirmedBookings = new ArrayList<>();

        for (String serviceName : selectedBookings) {
            for (Map<String, Object> booking : cart) {
                if (serviceName.equals(booking.get("serviceName")) && "Confirmed".equals(booking.get("status"))) {
                    confirmedBookings.add(booking);
                    totalAmount += (double) booking.get("price");
                }
            }
        }

        double gstRate = 0.10;
        double totalAmountWithGST = totalAmount * (1 + gstRate);

        Stripe.apiKey = "sk_test_51Qofw8Im9NPq3CmanmgK8o2hyDMM2zZYsimgcjNbpkprMo0r09NxFlkyYiifjx7Ub6h0KmIwobtCiK1ABKtiy1Mv00XUU6rMN9"; 

        List<SessionCreateParams.LineItem> lineItems = new ArrayList<>();
        for (Map<String, Object> item : confirmedBookings) {
            double priceWithGST = (double) item.get("price") * (1 + gstRate);

            lineItems.add(
                SessionCreateParams.LineItem.builder()
                    .setQuantity(1L)
                    .setPriceData(
                        SessionCreateParams.LineItem.PriceData.builder()
                            .setCurrency("usd")
                            .setUnitAmount((long) (priceWithGST * 100))
                            .setProductData(
                                SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                    .setName((String) item.get("serviceName"))
                                    .build()
                            )
                            .build()
                    )
                    .build()
            );
        }

        try {
            SessionCreateParams params = SessionCreateParams.builder()
                .addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD)
                .setMode(SessionCreateParams.Mode.PAYMENT)
                .setSuccessUrl(request.getRequestURL().toString().replace("PaymentServlet", "user/success.jsp"))
                .setCancelUrl(request.getRequestURL().toString().replace("PaymentServlet", "user/cart.jsp"))
                .addAllLineItem(lineItems)
                .build();

            Session stripeSession = Session.create(params);

            updateBookingStatus(selectedBookings);

            response.sendRedirect(stripeSession.getUrl());
        } catch (StripeException e) {
            e.printStackTrace();
            response.sendRedirect("user/cart.jsp?error=Payment failed. Please try again.");
        }
    }

    private void updateBookingStatus(String[] selectedBookings) {
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "UPDATE booking SET status = 'Completed' WHERE service_id IN (SELECT service_id FROM services WHERE name = ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            for (String serviceName : selectedBookings) {
                stmt.setString(1, serviceName);
                stmt.executeUpdate();
            }

            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

