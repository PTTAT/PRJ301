<%-- 
    Document   : jsp
    Created on : Mar 26, 2025, 3:51:28 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Bác sĩ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f5f5f5;
            }
            .container {
                padding: 40px 20px;
            }
            .card {
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .btn-primary {
                background-color: #4CAF50;
                border-color: #4CAF50;
            }
            .btn-primary:hover {
                background-color: #45a049;
                border-color: #45a049;
            }
        </style>
    </head>
    <body>
        <% if (AuthUtils.isAdmin(session) || AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title mb-0">Danh sách Bác sĩ</h3>
                    <a href="MainController?action=addDoctor" class="btn btn-primary">Thêm bác sĩ mới</a>
                    
                <a href="index.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
                </div>
                <div class="card-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Họ và tên</th>
                                    <th>Số điện thoại</th>
                                    <th>Email</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="doctor" items="${bacSiList}">
                                    <tr>
                                        <td>${doctor.hoTen}</td>
                                        <td>${doctor.SDT}</td>
                                        <td>${doctor.email}</td>
                                        <td>
                                            <a href="MainController?action=editDoctor&id=${doctor.maBS}" class="btn btn-warning btn-sm">Sửa</a>
                                            <a href="MainController?action=deleteDoctor&id=${doctor.maBS}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa bác sĩ này?')">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html>
