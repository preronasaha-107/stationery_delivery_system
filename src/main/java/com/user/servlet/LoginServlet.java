package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        // ✅ Hardcoded Admin Login
        String adminEmail = "admin@gmail.com";
        String adminPassword = "admin";

        if (email.equals(adminEmail) && password.equals(adminPassword)) {

            session.setAttribute("user", "admin");
            session.setAttribute("adminEmail", email);

            response.sendRedirect("admin/home.jsp");
        }

        else {

            // 👉 Here you will later connect database login
            // For now simple demo user validation

            if (email.equals("user@gmail.com") && password.equals("user")) {

                session.setAttribute("user", "normal");
                session.setAttribute("userEmail", email);

                response.sendRedirect("index.jsp");

            } else {

                session.setAttribute("failedMsg", "Invalid email or password");
                response.sendRedirect("login.jsp");
            }
        }
    }
}