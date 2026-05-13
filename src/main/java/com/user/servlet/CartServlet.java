package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.CartDAOImpl;
import com.DAO.ItemDAOImpl;
import com.DB.DBConnect;
import com.entity.Cart;
import com.entity.itemdtls;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		try {

			int iid =
			Integer.parseInt(req.getParameter("iid"));

			int uid =
			Integer.parseInt(req.getParameter("uid"));

			System.out.println(iid);
			System.out.println(uid);

			ItemDAOImpl dao =
			new ItemDAOImpl(DBConnect.getConn());

			itemdtls i =
			dao.getItemById(iid);

			if(i == null) {

				System.out.println("ITEM NULL");

				resp.sendRedirect("index.jsp");

				return;
			}

			System.out.println(i.getItem_name());
             System.out.println(i.getPrice());		
             Cart c = new Cart();

			c.setBid(iid);

			c.setUid(uid);

			c.setItemname(i.getItem_name());

			c.setPrice(
			Double.parseDouble(i.getPrice()));

			c.setTotal_price(
			Double.parseDouble(i.getPrice()));

			CartDAOImpl dao2 =
			new CartDAOImpl(DBConnect.getConn());

			boolean f = dao2.addCart(c);

			if(f) {

				System.out.println("SUCCESS");

				resp.sendRedirect("cart.jsp");

			} else {

				System.out.println("FAILED");

				resp.sendRedirect("index.jsp");
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
	}
}
