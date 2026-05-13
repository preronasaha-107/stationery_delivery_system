<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Us</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background:#f5f7fb;}
.info-card{border:none;border-radius:16px;box-shadow:0 12px 30px rgba(15,23,42,0.08);}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>
<div class="container py-5">
<div class="row">
<div class="col-lg-7 mb-4">
<div class="card info-card h-100">
<div class="card-body p-4">
<h2 class="font-weight-bold mb-3">Contact Us</h2>
<p class="text-muted">Need help with orders, delivery timing, item availability, or bulk stationery requests? Our support desk is ready to help.</p>
<div class="mt-4">
<p><i class="fa-solid fa-envelope text-primary mr-2"></i>support@stationeryshop.com</p>
<p><i class="fa-solid fa-phone text-primary mr-2"></i>+91 98765 43210</p>
<p><i class="fa-solid fa-location-dot text-primary mr-2"></i>12 College Street, Kolkata, West Bengal</p>
<p><i class="fa-solid fa-clock text-primary mr-2"></i>Monday to Saturday, 9:00 AM to 7:00 PM</p>
</div>
</div>
</div>
</div>
<div class="col-lg-5 mb-4">
<div class="card info-card h-100">
<div class="card-body p-4">
<h4 class="font-weight-bold mb-3">Quick Help</h4>
<ul class="list-unstyled text-muted mb-0">
<li class="mb-3">Track your latest order from the order success page details.</li>
<li class="mb-3">Use the cart icon in the navbar to review items before checkout.</li>
<li class="mb-3">Choose Cash on Delivery or dummy card payment during checkout.</li>
<li class="mb-0">For urgent stock confirmation, call the support line above.</li>
</ul>
</div>
</div>
</div>
</div>
</div>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
