<%-- 
    Document   : DichVu.jsp
    Created on : Mar 21, 2025, 9:56:15 AM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dịch vụ nha khoa</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background-color: #f5f5f5;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 40px 20px;
            }

            .section-title {
                text-align: center;
                margin-bottom: 50px;
            }

            .section-title h2 {
                font-size: 2.5rem;
                color: #333;
                margin-bottom: 15px;
            }

            .section-title p {
                color: #666;
                font-size: 1.1rem;
            }

            .services-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
                margin-bottom: 60px;
            }

            .service-card {
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
            }

            .service-card:hover {
                transform: translateY(-5px);
            }

            .service-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .service-content {
                padding: 20px;
            }

            .service-content h3 {
                font-size: 1.5rem;
                color: #333;
                margin-bottom: 10px;
            }

            .service-content p {
                color: #666;
                line-height: 1.6;
                margin-bottom: 15px;
            }

            .price-table {
                width: 100%;
                background: white;
                border-radius: 10px;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .price-table table {
                width: 100%;
                border-collapse: collapse;
            }

            .price-table th,
            .price-table td {
                padding: 15px 20px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }

            .price-table th {
                background-color: #4CAF50;
                color: white;
                font-weight: 500;
            }

            .price-table tr:hover {
                background-color: #f9f9f9;
            }

            .price {
                color: #4CAF50;
                font-weight: 600;
            }

            .price::before {
                content: "₫";
                margin-right: 2px;
            }

            .action-buttons {
                display: flex;
                gap: 10px;
                margin-top: 10px;
            }

            .btn {
                padding: 8px 16px;
                border-radius: 5px;
                border: none;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .btn-edit {
                background-color: #4CAF50;
                color: white;
            }

            .btn-delete {
                background-color: #f44336;
                color: white;
            }

            .btn-add {
                background-color: #4CAF50;
                color: white;
                padding: 12px 24px;
                margin-bottom: 20px;
            }

            .btn:hover {
                opacity: 0.9;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
            }

            .alert-success {
                background-color: #dff0d8;
                border-color: #d6e9c6;
                color: #3c763d;
            }

            .alert-error {
                background-color: #f2dede;
                border-color: #ebccd1;
                color: #a94442;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <div class="container">
            <div class="section-title">
                <h2>Dịch vụ của chúng tôi</h2>
                <p>Khám phá các dịch vụ nha khoa chuyên nghiệp</p>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    ${message}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>

            <% if (AuthUtils.isBoss(session)) { %>
                <a href="MainController?action=addServices" class="btn btn-add">Thêm dịch vụ mới</a>
            <% } %>
            <div class="services-grid">
                <c:forEach items="${dichVuList}" var="dv">
                    <div class="service-card">
                        <div class="service-content">
                            <h3>${dv.tenDV}</h3>
                            <p>${dv.moTa}</p>
                            <% if (AuthUtils.isBoss(session)) { %>
                                <div class="action-buttons">
                                    <a href="MainController?action=editServices&id=${dv.maDV}" class="btn btn-edit">Sửa</a>
                                    <a href="MainController?action=deleteServices&id=${dv.maDV}" class="btn btn-delete" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa dịch vụ này?')">Xóa</a>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="section-title">
                <h2>Bảng giá dịch vụ</h2>
                <p>Tham khảo giá các dịch vụ của chúng tôi</p>
            </div>

            <div class="price-table">
                <table>
                    <thead>
                        <tr>
                            <th>Tên dịch vụ</th>
                            <th>Giá</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${dichVuList}" var="dv">
                            <tr>
                                <td>${dv.tenDV}</td>
                                <td class="price">${dv.gia}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
