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
background-color:#f7f7f7;
}
.page-banner{
background-color:#ffffff;
border:1px solid #dee2e6;
}
</style>
</head>
<body>

<%@include file="all_component/navbar.jsp" %>

<div class="container py-4">
<div class="page-banner p-4 mb-4">
<div class="row align-items-center">
<div class="col-md-8">
<h2 class="mb-2">Stationery Delivery System</h2>
<p class="text-muted mb-0">Browse recommended products, check the latest items, and place your order with a simple checkout flow.</p>
</div>
<div class="col-md-4 text-md-right mt-3 mt-md-0">
<a href="latest_items.jsp" class="btn btn-primary mr-2">Latest Items</a>
<a href="upcoming_items.jsp" class="btn btn-outline-secondary">Upcoming</a>
</div>
</div>
</div>

<div class="d-flex justify-content-between align-items-center mb-3">
<div>
<h3 class="mb-1">Recommended For You</h3>
<p class="text-muted mb-0">Available items with the highest stock.</p>
</div>
<a href="search_items.jsp" class="btn btn-outline-primary btn-sm">Browse All</a>
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
<div class="card store-item-card h-100">
<div class="card-body">
<div class="store-item-media">
<img alt="<%=item.getItem_name()%>" src="<%=resolveImagePath(application, item.getPhotoname())%>" class="store-item-img">
</div>
<p class="store-item-title"><%=item.getItem_name()%></p>
<p class="store-item-summary">Category: <%=item.getCategory()%></p>
<p class="store-item-summary">Stock: <%=item.getItem_quantity()%> item(s)</p>
<div class="store-item-footer">
<div class="store-item-actions">
<span class="store-item-price">&#8377; <%=formatPrice(item.getPrice())%></span>
<div class="store-item-button-group">
<a href="view_items.jsp?id=<%=item.getItem_id()%>" class="btn btn-sm btn-success">View Details</a>
</div>
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

<div class="d-flex justify-content-between align-items-center mb-3 mt-4">
<div>
<h3 class="mb-1">Latest Items</h3>
<p class="text-muted mb-0">Newest products added by the admin.</p>
</div>
<a href="latest_items.jsp" class="btn btn-outline-primary btn-sm">View Latest Page</a>
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
<div class="card store-item-card h-100">
<div class="card-body">
<div class="store-item-media">
<img alt="<%=item.getItem_name()%>" src="<%=resolveImagePath(application, item.getPhotoname())%>" class="store-item-img">
</div>
<p class="store-item-title"><%=item.getItem_name()%></p>
<p class="store-item-summary">Category: <%=item.getCategory()%></p>
<p class="store-item-summary">Status: <%=item.getItem_status()%></p>
<div class="store-item-footer">
<div class="store-item-actions">
<span class="store-item-price">&#8377; <%=formatPrice(item.getPrice())%></span>
<div class="store-item-button-group">
<% if(available){ %>
<a href="view_items.jsp?id=<%=item.getItem_id()%>" class="btn btn-sm btn-danger">Add to Cart</a>
<% } else { %>
<span class="btn btn-sm btn-secondary disabled">Unavailable</span>
<% } %>
<a href="view_items.jsp?id=<%=item.getItem_id()%>" class="btn btn-sm btn-success">View Details</a>
</div>
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
