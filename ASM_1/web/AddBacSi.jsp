<%-- 
    Document   : AddBacSi.jsp
    Created on : Mar 26, 2025, 3:51:55 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${doctor != null ? 'Sửa' : 'Thêm'} Bác sĩ</title>
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
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title mb-0">${doctor != null ? 'Sửa' : 'Thêm'} Bác sĩ</h3>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="${doctor != null ? 'updateDoctor' : 'createDoctor'}">
                                <c:if test="${doctor != null}">
                                    <input type="hidden" name="maBS" value="${doctor.maBS}">
                                </c:if>

                                <div class="mb-3">
                                    <label for="hoTen" class="form-label">Họ và tên</label>
                                    <input type="text" class="form-control" id="hoTen" name="hoTen" value="${doctor.hoTen}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="sdt" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="sdt" name="sdt" value="${doctor.SDT}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${doctor.email}" required>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">${doctor != null ? 'Cập nhật' : 'Thêm'} bác sĩ</button>
                                    <a href="MainController?action=viewDoctors" class="btn btn-secondary">Hủy</a>
                                </div>
                            </form>
                        </div>
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
