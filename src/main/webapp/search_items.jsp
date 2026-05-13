<%@page import="java.util.List"%>
<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
List<itemdtls> itemList = query.isEmpty() ? dao.getAllItems() : dao.searchItems(query);
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
<div class="card crd-ho h-100">
<div class="card-body text-center">
<img alt="<%=i.getItem_name()%>" src="recent/<%=i.getPhotoname()%>"
style="width:180px;height:180px" class="img-thumblin">
<p class="mt-2 mb-1"><%=i.getItem_name()%></p>
<p class="mb-1">Category: <%=i.getCategory()%></p>
<p class="mb-1">Status: <%=i.getItem_status()%></p>
<p class="mb-3">In Stock: <%=i.getItem_quantity()%></p>

<% if(inStock){ %>
<a href="view_items.jsp?id=<%=i.getItem_id()%>"
class="btn btn-danger btn-sm ml-1">
Add Cart
</a>
<% } else { %>
<span class="btn btn-secondary btn-sm ml-1 disabled">Unavailable</span>
<% } %>
<a href="view_items.jsp?id=<%=i.getItem_id()%>"
class="btn btn-success btn-sm ml-1">
View Details
</a>
<span class="btn btn-danger btn-sm ml-1">
&#8377; <%=i.getPrice()%>
</span>
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
