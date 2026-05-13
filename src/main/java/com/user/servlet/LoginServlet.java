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

            session.removeAttribute("adminEmail");
            session.setAttribute("user", "normal");
            session.setAttribute("userobj", us);
            session.setAttribute("userEmail", us.getEmail());
            session.setAttribute("succMsg", "Welcome back, " + us.getName() + "!");

            response.sendRedirect("home.jsp");

        } else {

            session.setAttribute("failedMsg", "Invalid email or password");
            response.sendRedirect("login.jsp");
        }
    }

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }
}
