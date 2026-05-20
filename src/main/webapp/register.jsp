<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration</title>

<%@include file="all_component/allCSS.jsp" %>

</head>

<body style="background-color:#f0f1f2">

<%@include file="all_component/navbar.jsp" %>

<div class="container p-2">
    <div class="row">
        <div class="col-md-4 offset-md-4 ">
            <div class="card">
                <div class="card-body">
                <%
String succMsg=(String)session.getAttribute("succMsg");
if(succMsg!=null){
%>

<p class="text-center text-success"><%=succMsg %></p>

<%
session.removeAttribute("succMsg");
}
%>

<%
String failedMsg=(String)session.getAttribute("failedMsg");
if(failedMsg!=null){
%>

<p class="text-center text-danger"><%=failedMsg %></p>

<%
session.removeAttribute("failedMsg");
}
%>
                <h4 class="text-center">Registration Page</h4>
<form action="register" method="post">
  <div class="form-group">
    <label for="registerName">Enter Full Name:</label>
    <input type="text" class="form-control" id="registerName" aria-describedby="emailHelp"
    required="required" name="fname">


  </div>
  <div class="form-group">
    <label for="registerPhone">Phone no. (optional)</label>
    <input type="tel" class="form-control" id="registerPhone" aria-describedby="phoneHelp"
    name="phno" placeholder="+91 98765 43210"
    pattern="(?:\+91\s?)?[6-9][0-9]{4}\s?[0-9]{5}"
    title="Enter a valid Indian phone number such as +91 98765 43210"
    maxlength="15" onblur="formatIndianPhoneNumber(this)">
    <small id="phoneHelp" class="form-text text-muted">Leave this blank if you do not want to add a phone number right now. OTP will be sent to your email after these details are submitted.</small>

  </div>
  <div class="form-group">
    <label for="registerEmail">Email Address</label>
    <input type="email" class="form-control" id="registerEmail" aria-describedby="emailHelp" required="required" name="email" >

  </div>
  <div class="form-group">
    <label for="registerPassword">Password</label>
    <input type="password" class="form-control" id="registerPassword" required="required" name="password" >
  </div>
  <div class="form-check">
    <input type="checkbox" class="form-check-input" id="exampleCheck1" required="required" name="check">
    <label class="form-check-label" for="exampleCheck1">Agree Terms & Conditions</label>
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
function formatIndianPhoneNumber(input){
    if(!input){
        return;
    }

    var digits = input.value.replace(/\D/g, "");
    if(digits.length === 12 && digits.indexOf("91") === 0){
        digits = digits.substring(2);
    }

    if(digits.length === 10){
        input.value = "+91 " + digits.substring(0, 5) + " " + digits.substring(5);
    }
}
</script>
<%@include file="all_component/footer.jsp" %>
</body>
</html>
