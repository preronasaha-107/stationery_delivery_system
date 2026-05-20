<%@page import="java.util.List"%>
<%@page import="com.DAO.CartDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.Cart"%>
<%@page import="com.entity.User"%>
<%@page import="com.util.PhoneNumberUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
User checkoutUser = (User)session.getAttribute("userobj");
List<Cart> cartList = null;
double grandTotal = 0.0;

if(checkoutUser != null){
    CartDAOImpl checkoutDao = new CartDAOImpl(DBConnect.getConn());
    cartList = checkoutDao.getCartByUser(checkoutUser.getId());
    for(Cart cartItem : cartList){
        grandTotal += cartItem.getTotal_price();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background-color:#f0f1f2;}
.checkout-card{border:1px solid #dee2e6;}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>

<div class="container py-5">
<%
String failedMsg = (String)session.getAttribute("failedMsg");
if(failedMsg != null){
%>
<div class="alert alert-danger text-center"><%=failedMsg%></div>
<%
session.removeAttribute("failedMsg");
}
%>

<% if(checkoutUser == null){ %>
<div class="card checkout-card">
<div class="card-body text-center p-5">
<h4>Please login to continue to checkout.</h4>
<a href="login.jsp" class="btn btn-primary mt-3">Login Now</a>
</div>
</div>
<% } else if(cartList == null || cartList.isEmpty()){ %>
<div class="card checkout-card">
<div class="card-body text-center p-5">
<h4>Your cart is empty.</h4>
<a href="latest_items.jsp" class="btn btn-primary mt-3">Browse Items</a>
</div>
</div>
<% } else { %>
<div class="row">
<div class="col-lg-7 mb-4">
<div class="card checkout-card">
<div class="card-body p-4">
<h3 class="font-weight-bold mb-4">Delivery and Payment</h3>
<form action="place_order" method="post">
<input type="hidden" name="grandTotal" value="<%=grandTotal%>">
<div class="form-row">
<div class="form-group col-md-6">
<label>Full Name</label>
<input type="text" class="form-control" name="customerName" value="<%=checkoutUser.getName()%>" required>
</div>
<div class="form-group col-md-6">
<label>Phone Number</label>
<input type="tel" class="form-control" name="phone"
value="<%=PhoneNumberUtil.normalizeForDisplay(checkoutUser.getPhno())%>"
placeholder="+91 98765 43210"
pattern="(?:\+91\s?)?[6-9][0-9]{4}\s?[0-9]{5}"
title="Enter a valid Indian phone number such as +91 98765 43210"
maxlength="15" onblur="formatIndianPhoneNumber(this)" required>
</div>
</div>
<div class="form-group">
<label>Delivery Address</label>
<textarea class="form-control" name="address" rows="3" required><%=checkoutUser.getAddress() == null ? "" : checkoutUser.getAddress()%></textarea>
</div>
<div class="form-group">
<label>City</label>
<input type="text" class="form-control" name="city" value="<%=checkoutUser.getCity() == null ? "" : checkoutUser.getCity()%>" required>
</div>
<div class="form-group">
<label>Payment Method</label>
<select class="form-control" name="paymentMethod" id="paymentMethod" onchange="toggleCardFields()" required>
<option value="COD">Cash On Delivery</option>
<option value="Card">Debit/Credit Card (Dummy)</option>
</select>
</div>
<div id="cardFields" style="display:none;">
<div class="form-group">
<label>Name On Card</label>
<input type="text" class="form-control" name="cardName">
</div>
<div class="form-group">
<label>Card Number</label>
<input type="text" class="form-control" name="cardNumber" maxlength="16" placeholder="1234123412341234">
</div>
<div class="form-row">
<div class="form-group col-md-6">
<label>Expiry</label>
<input type="text" class="form-control" name="expiry" placeholder="MM/YY">
</div>
<div class="form-group col-md-6">
<label>CVV</label>
<input type="password" class="form-control" name="cvv" maxlength="4" placeholder="123">
</div>
</div>
</div>
<button type="submit" class="btn btn-success btn-block mt-3">Place Order</button>
</form>
</div>
</div>
</div>

<div class="col-lg-5 mb-4">
<div class="card checkout-card">
<div class="card-body p-4">
<h4 class="font-weight-bold mb-4">Order Summary</h4>
<% for(Cart cartItem : cartList){ %>
<div class="d-flex justify-content-between mb-3">
<div>
<strong><%=cartItem.getItemname()%></strong><br>
<span class="text-muted small">Qty: <%=cartItem.getQuantity()%></span>
</div>
<span>&#8377; <%=String.format("%.2f", cartItem.getTotal_price())%></span>
</div>
<% } %>
<hr>
<div class="d-flex justify-content-between">
<span>Total</span>
<strong class="text-danger">&#8377; <%=String.format("%.2f", grandTotal)%></strong>
</div>
<p class="text-muted small mt-3 mb-0">Card entry is for demo flow only. No real payment will be processed.</p>
</div>
</div>
</div>
</div>
<% } %>
</div>

<script>
function formatIndianPhoneNumber(input){
    if(!input){
        return;
    }

    var digits = input.value.replace(/\D/g, "");
    if(digits.length === 12 && digits.indexOf("91") === 0){
        digits = digits.substring(2);
    }

    if(digits.length === 10){
        input.value = "+91 " + digits.substring(0, 5) + " " + digits.substring(5);
    }
}

function toggleCardFields(){
    var paymentMethod = document.getElementById("paymentMethod");
    var cardFields = document.getElementById("cardFields");
    if(paymentMethod && paymentMethod.value === "Card"){
        cardFields.style.display = "block";
    } else {
        cardFields.style.display = "none";
    }
}
var phoneInput = document.querySelector('input[name="phone"]');
formatIndianPhoneNumber(phoneInput);
toggleCardFields();
</script>

<%@include file="all_component/footer.jsp"%>
</body>
</html>
