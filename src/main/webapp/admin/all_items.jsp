<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: All Items</title>

<%@include file="allCSS.jsp"%>

</head>
<body>

<%@include file="navbar.jsp"%>

<div class="container mt-4">

<h2 class="text-center mb-4">Admin : All Items</h2>

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

<table class="table table-striped table-bordered">

  <thead class="bg-primary text-white">

    <tr>
      <th scope="col">Id</th>
      <th scope="col">Image</th>
      <th scope="col">Item Name</th>
      <th scope="col">Item Quantity</th>
      <th scope="col">Price</th>
      <th scope="col">Category</th>
      <th scope="col">Item Status</th>
      <th scope="col">Action</th>
    </tr>

  </thead>

  <tbody>

<%

ItemDAOImpl dao =
new ItemDAOImpl(DBConnect.getConn());

List<itemdtls> list =
dao.getAllItems();

for(itemdtls i : list){

%>

<tr>

<td><%=i.getItem_id()%></td>

<td class="text-center align-middle">

    <img src="../recent/<%=i.getPhotoname()%>"
    
         style="
         width:160px;
         height:120px;
         object-fit:cover;
         border-radius:12px;
         border:3px solid #dee2e6;
         padding:4px;
         background:transparent;
         box-shadow:0px 4px 10px rgba(0,0,0,0.15);
         transition:0.3s;
         ">

</td>

<td><%=i.getItem_name()%></td>

<td><%=i.getItem_quantity()%></td>

<td><%=i.getPrice()%></td>

<td><%=i.getCategory()%></td>

<td><%=i.getItem_status()%></td>

<td>

<a href="edit_items.jsp?id=<%=i.getItem_id()%>"
class="btn btn-sm btn-primary">

Edit

</a>

<a href="../delete?id=<%=i.getItem_id() %>"
class="btn btn-sm btn-danger">

Delete

</a>

</td>

</tr>

<%

}

%>

  </tbody>

</table>

</div>

<div style="margin-top:170px;">
<%@include file="footer.jsp"%>
</div>

</body>
</html>
