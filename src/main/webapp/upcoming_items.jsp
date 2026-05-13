<%@page import="java.util.List"%>
<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="all_component/item_helpers.jsp" %>
<%
ItemDAOImpl dao = new ItemDAOImpl(DBConnect.getConn());
List<itemdtls> itemList = dao.getItemsByStatus("Not Available");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upcoming Items</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background:#f7f9fc;}
.item-card{border:none;border-radius:16px;box-shadow:0 12px 32px rgba(15,23,42,0.08);}
.item-img{width:100%;height:220px;object-fit:cover;border-radius:12px;background:#eef2f7;}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>
<div class="container py-5">
<div class="text-center mb-5">
<h2 class="font-weight-bold text-dark">Upcoming Items</h2>
<p class="text-muted mb-0">Products marked not available right now, but expected to arrive soon.</p>
</div>

<% if(itemList.isEmpty()){ %>
<div class="card item-card">
<div class="card-body text-center p-5">
<h5>No upcoming items are listed right now.</h5>
</div>
</div>
<% } else { %>
<div class="row">
<% for(itemdtls item : itemList){ %>
<div class="col-lg-3 col-md-6 mb-4">
<div class="card item-card h-100">
<div class="card-body">
<img alt="<%=item.getItem_name()%>" src="<%=resolveImagePath(application, item.getPhotoname())%>" class="item-img mb-3">
<h5><%=item.getItem_name()%></h5>
<p class="text-muted mb-1">Category: <%=item.getCategory()%></p>
<p class="text-muted mb-3">Status: <%=item.getItem_status()%></p>
<div class="d-flex justify-content-between align-items-center">
<strong class="text-danger">&#8377; <%=item.getPrice()%></strong>
<a href="view_items.jsp?id=<%=item.getItem_id()%>" class="btn btn-sm btn-success">View Details</a>
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
