<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Admin: Add Items</title>

<%@include file="allCSS.jsp"%>

<style type="text/css">

body{
    background-color:#f0f1f2;
}

.main-card{
    border-radius:15px;
    box-shadow:0 0 15px rgba(0,0,0,0.2);
    padding:20px;
    margin-top:40px;
    margin-bottom:40px;
}

.card-title{
    font-weight:bold;
    color:#0d6efd;
    margin-bottom:25px;
}

.form-group{
    margin-bottom:18px;
}

.form-control{
    border-radius:8px;
}

.btn-custom{
    padding:8px 30px;
    border-radius:8px;
}

</style>

</head>

<body>

<%@include file="navbar.jsp"%>

<div class="container">

    <div class="row">

        <div class="col-md-6 offset-md-3">

            <div class="card main-card">

                <div class="card-body">

<%
String succMsg = (String)session.getAttribute("succMsg");

if(succMsg != null){
%>

<div class="alert alert-success text-center">

<%= succMsg %>

</div>

<%
session.removeAttribute("succMsg");
}
%>

<%
String failedMsg = (String)session.getAttribute("failedMsg");

if(failedMsg != null){
%>

<div class="alert alert-danger text-center">

<%= failedMsg %>

</div>

<%
session.removeAttribute("failedMsg");
}
%>

<h3 class="text-center card-title">
    Add Items
</h3>

                    <form action="../add_items"
                          method="post"
                          enctype="multipart/form-data">

                        <div class="form-group">

                            <label>
                                Item Name
                            </label>

                            <input type="text"
                                   name="itemname"
                                   class="form-control"
                                   required="required">

                        </div>

                        <div class="form-group">

                            <label>
                                Item Quantity
                            </label>

                            <input type="number"
                                   name="quantity"
                                   class="form-control"
                                   required="required">

                        </div>

                        <div class="form-group">

                            <label>
                                Price
                            </label>

                            <input type="number"
                                   name="price"
                                   class="form-control"
                                   required="required">

                        </div>

                        <div class="form-group">

                            <label>
                                Category
                            </label>

                            <select name="category"
                                    class="form-control">

                                <option value="">
                                    --Select Category--
                                </option>

                                <option value="NEW">
                                    NEW
                                </option>

                                <option value="Old">
                                    OLD
                                </option>
                                
                                <option value="Back in Stock">
                                    Back in Stock
                                </option>

                                

                            </select>

                        </div>

                        

                        <div class="form-group">

                            <label>
                                Item Status
                            </label>

                            <select name="status"
                                    class="form-control">

                                <option value="Available">
                                    Available
                                </option>

                                <option value="Not Available">
                                    Not Available
                                </option>

                            </select>

                        </div>

                        <div class="form-group">

                            <label>
                                Upload Item Photo
                            </label>

                            <input type="file"
                                   name="photo"
                                   class="form-control-file">

                        </div>

                        <div class="text-center mt-4">

                            <button type="submit"
                                    class="btn btn-primary btn-custom">

                                Add Item

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