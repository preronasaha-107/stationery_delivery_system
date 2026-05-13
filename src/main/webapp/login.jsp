<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background:#f5f7fb;}
.login-card{
	border:none;
	border-radius:18px;
	box-shadow:0 16px 34px rgba(15,23,42,0.08);
}
.login-side{
	background:linear-gradient(135deg, #303f9f, #00897b);
	color:white;
	border-radius:18px 0 0 18px;
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	<div class="container py-5">
		<div class="row justify-content-center">
			<div class="col-lg-9">
				<div class="card login-card">
					<div class="row no-gutters">
						<div class="col-lg-5 d-none d-lg-block">
							<div class="login-side h-100 p-4 d-flex flex-column justify-content-center">
								<h2 class="font-weight-bold">One login page for both roles</h2>
								<p class="mt-3 mb-4">Use the same form to sign in as a customer or as the admin. Admin credentials still open the admin dashboard, and registered users go to their user home page.</p>
								<ul class="pl-3 mb-0">
									<li class="mb-2">Admin: `admin@gmail.com` / `admin`</li>
									<li class="mb-2">Users: sign in with your registered email and password</li>
									<li>New users can create an account from here</li>
								</ul>
							</div>
						</div>
						<div class="col-lg-7">
							<div class="card-body p-4 p-lg-5">

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

								<h4 class="text-center font-weight-bold mb-2">Sign In</h4>
								<p class="text-center text-muted mb-4">Customer and admin accounts both use this page.</p>
								<form action="login" method="post">
									<div class="form-group">
										<label for="loginEmail">Email address</label>
										<input type="email" class="form-control" id="loginEmail"
											required="required" name="email" placeholder="Enter your email">
									</div>
									<div class="form-group">
										<label for="loginPassword">Password</label>
										<input type="password" class="form-control" id="loginPassword"
											required="required" name="password" placeholder="Enter your password">
									</div>
									<div class="form-check mb-4">
										<input type="checkbox" class="form-check-input"
											id="exampleCheck1" required="required">
										<label class="form-check-label" for="exampleCheck1">I understand this page is for both customer and admin login.</label>
									</div>
									<div class="text-center">
										<button type="submit" class="btn btn-primary px-4">Login</button><br>
										<a href="register.jsp" class="d-inline-block mt-3">Create Account</a>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
