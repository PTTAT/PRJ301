<%-- 
    Document   : LienHe.jsp
    Created on : Mar 21, 2025, 3:36:48 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh Sách Liên Hệ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        
    </head>
    <body>
        <% if (AuthUtils.isAdmin(session)||AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>Danh Sách Liên Hệ</h1>
                <a href="index.jsp" class="btn btn-secondary">Quay lại</a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0">Danh sách liên hệ</h4>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty lienHeList}">
                            <p class="text-center">Chưa có liên hệ nào.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Tên</th>
                                            <th>Email</th>
                                            <th>Số điện thoại</th>
                                            <th>Nội dung</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${lienHeList}" var="lienHe">
                                            <tr>
                                                <td>${lienHe.ten}</td>
                                                <td>${lienHe.email}</td>
                                                <td>${lienHe.SDT}</td>
                                                <td>${lienHe.noiDung}</td>
                                                <td>
                                                    <a href="MainController?action=deleteContact&id=${lienHe.maLH}" 
                                                       class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Bạn có chắc muốn xóa liên hệ này?')">Xóa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="footer.jsp"/>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html>
