<%-- 
    Document   : example04
    Created on : Feb 10, 2025, 10:31:23 AM
    Author     : trana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            for (int a = 2; a <= 10; a++) {
        %>

        <span style="color: red; font-weight: 1000" >  Bang cuu chuong  <%=a%><br/></span>

        <%
            for (int b = 1; b <= 10; b++) {
        %>

        <%=a%> * <%=b%> = <span style="color: red; background-color: yellow "><%=a * b%></span> <br/>

        <%
            }
        %>

        <br/>

        <%
            }
        %>
    </body>
</html>
