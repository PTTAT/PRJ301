<%-- 
    Document   : BenhNhan.jsp
    Created on : Mar 21, 2025, 10:56:08 AM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh Sách Bệnh Nhân</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <% if (AuthUtils.isAdmin(session)||AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container mt-4">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>Danh Sách Bệnh Nhân</h1>
                <a href="index.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
            
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
            
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Họ Tên</th>
                        <th>Ngày Sinh</th>
                        <th>Giới Tính</th>
                        <th>Số Điện Thoại</th>
                        <th>Địa Chỉ</th>
                        <th>Email</th>
                        <th>Hồ sơ khám bệnh</th>
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${benhNhanList}" var="bn">
                        <tr>
                            <td>${bn.hoTen}</td>
                            <td>${bn.ngaySinh}</td>
                            <td>${bn.gioiTinh}</td>
                            <td>${bn.SDT}</td>
                            <td>${bn.diaChi}</td>
                            <td>${bn.email}</td>
                            <td>
                                <a href="MainController?action=viewMedicalRecord&id=${bn.maBN}" class="btn btn-info btn-sm">Xem hồ sơ</a>
                            </td>
                            <td>
                                <a href="MainController?action=editPatient&id=${bn.maBN}" class="btn btn-primary btn-sm">Sửa</a>
                                <a href="MainController?action=deletePatient&id=${bn.maBN}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa bệnh nhân này?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <a href="MainController?action=addPatient" class="btn btn-success">Thêm Bệnh Nhân Mới</a>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="footer.jsp"/>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html>
