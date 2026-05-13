package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Cart;

public class CartDAOImpl implements CartDAO {

	private Connection conn;

	public CartDAOImpl(Connection conn) {

		this.conn = conn;
	}

	@Override
	public boolean addCart(Cart c) {

		boolean f = false;

		try {

			String sql =
			"insert into cart(bid,uid,itemname,price,total_price) values(?,?,?,?,?)";

			PreparedStatement ps =
			conn.prepareStatement(sql);

			ps.setInt(1, c.getBid());

			ps.setInt(2, c.getUid());

			ps.setString(3, c.getItemname());

			ps.setDouble(4, c.getPrice());

			ps.setDouble(5, c.getTotal_price());

			int i = ps.executeUpdate();

			if(i == 1) {

				f = true;
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return f;
	}

	@Override
	public List<Cart> getCartByUser(int uid) {

		List<Cart> list = new ArrayList<Cart>();

		try {

			String sql = "select * from cart where uid=? order by cid desc";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, uid);

			ResultSet rs = ps.executeQuery();

			while(rs.next()) {

				Cart c = new Cart();
				c.setCid(rs.getInt(1));
				c.setBid(rs.getInt(2));
				c.setUid(rs.getInt(3));
				c.setItemname(rs.getString(4));
				c.setPrice(rs.getDouble(5));
				c.setTotal_price(rs.getDouble(6));

				int quantity = 1;
				if(c.getPrice() > 0) {
					quantity = (int)Math.round(c.getTotal_price() / c.getPrice());
				}
				c.setQuantity(quantity);

				list.add(c);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return list;
	}

	@Override
	public boolean deleteCart(int cid, int uid) {

		boolean f = false;

		try {

			String sql = "delete from cart where cid=? and uid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, cid);
			ps.setInt(2, uid);

			int i = ps.executeUpdate();

			if(i == 1) {
				f = true;
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return f;
	}

	@Override
	public int getCartItemQuantity(int uid, int bid) {

		int quantity = 0;

		try {

			String sql = "select price,total_price from cart where uid=? and bid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, uid);
			ps.setInt(2, bid);

			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				double price = rs.getDouble(1);
				double totalPrice = rs.getDouble(2);

				if(price > 0) {
					quantity += (int)Math.round(totalPrice / price);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return quantity;
	}
}
