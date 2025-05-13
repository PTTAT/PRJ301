<%-- 
    Document   : HoSoKham.jsp
    Created on : Mar 21, 2025, 1:53:33 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hồ Sơ Khám Bệnh</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <% if (AuthUtils.isAdmin(session)||AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>Hồ Sơ Khám Bệnh</h1>
                <div>
                    <a href="MainController?action=addMedicalRecordForm&maBN=${patient.maBN}" class="btn btn-primary me-2">Thêm Hồ Sơ Khám</a>
                    <a href="MainController?action=viewPatients" class="btn btn-secondary">Quay lại</a>
                </div>
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

            <div class="card mb-4">
                <div class="card-header">
                    <h4>Thông tin bệnh nhân</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Mã BN:</strong> ${patient.maBN}</p>
                            <p><strong>Họ tên:</strong> ${patient.hoTen}</p>
                            <p><strong>Ngày sinh:</strong> ${patient.ngaySinh}</p>
                            <p><strong>Giới tính:</strong> ${patient.gioiTinh}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Số điện thoại:</strong> ${patient.SDT}</p>
                            <p><strong>Địa chỉ:</strong> ${patient.diaChi}</p>
                            <p><strong>Email:</strong> ${patient.email}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h4>Lịch sử khám bệnh</h4>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty medicalRecords}">
                            <p class="text-center">Chưa có hồ sơ khám bệnh nào.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Ngày khám</th>
                                            <th>Mã BS</th>
                                            <th>Triệu chứng</th>
                                            <th>Chẩn đoán</th>
                                            <th>Đơn Thuốc</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${medicalRecords}" var="record">
                                            <tr>
                                                <td><fmt:formatDate value="${record.ngayKham}" pattern="dd/MM/yyyy"/></td>
                                                <td>${record.maBS}</td>
                                                <td>${record.trieuChung}</td>
                                                <td>${record.chanDoan}</td>
                                                <td>
                                                    <a href="MainController?action=viewPrescription&maHoSo=${record.maHoSo}&maBN=${patient.maBN}" 
                                                       class="btn btn-info btn-sm">Xem Đơn Thuốc</a>
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
