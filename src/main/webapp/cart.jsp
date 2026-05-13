<%@page import="java.util.List"%>
<%@page import="com.DAO.CartDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.Cart"%>
<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
User loginUser = (User)session.getAttribute("userobj");
if(loginUser == null){
	session.setAttribute("failedMsg", "Please login to view your cart.");
	response.sendRedirect("login.jsp");
	return;
}
int uid = loginUser.getId();

CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
List<Cart> cartList = dao.getCartByUser(uid);

double subtotal = 0.0;
int totalItems = 0;
for(Cart c : cartList){
	subtotal += c.getTotal_price();
	totalItems += c.getQuantity();
}
double deliveryCharge = subtotal > 0 ? 0.0 : 0.0;
double grandTotal = subtotal + deliveryCharge;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart Page</title>

<%@include file="all_component/allCSS.jsp"%>

</head>

<body style="background-color:#f0f1f2;">

<%@include file="all_component/navbar.jsp"%>

<div class="container p-5">

<%
String succMsg = (String)session.getAttribute("succMsg");
String failedMsg = (String)session.getAttribute("failedMsg");

if(succMsg != null){
%>
<div class="alert alert-success text-center" role="alert">
<%=succMsg%>
</div>
<%
session.removeAttribute("succMsg");
}

if(failedMsg != null){
%>
<div class="alert alert-danger text-center" role="alert">
<%=failedMsg%>
</div>
<%
session.removeAttribute("failedMsg");
}
%>

<div class="row">

<div class="col-md-8">
<div class="card">
<div class="card-body">

<h3 class="text-center text-success mb-4">Your Cart</h3>

<%
if(cartList.isEmpty()){
%>
<div class="text-center p-4">
<h5>Your cart is empty.</h5>
<a href="index.jsp" class="btn btn-primary mt-2">Continue Shopping</a>
</div>
<%
} else {
%>
<table class="table table-bordered table-hover">
<thead class="bg-light">
<tr>
<th>Item</th>
<th class="text-center">Items</th>
<th class="text-right">Single Price</th>
<th class="text-right">Total</th>
<th class="text-center">Action</th>
</tr>
</thead>
<tbody>
<%
for(Cart c : cartList){
%>
<tr>
<td><%=c.getItemname()%></td>
<td class="text-center"><%=c.getQuantity()%></td>
<td class="text-right">&#8377; <%=String.format("%.2f", c.getPrice())%></td>
<td class="text-right">&#8377; <%=String.format("%.2f", c.getTotal_price())%></td>
<td class="text-center">
<a href="remove_cart?cid=<%=c.getCid()%>"
class="btn btn-sm btn-outline-danger">
Remove
</a>
</td>
</tr>
<%
}
%>
</tbody>
</table>
<%
}
%>

</div>
</div>
</div>

<div class="col-md-4">
<div class="card">
<div class="card-body">

<h4 class="text-center text-success mb-4">Order Summary</h4>

<div class="d-flex justify-content-between">
<span>Total Items</span>
<strong><%=totalItems%></strong>
</div>

<hr>

<div class="d-flex justify-content-between">
<span>Subtotal</span>
<strong>&#8377; <%=String.format("%.2f", subtotal)%></strong>
</div>

<hr>

<div class="d-flex justify-content-between">
<span>Delivery</span>
<strong><%=deliveryCharge == 0.0 ? "Free" : "&#8377; " + String.format("%.2f", deliveryCharge)%></strong>
</div>

<hr>

<div class="d-flex justify-content-between">
<span>Total</span>
<strong class="text-danger">&#8377; <%=String.format("%.2f", grandTotal)%></strong>
</div>

<a href="index.jsp" class="btn btn-primary btn-block mt-4">Continue Shopping</a>

<a href="checkout.jsp"
class="btn btn-success btn-block mt-2 <%=cartList.isEmpty() ? "disabled" : ""%>">
Proceed To Checkout
</a>

</div>
</div>
</div>

</div>

</div>

</body>
</html>
