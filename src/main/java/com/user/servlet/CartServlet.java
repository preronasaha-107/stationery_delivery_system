package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.CartDAOImpl;
import com.DAO.ItemDAOImpl;
import com.DB.DBConnect;
import com.entity.Cart;
import com.entity.User;
import com.entity.itemdtls;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		int iid = 0;
		int uid = 0;

		try {

			iid =
			Integer.parseInt(req.getParameter("iid"));

			HttpSession session = req.getSession();
			User loginUser = (User)session.getAttribute("userobj");
			if(loginUser == null) {
				session.setAttribute("failedMsg", "Please login before adding items to the cart.");
				resp.sendRedirect("login.jsp");
				return;
			}
			uid = loginUser.getId();

			int quantity = 1;
			String qtyParam = req.getParameter("quantity");
			if(qtyParam != null && !qtyParam.trim().isEmpty()) {
				quantity = Integer.parseInt(qtyParam);
			}

			ItemDAOImpl dao =
			new ItemDAOImpl(DBConnect.getConn());

			itemdtls i =
			dao.getItemById(iid);

			if(i == null) {

				resp.sendRedirect("index.jsp");

				return;
			}

			if(quantity < 1) {
				session.setAttribute("failedMsg", "Please select at least 1 item.");
				resp.sendRedirect("view_items.jsp?id=" + iid);
				return;
			}

			if(i.getItem_quantity() <= 0) {
				session.setAttribute("failedMsg", "This item is currently out of stock.");
				resp.sendRedirect("view_items.jsp?id=" + iid);
				return;
			}

			if(quantity > i.getItem_quantity()) {
				session.setAttribute("failedMsg", "Only " + i.getItem_quantity() + " item(s) are available in stock.");
				resp.sendRedirect("view_items.jsp?id=" + iid);
				return;
			}

			CartDAOImpl dao2 =
			new CartDAOImpl(DBConnect.getConn());

			int alreadyInCart = dao2.getCartItemQuantity(uid, iid);
			int remainingStock = i.getItem_quantity() - alreadyInCart;

			if(remainingStock <= 0) {
				session.setAttribute("failedMsg", "You already have all available stock for this item in your cart.");
				resp.sendRedirect("view_items.jsp?id=" + iid);
				return;
			}

			if(quantity > remainingStock) {
				session.setAttribute("failedMsg", "You already have " + alreadyInCart + " item(s) in your cart. Only " + remainingStock + " more can be added.");
				resp.sendRedirect("view_items.jsp?id=" + iid);
				return;
			}

			double itemPrice = Double.parseDouble(i.getPrice());

			Cart c = new Cart();

			c.setBid(iid);

			c.setUid(uid);

			c.setItemname(i.getItem_name());

			c.setPrice(itemPrice);

			c.setQuantity(quantity);

			c.setTotal_price(itemPrice * quantity);

			boolean f = dao2.addCart(c);

			if(f) {

				session.setAttribute("succMsg", "Item added to cart successfully.");

				resp.sendRedirect("cart.jsp?uid=" + uid);

			} else {

				session.setAttribute("failedMsg", "Failed to add item to cart.");

				resp.sendRedirect("index.jsp");
			}

		} catch (Exception e) {

			e.printStackTrace();
			req.getSession().setAttribute("failedMsg", "Unable to add item to cart.");
			if(iid > 0) {
				resp.sendRedirect("view_items.jsp?id=" + iid);
			} else {
				resp.sendRedirect("index.jsp");
			}
		}
	}
}
