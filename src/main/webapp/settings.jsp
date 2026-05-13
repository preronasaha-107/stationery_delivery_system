<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.entity.User"%>
<%
User settingsUser = (User)session.getAttribute("userobj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Settings</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background:#f5f7fb;}
.settings-card{border:none;border-radius:16px;box-shadow:0 12px 30px rgba(15,23,42,0.08);}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>
<div class="container py-5">
<div class="row">
<div class="col-lg-4 mb-4">
<div class="card settings-card h-100">
<div class="card-body p-4">
<h4 class="font-weight-bold mb-3">Account Snapshot</h4>
<p class="mb-2"><strong>Status:</strong> <%=settingsUser != null ? "Logged In" : "Guest Visitor"%></p>
<p class="mb-2"><strong>Name:</strong> <%=settingsUser != null ? settingsUser.getName() : "Sign in to personalize your experience"%></p>
<p class="mb-0"><strong>Email:</strong> <%=settingsUser != null ? settingsUser.getEmail() : "Not available"%></p>
</div>
</div>
</div>
<div class="col-lg-8 mb-4">
<div class="card settings-card h-100">
<div class="card-body p-4">
<h4 class="font-weight-bold mb-3">Store Preferences</h4>
<div class="row">
<div class="col-md-6 mb-3">
<div class="border rounded p-3 h-100">
<h6 class="font-weight-bold">Delivery Preference</h6>
<p class="text-muted mb-0">Free delivery is available across eligible stationery orders.</p>
</div>
</div>
<div class="col-md-6 mb-3">
<div class="border rounded p-3 h-100">
<h6 class="font-weight-bold">Payment Preference</h6>
<p class="text-muted mb-0">Use Cash on Delivery or dummy card entry at checkout.</p>
</div>
</div>
<div class="col-md-6 mb-3">
<div class="border rounded p-3 h-100">
<h6 class="font-weight-bold">Support Preference</h6>
<p class="text-muted mb-0">Reach support by email or phone from the Contact Us page.</p>
</div>
</div>
<div class="col-md-6 mb-3">
<div class="border rounded p-3 h-100">
<h6 class="font-weight-bold">Shopping Preference</h6>
<p class="text-muted mb-0">Use Latest Items and Upcoming Items to browse the full catalogue.</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
