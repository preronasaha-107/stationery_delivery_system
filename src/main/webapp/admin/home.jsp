<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin:Home</title
>
<%@include file="allCSS.jsp" %>

<style type="text/css">

a{
    text-decoration:none;
    color:black;
}

a:hover{
    text-decoration:none;
    color:blue;
}

</style>
</head>
<body>

<%@include file="navbar.jsp" %>
<div class="container">
    <div class="row p-5">
        <div class="col-md-4">
        <a href="add_items.jsp">
            <div class="card">
                <div class="card-body text-center">
                    <i class="fas fa-plus-square fa-3x text-primary"></i>
                    <h4>ADD Items</h4>
                    ------------------
                </div>
            </div>
          </a>
        </div>
        
        <div class="col-md-4">
        <a href="all_items.jsp">
            <div class="card">
                <div class="card-body text-center">
                   <i class="fa-solid fa-store fa-3x text-danger"></i>
                    <h4>ALL Items</h4>
                    ------------------
                </div>
            </div>
           </a>
        </div>
        <div class="col-md-4">
        <a href="orders.jsp">
            <div class="card">
                <div class="card-body text-center">
                    <i class="fa-solid fa-bag-shopping fa-3x text-warning"></i>
                    <h4>Orders</h4>
                    ------------------
                </div>
            </div>
            </a>
        </div>
       
    </div>
</div>
<div style="margin-top:190px;">
<%@include file="footer.jsp"%>
</div>
</body>
</html>