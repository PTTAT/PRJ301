<%-- 
    Document   : search
    Created on : Feb 13, 2025, 11:27:20 AM
    Author     : tungi
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="dto.BookDTO"%>
<%@page import="java.awt.print.Book"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-16WWW">
        <title>JSP Page</title>
    </head>
    <body> 
        <div style="min-height: 500px; padding: 10px">
            <%                if (session.getAttribute("user") != null) {
                    UserDTO user = (UserDTO) session.getAttribute("user");
            %>
            <% if (AuthUtils.isLoggedIn(session)) { %>
            <h1> Welcome <%=user.getName()%> </h1>
            
            <form action="MainController">
                <input type="hidden" name="action" value="logout"/>
                <input type="submit" value="Logout"/>
            </form>
            <%} else { %>
            You do not have permission to access this content.
            <%}}%>
        </div>
    </body>
</html>