<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.DAO.ItemDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.itemdtls"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: Edit Item</title>

<%@include file="allCSS.jsp"%>

<style>

body{
    background-color:#f0f1f2;
}

.main-card{
    border-radius:15px;
    box-shadow:0 0 15px rgba(0,0,0,0.2);
    padding:20px;
    margin-top:40px;
}

</style>

</head>

<body>

<%@include file="navbar.jsp"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    ItemDAOImpl dao = new ItemDAOImpl(DBConnect.getConn());
    itemdtls b = dao.getItemById(id);
%>

<div class="container">

<div class="row">

<div class="col-md-6 offset-md-3">

<div class="card main-card">

<div class="card-body">

<h3 class="text-center text-primary mb-4">
    Edit Item
</h3>

<!-- IMPORTANT: matches your servlet "/edit_items" -->
<form action="../edit_items"
      method="post">

    <!-- ID -->
    <input type="hidden"
           name="id"
           value="<%=b.getItem_id()%>">

    <!-- Item Name -->
    <div class="form-group">
        <label>Item Name</label>
        <input type="text"
               name="itemname"
               class="form-control"
               value="<%=b.getItem_name()%>">
    </div>

    <!-- Quantity -->
    <div class="form-group">
        <label>Item Quantity</label>
        <input type="number"
               name="quantity"
               class="form-control"
               value="<%=b.getItem_quantity()%>">
    </div>

    <!-- Price -->
    <div class="form-group">
        <label>Price</label>
        <input type="text"
               name="price"
               class="form-control"
               value="<%=b.getPrice()%>">
    </div>

    <!-- Category -->
    <div class="form-group">
        <label>Category</label>

        <select name="category" class="form-control">

            <option value="<%=b.getCategory()%>">
                <%=b.getCategory()%>
            </option>

            <option value="NEW">NEW</option>
            <option value="Old">OLD</option>
            <option value="Back in Stock">Back in Stock</option>

        </select>

    </div>

    <!-- Status -->
    <div class="form-group">
        <label>Status</label>

        <select name="status" class="form-control">

            <option value="<%=b.getItem_status()%>">
                <%=b.getItem_status()%>
            </option>

            <option value="Available">Available</option>
            <option value="Not Available">Not Available</option>

        </select>

    </div>

   
    <!-- NOTE: no file upload here because your servlet does NOT handle image update -->

    <div class="text-center mt-3">

        <button type="submit"
                class="btn btn-primary">
            Update Item
        </button>

    </div>

</form>

</div>

</div>

</div>

</div>

</div>

<div style="margin-top:100px;">
<%@include file="footer.jsp"%>
</div>

</body>
</html>