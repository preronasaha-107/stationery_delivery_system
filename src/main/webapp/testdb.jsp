<%@ page import="java.sql.Connection" %>
<%@ page import="com.DB.DBConnect" %>

<html>
<body>

<%

Connection conn = DBConnect.getConn();

if(conn != null){

    out.println("Database Connected Successfully");

}else{

    out.println("Database Not Connected");

}

%>

</body>
</html>