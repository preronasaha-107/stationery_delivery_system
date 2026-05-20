package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.UserDAOImpl;
import com.DB.DBConnect;
import com.entity.User;
import com.util.BrevoEmailService;
import com.util.OtpUtil;

import java.sql.Connection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = safeTrim(request.getParameter("email")).toLowerCase();
        String password = safeTrim(request.getParameter("password"));

        HttpSession session = request.getSession();

        session.removeAttribute("failedMsg");
        session.removeAttribute("succMsg");

        String adminEmail = "admin@gmail.com";
        String adminPassword = "admin";

        if (adminEmail.equals(email) && adminPassword.equals(password)) {

            session.removeAttribute("userobj");
            session.removeAttribute("userEmail");
            session.setAttribute("user", "admin");
            session.setAttribute("adminEmail", email);

            response.sendRedirect("admin/home.jsp");
            return;
        }

        if(email.isEmpty() || password.isEmpty()) {
            session.setAttribute("failedMsg", "Please enter both email and password");
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = DBConnect.getConn();
        if(conn == null) {
            session.setAttribute("failedMsg", "User login is unavailable because the database connection could not be established.");
            response.sendRedirect("login.jsp");
            return;
        }

        UserDAOImpl dao = new UserDAOImpl(conn);
        User us = dao.login(email, password);

        if (us != null) {
            try {
                String otp = OtpUtil.generateOtp();
                long expiryTime = OtpUtil.createExpiryTime();

                BrevoEmailService emailService = new BrevoEmailService();
                emailService.sendOtpEmail(us.getEmail(), us.getName(), otp, "login");

                OtpUtil.clearPendingAuth(session);
                session.removeAttribute("userobj");
                session.removeAttribute("userEmail");
                session.setAttribute(OtpUtil.SESSION_PENDING_LOGIN_USER, us);
                OtpUtil.storeOtp(session, "login", us.getEmail(), otp, expiryTime);
                session.setAttribute("succMsg", "We sent an OTP to your email. Enter it to finish logging in.");

                response.sendRedirect("verify_otp.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("failedMsg", "We could not send the OTP email. " + e.getMessage());
                response.sendRedirect("login.jsp");
            }

        } else {

            session.setAttribute("failedMsg", "Invalid email or password");
            response.sendRedirect("login.jsp");
        }
    }

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }
}
