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
import com.util.OtpUtil;

@WebServlet("/verify_otp")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String submittedOtp = safeTrim(req.getParameter("otp"));
        String expectedOtp = (String) session.getAttribute(OtpUtil.SESSION_OTP_CODE);
        Long expiryTime = (Long) session.getAttribute(OtpUtil.SESSION_OTP_EXPIRY);
        String purpose = (String) session.getAttribute(OtpUtil.SESSION_OTP_PURPOSE);

        if (expectedOtp == null || purpose == null) {
            session.setAttribute("failedMsg", "Your verification session has expired. Please try again.");
            resp.sendRedirect("login.jsp");
            return;
        }

        if (submittedOtp.isEmpty()) {
            session.setAttribute("failedMsg", "Please enter the OTP sent to your email.");
            resp.sendRedirect("verify_otp.jsp");
            return;
        }

        if (OtpUtil.isExpired(expiryTime)) {
            session.setAttribute("failedMsg", "OTP expired. Please use Resend OTP to get a new code.");
            resp.sendRedirect("verify_otp.jsp");
            return;
        }

        if (!expectedOtp.equals(submittedOtp)) {
            session.setAttribute("failedMsg", "Invalid OTP. Please try again.");
            resp.sendRedirect("verify_otp.jsp");
            return;
        }

        if ("register".equalsIgnoreCase(purpose)) {
            completeRegistration(session, resp);
            return;
        }

        if ("login".equalsIgnoreCase(purpose)) {
            completeLogin(session, resp);
            return;
        }

        OtpUtil.clearPendingAuth(session);
        session.setAttribute("failedMsg", "Unknown OTP verification flow.");
        resp.sendRedirect("login.jsp");
    }

    private void completeRegistration(HttpSession session, HttpServletResponse resp) throws IOException {
        User pendingUser = (User) session.getAttribute(OtpUtil.SESSION_PENDING_REGISTER_USER);

        if (pendingUser == null) {
            OtpUtil.clearPendingAuth(session);
            session.setAttribute("failedMsg", "Registration session expired. Please register again.");
            resp.sendRedirect("register.jsp");
            return;
        }

        UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());

        if (dao.userExists(pendingUser.getEmail())) {
            OtpUtil.clearPendingAuth(session);
            session.setAttribute("failedMsg", "An account with this email already exists.");
            resp.sendRedirect("register.jsp");
            return;
        }

        boolean registered = dao.userRegister(pendingUser);
        OtpUtil.clearPendingAuth(session);

        if (registered) {
            session.setAttribute("succMsg", "Email verified. Registration successful. Please login.");
            resp.sendRedirect("login.jsp");
            return;
        }

        session.setAttribute("failedMsg", "We could not complete your registration.");
        resp.sendRedirect("register.jsp");
    }

    private void completeLogin(HttpSession session, HttpServletResponse resp) throws IOException {
        User pendingUser = (User) session.getAttribute(OtpUtil.SESSION_PENDING_LOGIN_USER);

        if (pendingUser == null) {
            OtpUtil.clearPendingAuth(session);
            session.setAttribute("failedMsg", "Login session expired. Please login again.");
            resp.sendRedirect("login.jsp");
            return;
        }

        OtpUtil.clearPendingAuth(session);
        session.removeAttribute("adminEmail");
        session.setAttribute("user", "normal");
        session.setAttribute("userobj", pendingUser);
        session.setAttribute("userEmail", pendingUser.getEmail());
        session.setAttribute("succMsg", "Welcome back, " + pendingUser.getName() + "!");

        resp.sendRedirect("home.jsp");
    }

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }
}
