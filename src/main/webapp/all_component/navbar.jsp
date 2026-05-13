<%@page import="com.entity.User"%>
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

User navbarUser = (User)session.getAttribute("userobj");
String navbarRole = (String)session.getAttribute("user");
boolean loggedInUser = navbarUser != null && "normal".equalsIgnoreCase(navbarRole);
%>

<div class="container-fluid" style="height:8px;background-color:#303f9f"></div>

<div class="container-fluid p-3 bg-light border-bottom">
    <div class="row align-items-center">
        <div class="col-lg-3 col-md-12 mb-2 mb-lg-0 text-success">
            <h2 class="mb-0">
                <i class="fas fa-book"></i>
                Stationery-Shop
            </h2>
        </div>

        <div class="col-lg-5 col-md-8 mb-2 mb-md-0">
            <form class="form-inline justify-content-center justify-content-lg-start"
                  action="<%=request.getContextPath()%>/search_items.jsp"
                  method="get">
                <input class="form-control mr-sm-2 flex-grow-1"
                       type="search"
                       placeholder="Search items, categories, status"
                       aria-label="Search"
                       name="query"
                       value="<%=searchKeywordValue%>"
                       style="min-width:260px;">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                    Search
                </button>
            </form>
        </div>

        <div class="col-lg-4 col-md-4 text-md-right">
            <% if(loggedInUser){ %>
            <span class="text-muted mr-2">Hello, <strong><%=navbarUser.getName()%></strong></span>
            <a href="cart.jsp?uid=<%=navbarUser.getId()%>" class="btn btn-warning text-dark ml-1">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <a href="settings.jsp" class="btn btn-light border ml-1">
                <i class="fa-solid fa-gear"></i>
            </a>
            <a href="contact.jsp" class="btn btn-light border ml-1">
                <i class="fa-solid fa-envelope"></i>
            </a>
            <a href="logout" class="btn btn-danger ml-1">
                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                Logout
            </a>
            <% } else { %>
            <a href="login.jsp" class="btn btn-warning text-dark ml-1">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <a href="settings.jsp" class="btn btn-light border ml-1">
                <i class="fa-solid fa-gear"></i>
            </a>
            <a href="contact.jsp" class="btn btn-light border ml-1">
                <i class="fa-solid fa-envelope"></i>
            </a>
            <a href="login.jsp" class="btn btn-success ml-1">
                <i class="fa-solid fa-right-to-bracket"></i>
                Login
            </a>
            <a href="register.jsp" class="btn btn-primary text-white ml-1">
                <i class="fa-solid fa-person-circle-plus"></i>
                Register
            </a>
            <% } %>
        </div>
    </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
    <a class="navbar-brand" href="index.jsp">
        <i class="fa-solid fa-house"></i>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
        data-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false"
        aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">Home</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="latest_items.jsp">
                    <i class="fa-solid fa-sparkles mr-1"></i>Latest Items
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="upcoming_items.jsp">
                    <i class="fa-solid fa-hourglass-start mr-1"></i>Upcoming Items
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="contact.jsp">
                    <i class="fa-solid fa-headset mr-1"></i>Contact Us
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="settings.jsp">
                    <i class="fa-solid fa-sliders mr-1"></i>Settings
                </a>
            </li>
        </ul>
    </div>
</nav>
