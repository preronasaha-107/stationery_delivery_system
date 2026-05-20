package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.ItemOrder;

public class OrderDAOImpl implements OrderDAO {

    private Connection conn;

    public OrderDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean saveOrders(List<ItemOrder> orders) {
        if (orders == null || orders.isEmpty()) {
            return false;
        }

        boolean saved = false;

        try {
            String sql = "insert into item_order(order_id,user_name,email,address,phno,item_name,price,payment) "
                    + "values(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            for (ItemOrder order : orders) {
                ps.setString(1, order.getOrderId());
                ps.setString(2, order.getUserName());
                ps.setString(3, order.getEmail());
                ps.setString(4, order.getAddress());
                ps.setString(5, order.getPhno());
                ps.setString(6, order.getItemName());
                ps.setString(7, order.getPrice());
                ps.setString(8, order.getPayment());
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            saved = results.length == orders.size();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return saved;
    }

    @Override
    public List<ItemOrder> getAllOrders() {
        List<ItemOrder> orders = new ArrayList<ItemOrder>();

        try {
            String sql = "select * from item_order order by id desc";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ItemOrder order = new ItemOrder();
                order.setId(rs.getInt("id"));
                order.setOrderId(rs.getString("order_id"));
                order.setUserName(rs.getString("user_name"));
                order.setEmail(rs.getString("email"));
                order.setAddress(rs.getString("address"));
                order.setPhno(rs.getString("phno"));
                order.setItemName(rs.getString("item_name"));
                order.setPrice(rs.getString("price"));
                order.setPayment(rs.getString("payment"));
                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}
