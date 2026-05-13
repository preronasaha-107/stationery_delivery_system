package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.CartDAOImpl;
import com.DB.DBConnect;

@WebServlet("/remove_cart")
public class RemoveCartServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int uid = 1;

		try {
			int cid = Integer.parseInt(req.getParameter("cid"));

			String uidParam = req.getParameter("uid");
			if(uidParam != null && !uidParam.trim().isEmpty()) {
				uid = Integer.parseInt(uidParam);
			}

			CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
			boolean f = dao.deleteCart(cid, uid);

			HttpSession session = req.getSession();
			if(f) {
				session.setAttribute("succMsg", "Item removed from cart.");
			} else {
				session.setAttribute("failedMsg", "Unable to remove item from cart.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			req.getSession().setAttribute("failedMsg", "Unable to remove item from cart.");
		}

		resp.sendRedirect("cart.jsp?uid=" + uid);
	}
}
