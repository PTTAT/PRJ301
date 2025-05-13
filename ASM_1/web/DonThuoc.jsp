<%-- 
    Document   : DonThuoc.jsp
    Created on : Mar 21, 2025, 2:31:46 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đơn Thuốc</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <% if (AuthUtils.isLoggedIn(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>Đơn Thuốc</h1>
                <% if (AuthUtils.isAdmin(session) || AuthUtils.isBoss(session)) { %>
                <a href="MainController?action=viewMedicalRecord&id=${maBN}" class="btn btn-secondary">Quay lại</a><%}%>
                <% if (AuthUtils.isUser(session)) { %>
                <a href="MainController?action=viewPatientRecords&id=${maBN}" class="btn btn-secondary">Quay lại</a><%}%>
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
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">Danh sách thuốc</h4>
                    <% if (AuthUtils.isAdmin(session) || AuthUtils.isBoss(session)) { %>
                    <a href="MainController?action=addPrescriptionForm&maHoSo=${maHoSo}&maBN=${maBN}" class="btn btn-primary">Thêm thuốc</a><%}%>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty prescriptions}">
                            <p class="text-center">Chưa có đơn thuốc nào.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Tên Thuốc</th>
                                            <th>Số Lượng</th>
                                            <th>Liều Dùng</th>
                                                <% if (AuthUtils.isAdmin(session) || AuthUtils.isBoss(session)) { %>
                                            <th>Thao Tác</th><%}%>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${prescriptions}" var="prescription">
                                            <tr>
                                                <td>
                                                    <c:forEach items="${medicines}" var="medicine">
                                                        <c:if test="${medicine.maThuoc == prescription.maThuoc}">
                                                            ${medicine.tenThuoc}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>${prescription.soLuong}</td>
                                                <td>${prescription.lieuDung}</td>
                                                <% if (AuthUtils.isAdmin(session) || AuthUtils.isBoss(session)) { %>
                                                <td>
                                                    <a href="MainController?action=deletePrescription&id=${prescription.maDon}&maHoSo=${maHoSo}&maBN=${maBN}" 
                                                       class="btn btn-danger btn-sm" 
                                                       onclick="return confirm('Bạn có chắc muốn xóa đơn thuốc này?')">Xóa</a>
                                                </td><%}%>
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
        <% }%>
    </body>
</html>
