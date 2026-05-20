<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.User"%>
<%@page import="com.entity.itemdtls"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="all_component/item_helpers.jsp" %>

<%
int id = 0;
try{
	id = Integer.parseInt(request.getParameter("id"));
} catch(Exception e){
	response.sendRedirect("index.jsp");
	return;
}

ItemDAOImpl dao = new ItemDAOImpl(DBConnect.getConn());

itemdtls b = dao.getItemById(id);

if(b == null){
	response.sendRedirect("index.jsp");
	return;
}

User loginUser = (User)session.getAttribute("userobj");
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

<%
String succMsg = (String)session.getAttribute("succMsg");
String failedMsg = (String)session.getAttribute("failedMsg");

if(succMsg != null){
%>
<div class="alert alert-success text-center" role="alert">
<%=succMsg%>
</div>
<%
session.removeAttribute("succMsg");
}

if(failedMsg != null){
%>
<div class="alert alert-danger text-center" role="alert">
<%=failedMsg%>
</div>
<%
session.removeAttribute("failedMsg");
}
%>

<div class="row">

<div class="col-md-6 text-center p-5 border bg-white">

<img src="<%=resolveImagePath(application, b.getPhotoname())%>"
style="height:220px;width:220px;object-fit:cover;"><br>

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
Items Available In Stock :
<%=b.getItem_quantity()%>
</p>

<p>
Single Item Price :
<span class="text-danger font-weight-bold">
&#8377; <%=formatPrice(b.getPrice())%>
</span>
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

<form action="cart" method="get" class="form-inline justify-content-center">
<input type="hidden" name="iid" value="<%=b.getItem_id()%>">

<label class="mr-2" for="quantity">Items</label>
<input type="number" id="quantity" name="quantity"
class="form-control mr-2" style="width:100px;"
min="1" max="<%=b.getItem_quantity()%>" value="1"
<%=b.getItem_quantity() <= 0 ? "disabled" : ""%>>

<% if(loginUser == null){ %>
<a href="login.jsp" class="btn btn-warning mr-2">
<i class="fas fa-right-to-bracket"></i>
Login To Buy
</a>
<% } else { %>
<button type="submit"
class="btn btn-danger mr-2"
<%=b.getItem_quantity() <= 0 ? "disabled" : ""%>>

<i class="fas fa-cart-plus"></i>
Add to Cart
</button>
<% } %>

<span class="btn btn-success">
&#8377; <%=formatPrice(b.getPrice())%>
</span>
</form>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>
