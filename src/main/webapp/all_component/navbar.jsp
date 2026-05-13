<div class="container-fluid"
 style="height:8px;background-color:#303f9f"></div>

<div class="container-fluid p-3 bg-light">
	<%
	String searchKeyword = request.getParameter("query");
	if(searchKeyword == null){
		searchKeyword = "";
	}
	String searchKeywordValue = searchKeyword
			.replace("&", "&amp;")
			.replace("\"", "&quot;")
			.replace("<", "&lt;")
			.replace(">", "&gt;");
	%>
	<div class="row">

		<div class="col-md-3 text-success">

			<h2>
			<i class="fas fa-book"></i>
			Stationery-Shop</h2>

		</div>
		<div class="col-md-4">
			<form class="form-inline my-2 my-lg-0" action="<%=request.getContextPath()%>/search_items.jsp" method="get">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search" name="query"
					value="<%=searchKeywordValue%>">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>

		</div>
		<div class="col-md-3">
		 <a href="login.jsp" class="btn btn-success"><i class="fa-solid fa-right-to-bracket"></i>Login</a>
		 <a href="register.jsp" class="btn btn-primary text-white"><i class="fa-solid fa-person-circle-plus"></i>Register</a>
		 
		 </div>
	</div>
</div>



<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
	<a class="navbar-brand" href="index.jsp"><i class="fa-solid fa-house"></i></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="index.jsp">Home
					<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link" href="#"><i class="fa-solid fa-book-open"></i>Old Items</a></li>
			
			<li class="nav-item active"><a class="nav-link" href="#"><i class="fa-solid fa-book-open"></i>New Arrivals</a></li>
			
			<li class="nav-item active"><a class="nav-link disabled" href="#"><i class="fa-solid fa-book-open"></i>Upcoming Items</a>
			</li>
		</ul>
		<form class="form-inline my-2 my-lg-0">
		
			<button class="btn btn-light my-2 my-sm-0 ml-1" type="button"><i class="fa-solid fa-gear"></i>Setting</button>
			
			<button class="btn btn-light my-2 my-sm-0 ml-1" type="button"><i class="fa-solid fa-person-circle-plus"></i>Contact us</button>
		</form>
	</div>
</nav>
