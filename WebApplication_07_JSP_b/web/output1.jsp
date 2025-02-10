<%-- 
    Document   : output1
    Created on : Feb 10, 2025, 11:16:50 AM
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
            int n = (int)request.getAttribute("n");
            %>
            
            
        
        <% 
            if (n % 2 == 0) {
        %> 
        
        <b><%=n%> la so chan!<br/></b>
        
        <%
        } else {
        %> 
        
        <b><%=n%> la so le!<br/></b>
        
        <%
            }
        %>
        
        
    </body>
</html>
