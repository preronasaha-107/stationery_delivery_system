package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
			Cart existingCart = getMergedCartEntry(c.getUid(), c.getBid());

			if(existingCart != null) {

				String sql = "update cart set itemname=?, price=?, total_price=? where cid=?";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, c.getItemname());
				ps.setDouble(2, c.getPrice());
				ps.setDouble(3, existingCart.getTotal_price() + c.getTotal_price());
				ps.setInt(4, existingCart.getCid());

				int i = ps.executeUpdate();

				if(i == 1) {
					deleteDuplicateCartRows(c.getUid(), c.getBid(), existingCart.getCid());
					f = true;
				}

				return f;
			}

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
		Map<Integer, Cart> cartByItem = new LinkedHashMap<Integer, Cart>();

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

				Cart existingCart = cartByItem.get(c.getBid());

				if(existingCart == null) {
					cartByItem.put(c.getBid(), c);
				} else {
					existingCart.setTotal_price(existingCart.getTotal_price() + c.getTotal_price());
					existingCart.setQuantity(existingCart.getQuantity() + c.getQuantity());
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		list.addAll(cartByItem.values());
		return list;
	}

	@Override
	public boolean deleteCart(int cid, int uid) {

		boolean f = false;

		try {
			int bid = 0;

			String selectSql = "select bid from cart where cid=? and uid=?";

			PreparedStatement selectPs = conn.prepareStatement(selectSql);
			selectPs.setInt(1, cid);
			selectPs.setInt(2, uid);

			ResultSet rs = selectPs.executeQuery();

			if(rs.next()) {
				bid = rs.getInt(1);
			}

			if(bid == 0) {
				return false;
			}

			String sql = "delete from cart where uid=? and bid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, uid);
			ps.setInt(2, bid);

			int i = ps.executeUpdate();

			if(i > 0) {
				f = true;
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return f;
	}

	@Override
	public boolean clearCartByUser(int uid) {

		boolean f = false;

		try {

			String sql = "delete from cart where uid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, uid);

			ps.executeUpdate();
			f = true;

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

	private Cart getMergedCartEntry(int uid, int bid) {

		Cart cart = null;

		try {

			String sql = "select cid,bid,uid,itemname,price,total_price from cart where uid=? and bid=? order by cid asc";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, uid);
			ps.setInt(2, bid);

			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				if(cart == null) {
					cart = new Cart();
					cart.setCid(rs.getInt("cid"));
					cart.setBid(rs.getInt("bid"));
					cart.setUid(rs.getInt("uid"));
					cart.setItemname(rs.getString("itemname"));
					cart.setPrice(rs.getDouble("price"));
					cart.setTotal_price(0.0);
				}

				cart.setTotal_price(cart.getTotal_price() + rs.getDouble("total_price"));
			}

			if(cart != null && cart.getPrice() > 0) {
				cart.setQuantity((int)Math.round(cart.getTotal_price() / cart.getPrice()));
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return cart;
	}

	private void deleteDuplicateCartRows(int uid, int bid, int keepCid) {

		try {

			String sql = "delete from cart where uid=? and bid=? and cid<>?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, uid);
			ps.setInt(2, bid);
			ps.setInt(3, keepCid);
			ps.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();
		}
	}
}
