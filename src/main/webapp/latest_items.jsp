<%@page import="java.util.List"%>
<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="all_component/item_helpers.jsp" %>
<%
ItemDAOImpl dao = new ItemDAOImpl(DBConnect.getConn());
List<itemdtls> itemList = dao.getLatestItems(12);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Latest Items</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background-color:#f7f7f7;}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>
<div class="container py-5">
<div class="text-center mb-4">
<h2 class="font-weight-bold text-dark">Latest Items</h2>
<p class="text-muted mb-0">Fresh additions from the admin panel, shown newest first.</p>
</div>

<% if(itemList.isEmpty()){ %>
<div class="card item-card">
<div class="card-body text-center p-5">
<h5>No latest items are available yet.</h5>
</div>
</div>
<% } else { %>
<div class="row">
<% for(itemdtls item : itemList){ boolean available = isItemAvailable(item); %>
<div class="col-lg-3 col-md-6 mb-4">
<div class="card store-item-card h-100">
<div class="card-body">
<img alt="<%=item.getItem_name()%>" src="<%=resolveImagePath(application, item.getPhotoname())%>" class="store-item-img mb-3">
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
<% } %>
</div>
<% } %>
</div>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
