<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{
	background-color:#f5f1ea;
}
.login-shell{
	min-height:calc(100vh - 180px);
}
.login-card{
	border:1px solid #d9d0c2;
	border-radius:16px;
	box-shadow:0 18px 40px rgba(64,42,16,0.08);
}
.login-title{
	font-size:2rem;
	font-weight:700;
	color:#2f2418;
}
.login-subtitle{
	color:#6a5b4a;
}
.login-label{
	font-weight:600;
	color:#3c2e20;
}
.login-input{
	height:48px;
	border-radius:12px;
	border:1px solid #cfbea8;
}
.login-input:focus{
	border-color:#8b5e34;
	box-shadow:0 0 0 0.15rem rgba(139,94,52,0.15);
}
.login-btn{
	background-color:#8b5e34;
	border-color:#8b5e34;
	border-radius:12px;
	padding:0.75rem 1rem;
	font-weight:600;
}
.login-btn:hover,
.login-btn:focus{
	background-color:#6f4825;
	border-color:#6f4825;
}
.register-link{
	color:#8b5e34;
	font-weight:600;
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	<div class="container py-4 login-shell d-flex align-items-center">
		<div class="row justify-content-center w-100">
			<div class="col-lg-5 col-md-7">
				<div class="card login-card">
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

						<h1 class="text-center login-title mb-2">Welcome back</h1>
						<p class="text-center login-subtitle mb-4">Sign in to continue shopping. We will email you a one-time OTP after password verification.</p>
						<form action="login" method="post">
							<div class="form-group">
								<label for="loginEmail" class="login-label">Email address</label>
								<input type="email" class="form-control login-input" id="loginEmail"
									required="required" name="email" placeholder="Enter your email">
							</div>
							<div class="form-group mb-4">
								<label for="loginPassword" class="login-label">Password</label>
								<input type="password" class="form-control login-input" id="loginPassword"
									required="required" name="password" placeholder="Enter your password">
							</div>
							<button type="submit" class="btn btn-primary btn-block login-btn">Login</button>
							<p class="text-center mb-0 mt-4">
								<a href="register.jsp" class="register-link">Create Account</a>
							</p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
