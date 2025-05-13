<%-- 
    Document   : header
    Created on : Feb 17, 2025, 10:56:38 AM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .header {
        background-color: green;
        padding: 1rem 0;
        width: 100%;
        top: 0;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1rem;
    }

    .nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .logo {
        color: #fff;
        font-size: 1.5rem;
        font-weight: bold;
        text-decoration: none;
    }

    .dt {
        display: flex;
        list-style: none;
        gap: 2rem;
    }



    .menu {
        display: flex;
        list-style: none;
        gap: 2rem;
    }

    .menu-item a {
        color: #fff;
        text-decoration: none;
        font-size: 1rem;
        transition: color 0.3s ease;
    }

    .menu-item a:hover {
        color: #3498db;
    }

    .search-bar {
        display: flex;
        align-items: center;
        background: #fff;
        border-radius: 20px;
        padding: 0.5rem 1rem;
    }

    .search-input {
        border: none;
        outline: none;
        padding: 0.2rem;
        width: 200px;
    }

    .search-button {
        background: none;
        border: none;
        cursor: pointer;
        color: #2c3e50;
    }
</style>

<header class="header">
    <%
        int x = 100;
    %>
    <div class="container">
        <nav class="nav">
            <a href="index.jsp" class="logo">Nha Khoa</a>
            <ul class="menu">
                <li class="menu-item"><a href="index.jsp">Trang chủ</a></li>
                <li class="menu-item"><a href="#">Giới Thiệu</a></li>
                <li class="menu-item"><a href="MainController?action=viewServices">Dịch vụ</a></li>
                <li class="menu-item"><a href="MainController?action=viewServices">Bảng giá</a></li>
                <li class="menu-item"><a href="AddLienHe.jsp">Liên hệ</a></li>
            </ul>
            <%--
            <div class="search-bar">
                <input type="text" class="search-input" placeholder="Tìm kiếm...">
                <button class="search-button">🔍</button>
            </div>--%>
            <ul class="dt">
                <% if (AuthUtils.isNotLog(session)) { %>
                    <li class="menu-item"><a href="login.jsp">Đăng nhập</a></li>
                    <li class="menu-item"><a href="DangKyBN.jsp">Đăng ký</a></li>
                <% } else { 
                    UserDTO user = AuthUtils.getUser(session);
                %>
                    <li class="menu-item"><span style="color: #fff;">Welcome <%=user.getName()%></span></li>
                    <a class="menu-item" href="MainController?action=logout"><span style="color: #fff;">Log out</span></a>
                <% } %>
            </ul>
        </nav>
    </div>
</header>
