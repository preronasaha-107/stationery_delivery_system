<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.DAO.OrderDAOImpl" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.ItemOrder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Admin: Orders</title>

<%@include file="allCSS.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>
<%
OrderDAOImpl orderDao = new OrderDAOImpl(DBConnect.getConn());
List<ItemOrder> orders = orderDao.getAllOrders();
%>
<h2 class="text-center">Admin:Total Orders</h2>
<table class="table table-striped">
  <thead class="bg-primary text-white">
    <tr>
      <th scope="col"> Order Id</th>
      <th scope="col"> Name</th>
      <th scope="col">Email</th>
      <th scope="col">Address</th>
      <th scope="col">Phone no</th>
      <th scope="col">Item Name</th>
      <th scope="col">Price</th>
      <th scope="col">Payment Type</th>
      
    </tr>
  </thead >
  <tbody>
    <% if(orders.isEmpty()){ %>
    <tr>
      <td colspan="8" class="text-center">No orders found in the database.</td>
    </tr>
    <% } else { %>
    <% for(ItemOrder order : orders){ %>
    <tr>
      <th scope="row"><%=order.getOrderId()%></th>
      <td><%=order.getUserName()%></td>
      <td><%=order.getEmail()%></td>
      <td><%=order.getAddress()%></td>
      <td><%=order.getPhno()%></td>
      <td><%=order.getItemName()%></td>
      <td>&#8377; <%=order.getPrice()%></td>
      <td><%=order.getPayment()%></td>
    </tr>
    <% } %>
    <% } %>
  </tbody>
</table>
<div style="margin-top:195px;">
<%@include file="footer.jsp"%>
</div>
</body>
</html>
