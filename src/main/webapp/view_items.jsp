<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int id = Integer.parseInt(request.getParameter("id"));

ItemDAOImpl dao = new ItemDAOImpl(DBConnect.getConn());

itemdtls b = dao.getItemById(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Item</title>

<%@include file="all_component/allCSS.jsp"%>

<style>
.card-sh{
box-shadow:0 0 8px 0 rgba(0,0,0,0.3);
}
</style>

</head>

<body style="background-color:#f0f1f2;">

<%@include file="all_component/navbar.jsp"%>

<div class="container p-5">

<div class="row">

<div class="col-md-6 text-center p-5 border bg-white">

<img src="recent/<%=b.getPhotoname()%>"
style="height:220px;width:220px"><br>

<h4 class="mt-3">
Item Name :
<span class="text-success">
<%=b.getItem_name()%>
</span>
</h4>

<h4>
Category :
<span class="text-primary">
<%=b.getCategory()%>
</span>
</h4>

<h4>
Status :
<span class="text-success">
<%=b.getItem_status()%>
</span>
</h4>

</div>

<div class="col-md-6">

<div class="card card-sh">

<div class="card-body">

<h2 class="text-center text-success">
<%=b.getItem_name()%>
</h2>

<p>
This stationery item is available in excellent quality.
</p>

<p>
Quantity :
<%=b.getItem_quantity()%>
</p>

<div class="row">

<div class="col-md-4 text-danger text-center p-2">
<i class="fas fa-money-bill-wave fa-2x"></i>
<p>Cash On Delivery</p>
</div>

<div class="col-md-4 text-danger text-center p-2">
<i class="fas fa-undo-alt fa-2x"></i>
<p>Return Available</p>
</div>

<div class="col-md-4 text-danger text-center p-2">
<i class="fas fa-truck-moving fa-2x"></i>
<p>Free Delivery</p>
</div>

</div>

<div class="text-center p-3">

<a href="cart?iid=<%=b.getItem_id()%>&uid=1"
class="btn btn-danger">

<i class="fas fa-cart-plus"></i>
Add Cart
</a>

<a href=""
class="btn btn-success">

&#8377; <%=b.getPrice()%>

</a>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>