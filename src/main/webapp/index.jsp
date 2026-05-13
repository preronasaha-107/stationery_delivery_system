<%@page import="java.util.List"%>
<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="all_component/item_helpers.jsp" %>

<%
ItemDAOImpl dao = new ItemDAOImpl(DBConnect.getConn());
List<itemdtls> recommendedItems = dao.getRecommendedItems(3);
List<itemdtls> latestItems = dao.getLatestItems(3);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stationery Delivery System</title>
<%@include file="all_component/allCSS.jsp" %>
<style type="text/css">
body{
background:#f4f7fb;
}
.hero-wrap{
background:
linear-gradient(120deg, rgba(48,63,159,0.92), rgba(0,150,136,0.88)),
url("img/j.jpg");
background-size:cover;
background-position:center;
color:white;
padding:90px 0 110px;
}
.hero-card{
background:rgba(255,255,255,0.12);
border:1px solid rgba(255,255,255,0.18);
border-radius:14px;
padding:20px;
backdrop-filter:blur(4px);
}
.section-title{
font-weight:700;
color:#243b53;
}
.section-subtitle{
color:#627d98;
}
.item-card{
border:none;
border-radius:16px;
box-shadow:0 10px 30px rgba(15,23,42,0.08);
transition:transform 0.2s ease, box-shadow 0.2s ease;
}
.item-card:hover{
transform:translateY(-4px);
box-shadow:0 16px 36px rgba(15,23,42,0.14);
}
.item-img{
width:100%;
height:220px;
object-fit:cover;
border-radius:12px;
background:#eef2f7;
}
.badge-soft{
display:inline-block;
padding:6px 12px;
border-radius:999px;
background:#eef2ff;
color:#303f9f;
font-size:13px;
font-weight:600;
}
.quick-link{
border-radius:12px;
padding:14px 18px;
background:white;
box-shadow:0 10px 24px rgba(15,23,42,0.06);
}
</style>
</head>
<body>

<%@include file="all_component/navbar.jsp" %>

<div class="hero-wrap">
<div class="container">
<div class="row align-items-center">
<div class="col-lg-7">
<h1 class="display-4 font-weight-bold">Everything your study desk needs, delivered simply.</h1>
<p class="lead mt-3 mb-4">Browse trusted stationery essentials, discover fresh arrivals, and keep your cart ready for a smooth checkout.</p>
<a href="latest_items.jsp" class="btn btn-light btn-lg mr-2">Shop Latest</a>
<a href="upcoming_items.jsp" class="btn btn-outline-light btn-lg">See Upcoming</a>
</div>
<div class="col-lg-5 mt-4 mt-lg-0">
<div class="hero-card">
<h4 class="mb-3">What you can do here</h4>
<div class="row">
<div class="col-sm-6 mb-3">
<div class="quick-link h-100">
<h6 class="mb-1 text-dark">Recommended Picks</h6>
<p class="mb-0 text-muted small">Popular in-stock supplies ready to add.</p>
</div>
</div>
<div class="col-sm-6 mb-3">
<div class="quick-link h-100">
<h6 class="mb-1 text-dark">Latest Items</h6>
<p class="mb-0 text-muted small">Freshly added products from the admin panel.</p>
</div>
</div>
<div class="col-sm-6">
<div class="quick-link h-100">
<h6 class="mb-1 text-dark">Contact Support</h6>
<p class="mb-0 text-muted small">Store hours, email, and delivery help.</p>
</div>
</div>
<div class="col-sm-6">
<div class="quick-link h-100">
<h6 class="mb-1 text-dark">Easy Checkout</h6>
<p class="mb-0 text-muted small">Cash on delivery or dummy card payment flow.</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

<div class="container py-5">

<div class="d-flex justify-content-between align-items-end mb-3">
<div>
<h3 class="section-title mb-1">Recommended For You</h3>
<p class="section-subtitle mb-0">In-stock favourites picked from the most available items.</p>
</div>
<a href="search_items.jsp" class="btn btn-outline-primary">Browse All</a>
</div>

<%
if(recommendedItems.isEmpty()){
%>
<div class="card item-card">
<div class="card-body text-center p-5">
<h5>No recommended items available right now.</h5>
</div>
</div>
<%
} else {
%>
<div class="row">
<%
for(itemdtls item : recommendedItems){
%>
<div class="col-lg-4 col-md-6 mb-4">
<div class="card item-card h-100">
<div class="card-body">
<img alt="<%=item.getItem_name()%>" src="<%=resolveImagePath(application, item.getPhotoname())%>" class="item-img mb-3">
<span class="badge-soft"><%=item.getCategory()%></span>
<h5 class="mt-3 mb-2"><%=item.getItem_name()%></h5>
<p class="text-muted mb-2">Stock: <%=item.getItem_quantity()%> item(s)</p>
<p class="text-muted mb-3">Status: <%=item.getItem_status()%></p>
<div class="d-flex justify-content-between align-items-center">
<strong class="text-danger">&#8377; <%=item.getPrice()%></strong>
<div>
<a href="view_items.jsp?id=<%=item.getItem_id()%>" class="btn btn-sm btn-success">View Details</a>
</div>
</div>
</div>
</div>
</div>
<%
}
%>
</div>
<%
}
%>

<div class="d-flex justify-content-between align-items-end mb-3 mt-4">
<div>
<h3 class="section-title mb-1">Latest Items</h3>
<p class="section-subtitle mb-0">The newest products added by the admin appear here first.</p>
</div>
<a href="latest_items.jsp" class="btn btn-outline-primary">View Latest Page</a>
</div>

<%
if(latestItems.isEmpty()){
%>
<div class="card item-card">
<div class="card-body text-center p-5">
<h5>No items have been added yet.</h5>
</div>
</div>
<%
} else {
%>
<div class="row">
<%
for(itemdtls item : latestItems){
    boolean available = isItemAvailable(item);
%>
<div class="col-lg-4 col-md-6 mb-4">
<div class="card item-card h-100">
<div class="card-body">
<img alt="<%=item.getItem_name()%>" src="<%=resolveImagePath(application, item.getPhotoname())%>" class="item-img mb-3">
<div class="d-flex justify-content-between align-items-center mb-2">
<span class="badge-soft"><%=item.getCategory()%></span>
<span class="text-muted small"><%=item.getItem_status()%></span>
</div>
<h5 class="mb-2"><%=item.getItem_name()%></h5>
<p class="text-muted mb-3">Current stock: <%=item.getItem_quantity()%></p>
<div class="d-flex justify-content-between align-items-center">
<strong class="text-danger">&#8377; <%=item.getPrice()%></strong>
<div>
<% if(available){ %>
<a href="view_items.jsp?id=<%=item.getItem_id()%>" class="btn btn-sm btn-danger mr-1">Add Cart</a>
<% } else { %>
<span class="btn btn-sm btn-secondary mr-1 disabled">Unavailable</span>
<% } %>
<a href="view_items.jsp?id=<%=item.getItem_id()%>" class="btn btn-sm btn-success">View</a>
</div>
</div>
</div>
</div>
</div>
<%
}
%>
</div>
<%
}
%>

</div>

<%@include file="all_component/footer.jsp" %>
</body>
</html>
