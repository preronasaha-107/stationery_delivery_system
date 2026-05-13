<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String orderId = (String)session.getAttribute("orderId");
String orderCustomerName = (String)session.getAttribute("orderCustomerName");
String orderPhone = (String)session.getAttribute("orderPhone");
String orderAddress = (String)session.getAttribute("orderAddress");
String orderPaymentMethod = (String)session.getAttribute("orderPaymentMethod");
Double orderTotal = (Double)session.getAttribute("orderTotal");

if(orderId == null){
    response.sendRedirect("index.jsp");
    return;
}

if(orderTotal == null){
    orderTotal = 0.0;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Placed</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background:#f5f7fb;}
.success-card{border:none;border-radius:18px;box-shadow:0 16px 34px rgba(15,23,42,0.09);}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>
<div class="container py-5">
<div class="row justify-content-center">
<div class="col-lg-8">
<div class="card success-card">
<div class="card-body p-5 text-center">
<div class="mb-4">
<i class="fa-solid fa-circle-check text-success" style="font-size:64px;"></i>
</div>
<h2 class="font-weight-bold">Order Placed Successfully</h2>
<p class="text-muted mb-4">Your stationery order has been received and is ready for processing.</p>

<div class="row text-left mt-4">
<div class="col-md-6 mb-3">
<strong>Order ID</strong>
<div><%=orderId%></div>
</div>
<div class="col-md-6 mb-3">
<strong>Payment Method</strong>
<div><%=orderPaymentMethod%></div>
</div>
<div class="col-md-6 mb-3">
<strong>Customer</strong>
<div><%=orderCustomerName%></div>
</div>
<div class="col-md-6 mb-3">
<strong>Phone</strong>
<div><%=orderPhone%></div>
</div>
<div class="col-md-12 mb-3">
<strong>Delivery Address</strong>
<div><%=orderAddress%></div>
</div>
<div class="col-md-12">
<strong>Total Paid</strong>
<div class="text-danger font-weight-bold">&#8377; <%=String.format("%.2f", orderTotal)%></div>
</div>
</div>

<div class="mt-4">
<a href="latest_items.jsp" class="btn btn-primary mr-2">Continue Shopping</a>
<a href="contact.jsp" class="btn btn-outline-secondary">Need Help?</a>
</div>
</div>
</div>
</div>
</div>
</div>
<%
session.removeAttribute("orderId");
session.removeAttribute("orderCustomerName");
session.removeAttribute("orderPhone");
session.removeAttribute("orderAddress");
session.removeAttribute("orderPaymentMethod");
session.removeAttribute("orderTotal");
%>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
