<%-- 
    Document   : search
    Created on : Feb 17, 2025, 9:30:50 AM
    Author     : trana
--%>

<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body> 
        <%
            UserDTO user = (UserDTO)request.getAttribute("user");
        %>
        <h1> Welcome <%=user.getFullName()%> </h1>
        
        <form action="#">
            Search Value: <input type="submit" name="txtSearchValue"/><br/>
            <input type="submit" name="Search"/>
        </form> 
    </body>
</html>
