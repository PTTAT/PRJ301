<%-- 
    Document   : DTLHBN.jsp
    Created on : Mar 22, 2025, 10:24:12 AM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đơn thuốc và lịch hẹn</title>
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
                margin-bottom: 30px;
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
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <c:if test="${empty patient}">
                        <form action="MainController" method="POST" id="searchForm">
                            <input type="hidden" name="action" value="viewPatientPrescription">
                            <input type="hidden" name="hoTen" value="${sessionScope.user.name}">
                        </form>
                        <script>
                            document.getElementById('searchForm').submit();
                        </script>
                    </c:if>

                    <c:if test="${not empty patient}">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title mb-0">Thông tin bệnh nhân</h3>
                            </div>
                            <div class="card-body">
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
                        </div>

                        <!-- Đơn thuốc -->
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title mb-0">Đơn thuốc</h3>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty prescriptions}">
                                    <p class="text-muted">Chưa có đơn thuốc nào.</p>
                                </c:if>
                                <c:if test="${not empty prescriptions}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Thuốc</th>
                                                    <th>Số lượng</th>
                                                    <th>Liều dùng</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="prescription" items="${prescriptions}">
                                                    <tr>
                                                        <td>${medicineNames[prescription.maThuoc]}</td>
                                                        <td>${prescription.soLuong}</td>
                                                        <td>${prescription.lieuDung}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        
                    </c:if>
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
