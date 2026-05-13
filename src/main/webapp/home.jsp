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
body{
	background-color:#f6f3ee;
}
.home-wrap{
	padding-top:2rem;
	padding-bottom:2rem;
}
.hero-card,
.panel-card{
	border:1px solid #ddd3c6;
	border-radius:16px;
	background-color:#fffdf9;
	box-shadow:0 10px 30px rgba(64,42,16,0.06);
}
.hero-title{
	font-size:2rem;
	font-weight:700;
	color:#2f2418;
}
.hero-copy,
.muted-copy{
	color:#6a5b4a;
}
.label-text{
	font-size:0.85rem;
	letter-spacing:0.04em;
	text-transform:uppercase;
	color:#8b7760;
}
.value-text{
	font-size:1.05rem;
	font-weight:600;
	color:#312418;
}
.section-title{
	font-size:1.1rem;
	font-weight:700;
	color:#312418;
}
.simple-btn{
	border-radius:12px;
	font-weight:600;
	padding:0.75rem 1rem;
}
.primary-btn{
	background-color:#8b5e34;
	border-color:#8b5e34;
	color:#ffffff;
}
.primary-btn:hover,
.primary-btn:focus{
	background-color:#6f4825;
	border-color:#6f4825;
	color:#ffffff;
}
.outline-btn{
	border-color:#c9b7a0;
	color:#6f4825;
}
.outline-btn:hover,
.outline-btn:focus{
	background-color:#f2e8da;
	border-color:#c9b7a0;
	color:#5b391b;
}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>

<div class="container home-wrap">
<%
String succMsg=(String)session.getAttribute("succMsg");
if(succMsg!=null){
%>
<div class="alert alert-success text-center"><%=succMsg%></div>
<%
session.removeAttribute("succMsg");
}
%>

<div class="card hero-card mb-4">
	<div class="card-body p-4 p-md-5">
		<div class="row align-items-center">
			<div class="col-lg-8 mb-4 mb-lg-0">
				<p class="label-text mb-2">Account</p>
				<h1 class="hero-title mb-3">Hi, <%=homeUser.getName()%></h1>
				<p class="hero-copy mb-0">Your account is ready. You can continue shopping, check your cart, or manage your details from here.</p>
			</div>
			<div class="col-lg-4">
				<a href="latest_items.jsp" class="btn primary-btn simple-btn btn-block mb-3">Browse items</a>
				<a href="cart.jsp?uid=<%=homeUser.getId()%>" class="btn outline-btn simple-btn btn-block">View cart</a>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-6 mb-4">
		<div class="card panel-card h-100">
			<div class="card-body p-4">
				<h2 class="section-title mb-4">Your details</h2>
				<p class="label-text mb-1">Email</p>
				<p class="value-text mb-4"><%=homeUser.getEmail()%></p>
				<p class="label-text mb-1">Phone</p>
				<p class="value-text mb-0"><%=homeUser.getPhno()%></p>
			</div>
		</div>
	</div>
	<div class="col-md-6 mb-4">
		<div class="card panel-card h-100">
			<div class="card-body p-4">
				<h2 class="section-title mb-3">Need anything else?</h2>
				<p class="muted-copy mb-4">Use the quick links below if you want to ask a question or review your account options.</p>
				<a href="contact.jsp" class="btn outline-btn simple-btn btn-block mb-3">Contact support</a>
				<a href="settings.jsp" class="btn outline-btn simple-btn btn-block">Open settings</a>
			</div>
		</div>
	</div>
</div>
</div>

<%@include file="all_component/footer.jsp"%>
</body>
</html>
