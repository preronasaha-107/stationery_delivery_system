package com.DAO;

import java.util.List;

import com.entity.ItemOrder;

public interface OrderDAO {

    public boolean saveOrders(List<ItemOrder> orders);

    public List<ItemOrder> getAllOrders();
}
