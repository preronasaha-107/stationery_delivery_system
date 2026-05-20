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
import com.util.PhoneNumberUtil;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String name = safeTrim(req.getParameter("fname"));
            String email = safeTrim(req.getParameter("email")).toLowerCase();
            String phno = safeTrim(req.getParameter("phno"));
            String password = safeTrim(req.getParameter("password"));
            String check = req.getParameter("check");

            User us = new User();

            us.setName(name);
            us.setEmail(email);
            us.setPhno(phno);
            us.setPassword(password);

            HttpSession session = req.getSession();

            if(name.isEmpty() || email.isEmpty() || password.isEmpty()) {
                session.setAttribute(
                        "failedMsg",
                        "Please fill in all registration details");

                resp.sendRedirect("register.jsp");
                return;
            }

            String normalizedPhone = "";
            if(!phno.isEmpty()) {
                normalizedPhone = PhoneNumberUtil.normalizeForStorage(phno);
                if(normalizedPhone == null) {
                    session.setAttribute(
                            "failedMsg",
                            "Please enter a valid phone number in the format +91 98765 43210");

                    resp.sendRedirect("register.jsp");
                    return;
                }
            }

            us.setPhno(normalizedPhone);

            if(check != null) {

                UserDAOImpl dao =
                        new UserDAOImpl(DBConnect.getConn());

                if(dao.userExists(email)) {
                    session.setAttribute(
                            "failedMsg",
                            "An account with this email already exists");

                    resp.sendRedirect("register.jsp");
                    return;
                }

                try {
                    String otp = OtpUtil.generateOtp();
                    long expiryTime = OtpUtil.createExpiryTime();

                    BrevoEmailService emailService = new BrevoEmailService();
                    emailService.sendOtpEmail(us.getEmail(), us.getName(), otp, "register");

                    OtpUtil.clearPendingAuth(session);
                    session.setAttribute(OtpUtil.SESSION_PENDING_REGISTER_USER, us);
                    OtpUtil.storeOtp(session, "register", us.getEmail(), otp, expiryTime);
                    session.setAttribute(
                            "succMsg",
                            "We sent an OTP to your email. Enter it to complete registration.");

                    resp.sendRedirect("verify_otp.jsp");

                } catch (Exception e) {

                    e.printStackTrace();
                    session.setAttribute(
                            "failedMsg",
                            "We could not send the OTP email. " + e.getMessage());

                    resp.sendRedirect("register.jsp");
                }

            } else {

                session.setAttribute(
                        "failedMsg",
                        "Please agree Terms & Conditions");

                resp.sendRedirect("register.jsp");
            }

        } catch (Exception e) {

            e.printStackTrace();
            req.getSession().setAttribute(
                    "failedMsg",
                    "Something went wrong");
            resp.sendRedirect("register.jsp");
        }
    }

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }
}
