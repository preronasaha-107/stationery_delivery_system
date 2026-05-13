<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<%@include file="all_component/allCSS.jsp"%>
<style>
body{background-color:#f0f1f2;}
.login-card{border:1px solid #dee2e6;}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	<div class="container py-4">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card login-card">
					<div class="card-body p-4">

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

						<h4 class="text-center mb-3">Login</h4>
						<p class="text-center text-muted mb-4">This page works for both customer and admin login.</p>
						<div class="row">
							<div class="col-md-6 mb-4 mb-md-0">
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
										<label class="form-check-label" for="exampleCheck1">Agree to continue</label>
									</div>
									<div class="text-center">
										<button type="submit" class="btn btn-primary px-4">Login</button><br>
										<a href="register.jsp" class="d-inline-block mt-3">Create Account</a>
									</div>
								</form>
							</div>
							<div class="col-md-6">
								<div class="border p-3 h-100">
									<h5>Login Help</h5>
									<p class="text-muted mb-2">Admin credentials still open the admin dashboard.</p>
									<p class="text-muted mb-2">Registered users can sign in with their email and password.</p>
									<p class="text-muted mb-0">New users can create an account from the link on this page.</p>
								</div>
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
