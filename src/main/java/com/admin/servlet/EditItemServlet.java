package com.admin.servlet;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.ItemDAOImpl;
import com.DB.DBConnect;
import com.entity.itemdtls;

@WebServlet("/edit_items")
public class EditItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            int id =
            Integer.parseInt(req.getParameter("id"));

            String itemname =
            safeTrim(req.getParameter("itemname"));

            int quantity =
            Integer.parseInt(req.getParameter("quantity"));

            String price =
            safeTrim(req.getParameter("price"));

            String category =
            safeTrim(req.getParameter("category"));

            String status =
            safeTrim(req.getParameter("status"));

            HttpSession session =
            req.getSession();

            if(itemname.isEmpty()) {
                session.setAttribute(
                "failedMsg",
                "Item name is required");

                resp.sendRedirect(
                "admin/edit_items.jsp?id="+id);
                return;
            }

            if(quantity < 0) {
                session.setAttribute(
                "failedMsg",
                "Item quantity cannot be negative");

                resp.sendRedirect(
                "admin/edit_items.jsp?id="+id);
                return;
            }

            double parsedPrice = parsePrice(price);
            if(parsedPrice < 0) {
                session.setAttribute(
                "failedMsg",
                "Please enter a valid non-negative price");

                resp.sendRedirect(
                "admin/edit_items.jsp?id="+id);
                return;
            }

            itemdtls i = new itemdtls();

            i.setItem_id(id);

            i.setItem_name(itemname);

            i.setItem_quantity(quantity);

            i.setPrice(String.format(Locale.US, "%.2f", parsedPrice));

            i.setCategory(category);

            i.setItem_status(status);

            ItemDAOImpl dao =
            new ItemDAOImpl(DBConnect.getConn());

            if(dao.itemNameExists(itemname, id)) {
                session.setAttribute(
                "failedMsg",
                "Another item already uses this name. Please keep item names unique.");

                resp.sendRedirect(
                "admin/edit_items.jsp?id="+id);
                return;
            }

            boolean f =
            dao.updateEditItems(i);

            if(f){

                session.setAttribute(
                "succMsg",
                "Item Updated Successfully");

                resp.sendRedirect(
                "admin/all_items.jsp");

            }else{

                session.setAttribute(
                "failedMsg",
                "Something went wrong");

                resp.sendRedirect(
                "admin/edit_items.jsp?id="+id);
            }

        } catch (Exception e) {

            e.printStackTrace();
            req.getSession().setAttribute(
            "failedMsg",
            "Something went wrong");
            resp.sendRedirect(
            "admin/all_items.jsp");
        }
    }

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }

    private double parsePrice(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return -1.0;
        }
    }
}
