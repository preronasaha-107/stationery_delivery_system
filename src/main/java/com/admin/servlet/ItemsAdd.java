package com.admin.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.DAO.ItemDAOImpl;
import com.DB.DBConnect;
import com.entity.itemdtls;

@WebServlet("/add_items")
@MultipartConfig
public class ItemsAdd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String item_name =
                    req.getParameter("itemname");

            int item_quantity =
                    Integer.parseInt(
                    req.getParameter("quantity"));

            String price =
                    req.getParameter("price");

            String category =
                    req.getParameter("category");

            String item_status =
                    req.getParameter("status");

            Part part =
                    req.getPart("photo");

            String fileName =
                    part.getSubmittedFileName();

            HttpSession session =
                    req.getSession();

            if(item_quantity < 0) {
                session.setAttribute(
                        "failedMsg",
                        "Item quantity cannot be negative");

                resp.sendRedirect(
                        "admin/add_items.jsp");
                return;
            }

            if(fileName == null || fileName.trim().isEmpty()) {
                session.setAttribute(
                        "failedMsg",
                        "Please upload an item photo");

                resp.sendRedirect(
                        "admin/add_items.jsp");
                return;
            }

            itemdtls i = new itemdtls(

                    item_name,
                    item_quantity,
                    price,
                    category,
                    item_status,
                    fileName,
                    "admin@gmail.com"

            );

            ItemDAOImpl dao =
                    new ItemDAOImpl(DBConnect.getConn());
            
            boolean f = dao.additems(i);

            if(f) {
            String path = getServletContext().getRealPath("recent");

            File file = new File(path);
            if(!file.exists()) {
                file.mkdirs();
            }
            part.write(path + File.separator + fileName);


                session.setAttribute(
                        "succMsg",
                        "Item Added Successfully");

                resp.sendRedirect(
                        "admin/add_items.jsp");

            } else {

                session.setAttribute(
                        "failedMsg",
                        "Failed To Add Item");

                resp.sendRedirect(
                        "admin/add_items.jsp");
            }

        } catch (Exception e) {

            e.printStackTrace();
            req.getSession().setAttribute(
                    "failedMsg",
                    "Failed To Add Item");
            resp.sendRedirect(
                    "admin/add_items.jsp");
        }
    }
}
