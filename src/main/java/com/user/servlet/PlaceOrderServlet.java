package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.CartDAOImpl;
import com.DB.DBConnect;
import com.entity.User;

@WebServlet("/place_order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User loginUser = (User)session.getAttribute("userobj");

        if(loginUser == null) {
            session.setAttribute("failedMsg", "Please login before placing an order.");
            resp.sendRedirect("login.jsp");
            return;
        }

        String customerName = req.getParameter("customerName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String paymentMethod = req.getParameter("paymentMethod");
        String cardName = req.getParameter("cardName");
        String cardNumber = req.getParameter("cardNumber");
        String expiry = req.getParameter("expiry");
        String cvv = req.getParameter("cvv");

        customerName = safeTrim(customerName);
        phone = safeTrim(phone);
        address = safeTrim(address);
        city = safeTrim(city);
        paymentMethod = safeTrim(paymentMethod);
        cardName = safeTrim(cardName);
        cardNumber = safeTrim(cardNumber);
        expiry = safeTrim(expiry);
        cvv = safeTrim(cvv);

        CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
        double grandTotal = 0.0;

        try {
            grandTotal = Double.parseDouble(req.getParameter("grandTotal"));
        } catch (Exception e) {
            grandTotal = 0.0;
        }

        if(customerName.isEmpty() || phone.isEmpty() || address.isEmpty()
                || city.isEmpty() || paymentMethod.isEmpty()) {
            session.setAttribute("failedMsg", "Please complete all required checkout details.");
            resp.sendRedirect("checkout.jsp");
            return;
        }

        if(dao.getCartByUser(loginUser.getId()).isEmpty()) {
            session.setAttribute("failedMsg", "Your cart is empty.");
            resp.sendRedirect("cart.jsp?uid=" + loginUser.getId());
            return;
        }

        if("Card".equalsIgnoreCase(paymentMethod)) {
            if(cardName.isEmpty() || cardNumber.isEmpty()
                    || expiry.isEmpty() || cvv.isEmpty()) {
                session.setAttribute("failedMsg", "Please enter your card details.");
                resp.sendRedirect("checkout.jsp");
                return;
            }
        }

        boolean cleared = dao.clearCartByUser(loginUser.getId());

        if(!cleared) {
            session.setAttribute("failedMsg", "We could not place your order right now.");
            resp.sendRedirect("checkout.jsp");
            return;
        }

        String orderId = "ORD" + System.currentTimeMillis();

        session.setAttribute("orderId", orderId);
        session.setAttribute("orderCustomerName", customerName);
        session.setAttribute("orderPhone", phone);
        session.setAttribute("orderAddress", address + ", " + city);
        session.setAttribute("orderPaymentMethod", paymentMethod);
        session.setAttribute("orderTotal", grandTotal);

        resp.sendRedirect("order_success.jsp");
    }

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }
}
