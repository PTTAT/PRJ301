<%-- 
    Document   : HoSoKhamBN.jsp
    Created on : Mar 22, 2025, 9:16:48 AM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hồ sơ khám bệnh</title>
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
            .table-responsive {
                margin-top: 20px;
            }
            .table th {
                background-color: #f8f9fa;
            }
            .table-hover tbody tr:hover {
                background-color: #f5f5f5;
            }
        </style>
    </head>
    <body>
        <% if (AuthUtils.isLoggedIn(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title mb-0">Tìm kiếm hồ sơ khám bệnh</h3>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <c:if test="${empty patient}">
                                <form action="MainController" method="POST" id="searchForm">
                                    <input type="hidden" name="action" value="viewPatientRecords">
                                    <input type="hidden" name="hoTen" value="${sessionScope.user.name}">
                                </form>
                                <script>
                                    document.getElementById('searchForm').submit();
                                </script>
                            </c:if>

                            <c:if test="${not empty patient}">
                                <div class="mt-4">
                                    <h4>Thông tin bệnh nhân</h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <p><strong>Họ và tên:</strong> ${patient.hoTen}</p>
                                            <p><strong>Ngày sinh:</strong> ${patient.ngaySinh}</p>
                                            <p><strong>Giới tính:</strong> ${patient.gioiTinh}</p>
                                        </div>
                                        <div class="col-md-6">
                                            <p><strong>Số điện thoại:</strong> ${patient.SDT}</p>
                                            <p><strong>Email:</strong> ${patient.email}</p>
                                            <p><strong>Địa chỉ:</strong> ${patient.diaChi}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <h4 class="mt-4">Lịch sử khám bệnh</h4>
                                    <c:if test="${empty medicalRecords}">
                                        <p class="text-muted">Chưa có hồ sơ khám bệnh nào.</p>
                                    </c:if>
                                    <c:if test="${not empty medicalRecords}">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Ngày khám</th>
                                                    <th>Triệu chứng</th>
                                                    <th>Chẩn đoán</th>
                                                    <th>Bác sĩ</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="record" items="${medicalRecords}">
                                                    <tr>
                                                        <td>${record.ngayKham}</td>
                                                        <td>${record.trieuChung}</td>
                                                        <td>${record.chanDoan}</td>
                                                        <td>${doctorNames[record.maBS]}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </c:if>
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
