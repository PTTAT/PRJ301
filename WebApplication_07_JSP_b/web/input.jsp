<%-- 
    Document   : input
    Created on : Feb 10, 2025, 10:54:12 AM
    Author     : trana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nhập n</title>
    </head>
    <body>   
        Bảng Cửu Chương
        <form action="PrintServlet">
            n = <input type="text" name="strN"/>
            <input type="submit" value="Submit"/>
        </form>
        <hr/>
        Tìm số chẵn, số lẻ
        <form action="PrintServlet1">
            n = <input type="text" name="strN"/>
            <input type="submit" value="Submit"/>
        </form>
    </body>
</html>
