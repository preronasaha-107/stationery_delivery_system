<%@page import="com.util.OtpUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String otpPurpose = (String)session.getAttribute(OtpUtil.SESSION_OTP_PURPOSE);
String otpEmail = (String)session.getAttribute(OtpUtil.SESSION_OTP_EMAIL);

if(otpPurpose == null || otpEmail == null){
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify OTP</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{
    background-color:#f5f1ea;
}
.otp-shell{
    min-height:calc(100vh - 180px);
}
.otp-card{
    border:1px solid #d9d0c2;
    border-radius:16px;
    box-shadow:0 18px 40px rgba(64,42,16,0.08);
}
.otp-title{
    font-size:2rem;
    font-weight:700;
    color:#2f2418;
}
.otp-subtitle{
    color:#6a5b4a;
}
.otp-input{
    height:52px;
    border-radius:12px;
    border:1px solid #cfbea8;
    letter-spacing:8px;
    text-align:center;
    font-size:1.4rem;
    font-weight:700;
}
.otp-input:focus{
    border-color:#8b5e34;
    box-shadow:0 0 0 0.15rem rgba(139,94,52,0.15);
}
.otp-btn{
    background-color:#8b5e34;
    border-color:#8b5e34;
    border-radius:12px;
    padding:0.75rem 1rem;
    font-weight:600;
}
.otp-btn:hover,
.otp-btn:focus{
    background-color:#6f4825;
    border-color:#6f4825;
}
.otp-link-btn{
    border:none;
    background:none;
    color:#8b5e34;
    font-weight:600;
    padding:0;
}
</style>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>
<div class="container py-4 otp-shell d-flex align-items-center">
    <div class="row justify-content-center w-100">
        <div class="col-lg-5 col-md-7">
            <div class="card otp-card">
                <div class="card-body p-4 p-md-5">
<%
String failedMsg=(String)session.getAttribute("failedMsg");
String succMsg=(String)session.getAttribute("succMsg");

if(failedMsg!=null){
%>
<div class="alert alert-danger text-center" role="alert">
<%= failedMsg %>
</div>
<%
session.removeAttribute("failedMsg");
}

if(succMsg!=null){
%>
<div class="alert alert-success text-center" role="alert">
<%= succMsg %>
</div>
<%
session.removeAttribute("succMsg");
}
%>
                    <h1 class="text-center otp-title mb-2">Verify OTP</h1>
                    <p class="text-center otp-subtitle mb-4">
                        Enter the 6-digit code sent to <strong><%=OtpUtil.maskEmail(otpEmail)%></strong>
                        to complete your <%=otpPurpose%>.
                    </p>
                    <form action="verify_otp" method="post">
                        <div class="form-group mb-4">
                            <label for="otpCode">One-Time Password</label>
                            <input type="text" class="form-control otp-input" id="otpCode" name="otp"
                                maxlength="6" pattern="[0-9]{6}" inputmode="numeric"
                                placeholder="123456" required="required">
                        </div>
                        <button type="submit" class="btn btn-primary btn-block otp-btn">Verify OTP</button>
                    </form>
                    <form action="resend_otp" method="post" class="text-center mt-4">
                        <button type="submit" class="otp-link-btn">Resend OTP</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
