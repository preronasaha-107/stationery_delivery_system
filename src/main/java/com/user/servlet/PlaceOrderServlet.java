package com.user.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.CartDAOImpl;
import com.DAO.OrderDAOImpl;
import com.DB.DBConnect;
import com.entity.Cart;
import com.entity.ItemOrder;
import com.entity.User;
import com.util.PhoneNumberUtil;

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

        Connection conn = DBConnect.getConn();
        if(conn == null) {
            session.setAttribute("failedMsg", "Database connection is unavailable right now.");
            resp.sendRedirect("checkout.jsp");
            return;
        }

        CartDAOImpl dao = new CartDAOImpl(conn);
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

        String normalizedPhone = PhoneNumberUtil.normalizeForStorage(phone);
        if(normalizedPhone == null) {
            session.setAttribute("failedMsg", "Please enter a valid phone number in the format +91 98765 43210.");
            resp.sendRedirect("checkout.jsp");
            return;
        }

        List<Cart> cartItems = dao.getCartByUser(loginUser.getId());

        if(cartItems.isEmpty()) {
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

        String orderId = "ORD" + System.currentTimeMillis();
        String fullAddress = address + ", " + city;
        String paymentLabel = "COD".equalsIgnoreCase(paymentMethod) ? "Cash On Delivery" : paymentMethod;
        List<ItemOrder> orders = new ArrayList<ItemOrder>();

        for(Cart cartItem : cartItems) {
            ItemOrder order = new ItemOrder();
            order.setOrderId(orderId);
            order.setUserName(customerName);
            order.setEmail(loginUser.getEmail());
            order.setAddress(fullAddress);
            order.setPhno(normalizedPhone);
            order.setItemName(buildOrderItemName(cartItem));
            order.setPrice(String.format(Locale.US, "%.2f", cartItem.getTotal_price()));
            order.setPayment(paymentLabel);
            orders.add(order);
        }

        boolean placedSuccessfully = false;

        try {
            conn.setAutoCommit(false);

            OrderDAOImpl orderDao = new OrderDAOImpl(conn);
            boolean saved = orderDao.saveOrders(orders);
            boolean cleared = dao.clearCartByUser(loginUser.getId());

            if(saved && cleared) {
                conn.commit();
                placedSuccessfully = true;
            } else {
                conn.rollback();
            }

        } catch (Exception e) {
            e.printStackTrace();
            try {
                conn.rollback();
            } catch (Exception rollbackException) {
                rollbackException.printStackTrace();
            }
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if(!placedSuccessfully) {
            session.setAttribute("failedMsg", "We could not place your order right now.");
            resp.sendRedirect("checkout.jsp");
            return;
        }

        session.setAttribute("orderId", orderId);
        session.setAttribute("orderCustomerName", customerName);
        session.setAttribute("orderPhone", normalizedPhone);
        session.setAttribute("orderAddress", fullAddress);
        session.setAttribute("orderPaymentMethod", paymentLabel);
        session.setAttribute("orderTotal", grandTotal);

        resp.sendRedirect("order_success.jsp");
    }

    private String buildOrderItemName(Cart cartItem) {
        if(cartItem.getQuantity() > 1) {
            return cartItem.getItemname() + " (Qty: " + cartItem.getQuantity() + ")";
        }
        return cartItem.getItemname();
    }

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }
}
