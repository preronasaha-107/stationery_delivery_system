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
.item-card{border:1px solid #dee2e6;}
.item-img{width:100%;height:220px;object-fit:cover;background:#f8f9fa;}
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
<div class="card item-card h-100">
<div class="card-body">
<img alt="<%=item.getItem_name()%>" src="<%=resolveImagePath(application, item.getPhotoname())%>" class="item-img mb-3">
<h5><%=item.getItem_name()%></h5>
<p class="text-muted mb-1">Category: <%=item.getCategory()%></p>
<p class="text-muted mb-3">Status: <%=item.getItem_status()%></p>
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
<% } %>
</div>
<% } %>
</div>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
