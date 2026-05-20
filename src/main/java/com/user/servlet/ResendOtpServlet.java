package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.User;
import com.util.BrevoEmailService;
import com.util.OtpUtil;

@WebServlet("/resend_otp")
public class ResendOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String purpose = (String) session.getAttribute(OtpUtil.SESSION_OTP_PURPOSE);
        String email = (String) session.getAttribute(OtpUtil.SESSION_OTP_EMAIL);

        if (purpose == null || email == null) {
            session.setAttribute("failedMsg", "No OTP session is active. Please try again.");
            resp.sendRedirect("login.jsp");
            return;
        }

        String recipientName = "Customer";

        if ("register".equalsIgnoreCase(purpose)) {
            User pendingUser = (User) session.getAttribute(OtpUtil.SESSION_PENDING_REGISTER_USER);
            if (pendingUser == null) {
                OtpUtil.clearPendingAuth(session);
                session.setAttribute("failedMsg", "Registration session expired. Please register again.");
                resp.sendRedirect("register.jsp");
                return;
            }
            recipientName = pendingUser.getName();
        } else if ("login".equalsIgnoreCase(purpose)) {
            User pendingUser = (User) session.getAttribute(OtpUtil.SESSION_PENDING_LOGIN_USER);
            if (pendingUser == null) {
                OtpUtil.clearPendingAuth(session);
                session.setAttribute("failedMsg", "Login session expired. Please login again.");
                resp.sendRedirect("login.jsp");
                return;
            }
            recipientName = pendingUser.getName();
        }

        try {
            String otp = OtpUtil.generateOtp();
            long expiryTime = OtpUtil.createExpiryTime();

            BrevoEmailService emailService = new BrevoEmailService();
            emailService.sendOtpEmail(email, recipientName, otp, purpose);
            OtpUtil.storeOtp(session, purpose, email, otp, expiryTime);

            session.setAttribute("succMsg", "A new OTP has been sent to your email.");
            resp.sendRedirect("verify_otp.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "We could not resend the OTP right now. " + e.getMessage());
            resp.sendRedirect("verify_otp.jsp");
        }
    }
}
