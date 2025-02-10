<%-- 
    Document   : output
    Created on : Feb 10, 2025, 11:06:13 AM
    Author     : trana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bảng cửu chương</title>
    </head>
    <body>
        <%
            int n = (int)request.getAttribute("n");
            %>
            <span style="color: red; font-weight: 1000" >  Bảng cửu chương  <%=n%><br/></span>

        <%
            for (int b = 1; b <= 10; b++) {
        %>

        <%=n%> * <%=b%> = <span style="color: red; background-color: yellow "><%=n * b%></span> <br/>

        <%
            }
        %>
    </body>
</html>
