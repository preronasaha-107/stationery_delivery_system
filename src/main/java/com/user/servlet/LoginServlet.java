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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        String adminEmail = "admin@gmail.com";
        String adminPassword = "admin";

        if (adminEmail.equals(email) && adminPassword.equals(password)) {

            session.setAttribute("user", "admin");
            session.setAttribute("adminEmail", email);

            response.sendRedirect("admin/home.jsp");
            return;
        }

        UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
        User us = dao.login(email, password);

        if (us != null) {

            session.setAttribute("user", "normal");
            session.setAttribute("userobj", us);
            session.setAttribute("userEmail", us.getEmail());

            response.sendRedirect("index.jsp");

        } else {

            session.setAttribute("failedMsg", "Invalid email or password");
            response.sendRedirect("login.jsp");
        }
    }
}
