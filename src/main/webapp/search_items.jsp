<%@page import="java.util.List"%>
<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="all_component/item_helpers.jsp" %>

<%
String query = request.getParameter("query");
if(query == null){
	query = "";
}
query = query.trim();
String displayQuery = query
		.replace("&", "&amp;")
		.replace("\"", "&quot;")
		.replace("<", "&lt;")
		.replace(">", "&gt;");

ItemDAOImpl dao = new ItemDAOImpl(DBConnect.getConn());
List<itemdtls> itemList = query.isEmpty() ? dao.getDistinctCatalogItems() : dao.searchItems(query);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Items</title>
<%@include file="all_component/allCSS.jsp"%>
<style type="text/css">
.crd-ho:hover{
background-color:#fcf7f7;
}
</style>
</head>
<body style="background-color:#f7f7f7;">

<%@include file="all_component/navbar.jsp"%>

<div class="container p-4">

<h3 class="text-center mb-4">
<%=query.isEmpty() ? "All Items" : "Search Results"%>
<% if(!query.isEmpty()){ %>
for "<%=displayQuery%>"
<% } %>
</h3>

<%
if(itemList.isEmpty()){
%>
<div class="card">
<div class="card-body text-center p-5">
<h5>No items found.</h5>
<a href="index.jsp" class="btn btn-primary mt-2">Back To Home</a>
</div>
</div>
<%
} else {
%>
<div class="row">
<%
for(itemdtls i : itemList){
	boolean inStock = i.getItem_quantity() > 0
			&& "Available".equalsIgnoreCase(i.getItem_status());
%>
<div class="col-md-3 mb-4">
<div class="card store-item-card crd-ho h-100">
<div class="card-body">
<img alt="<%=i.getItem_name()%>" src="<%=resolveImagePath(application, i.getPhotoname())%>"
class="store-item-img mb-3">
<p class="store-item-title"><%=i.getItem_name()%></p>
<p class="store-item-summary">Category: <%=i.getCategory()%></p>
<p class="store-item-summary">Status: <%=i.getItem_status()%></p>
<p class="store-item-summary">In Stock: <%=i.getItem_quantity()%></p>
<div class="store-item-footer">
<div class="store-item-actions">
<span class="store-item-price">&#8377; <%=formatPrice(i.getPrice())%></span>
<div class="store-item-button-group">
<% if(inStock){ %>
<a href="view_items.jsp?id=<%=i.getItem_id()%>"
class="btn btn-danger btn-sm">
Add to Cart
</a>
<% } else { %>
<span class="btn btn-secondary btn-sm disabled">Unavailable</span>
<% } %>
<a href="view_items.jsp?id=<%=i.getItem_id()%>"
class="btn btn-success btn-sm">
View Details
</a>
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

<%@include file="all_component/footer.jsp"%>
</body>
</html>
