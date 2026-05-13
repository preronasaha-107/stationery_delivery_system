package com.DAO;

import java.util.List;

import com.entity.Cart;

public interface CartDAO {

	public boolean addCart(Cart c);
	public List<Cart> getCartByUser(int uid);
	public int getCartItemQuantity(int uid, int bid);
	public boolean deleteCart(int cid, int uid);
	public boolean clearCartByUser(int uid);

}
