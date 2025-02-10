<%-- 
    Document   : example03
    Created on : Feb 10, 2025, 10:24:09 AM
    Author     : trana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Số Chẵn, số lẻ</title>
    </head>
    <body>
        <%
            for (int a = 1; a <= 100; a++) {
        %>
        
        <% 
            if (a % 2 == 0) {
        %> 
        
        <b><%=a%> Là số chẵn!<br/></b>
        
        <%
        } else {
        %> 
        
        <b><%=a%> Lầ số lẻ!<br/></b>
        
        <%
            }
        %>
        
        <%
            }
        %>
    </body>
</html>
