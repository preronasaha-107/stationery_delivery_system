<%@page import="java.util.List"%>
<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
ItemDAOImpl dao = new ItemDAOImpl(DBConnect.getConn());
List<itemdtls> latestItems = dao.getLatestItems(3);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stationery Delivery System</title>
<%@include file="all_component/allCSS.jsp" %>
<style type="text/css">
.back-img{
background:url("img/j.jpg");
height:80vh;
width:100%;
background-repeat:no-repeat;
background-size:cover;
}
.crd-ho:hover{
background-color:#fcf7f7;
}
.item-img{
width:180px;
height:180px;
object-fit:cover;
}
</style>
</head>
<body style="background-color:#f7f7f7;">

<%@include file="all_component/navbar.jsp" %>

<div class="container-fluid back-img">
<h1 class="text-center text-blue">Stationery Delivery System</h1>
</div>

<div class="container py-4" style="background-color:#f7f7f7;">

<h3 class="text-center mb-4">Latest Items</h3>

<%
if(latestItems.isEmpty()){
%>
<div class="card">
<div class="card-body text-center p-5">
<h5>No items have been added yet.</h5>
</div>
</div>
<%
} else {
%>
<div class="row justify-content-center">
<%
for(itemdtls i : latestItems){
    boolean inStock = i.getItem_quantity() > 0
            && "Available".equalsIgnoreCase(i.getItem_status());
%>
<div class="col-md-4 mb-4">
<div class="card crd-ho h-100">
<div class="card-body text-center">
<img alt="<%=i.getItem_name()%>" src="recent/<%=i.getPhotoname()%>"
class="img-thumblin item-img">
<p class="mt-2 mb-1"><%=i.getItem_name()%></p>
<p class="mb-1">Category: <%=i.getCategory()%></p>
<p class="mb-3">Status: <%=i.getItem_status()%></p>

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

<div class="text-center mt-1">
<a href="search_items.jsp" class="btn btn-danger btn-sm text-white">View All</a>
</div>

</div>

<%@include file="all_component/footer.jsp" %>
</body>
</html>
