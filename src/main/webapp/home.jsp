<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
User homeUser = (User)session.getAttribute("userobj");
if(homeUser == null){
    session.setAttribute("failedMsg", "Please login to continue.");
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Home</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background-color:#f0f1f2;}
.info-card{border:1px solid #dee2e6;}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>

<div class="container py-4">
<%
String succMsg=(String)session.getAttribute("succMsg");
if(succMsg!=null){
%>
<div class="alert alert-success text-center"><%=succMsg%></div>
<%
session.removeAttribute("succMsg");
}
%>

<div class="card mb-4">
    <div class="card-body">
        <h3 class="mb-2">Welcome, <%=homeUser.getName()%></h3>
        <p class="text-muted mb-0">Your account is signed in successfully. You can continue shopping, review your cart, or browse the latest items.</p>
    </div>
</div>

<div class="row">
    <div class="col-md-4 mb-4">
        <div class="card info-card h-100">
            <div class="card-body">
                <h4>My Profile</h4>
                <p class="text-muted mb-2">Email: <%=homeUser.getEmail()%></p>
                <p class="text-muted mb-0">Phone: <%=homeUser.getPhno()%></p>
            </div>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card info-card h-100">
            <div class="card-body">
                <h4>Quick Actions</h4>
                <a href="latest_items.jsp" class="btn btn-primary btn-block mt-3">Browse Latest Items</a>
                <a href="cart.jsp" class="btn btn-outline-primary btn-block">Open Cart</a>
            </div>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card info-card h-100">
            <div class="card-body">
                <h4>Support</h4>
                <p class="text-muted">Need help with an order or item availability?</p>
                <a href="contact.jsp" class="btn btn-outline-secondary btn-block">Contact Us</a>
            </div>
        </div>
    </div>
</div>
</div>

<%@include file="all_component/footer.jsp"%>
</body>
</html>
