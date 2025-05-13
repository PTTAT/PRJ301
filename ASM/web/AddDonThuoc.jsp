<%-- 
    Document   : AddDonThuoc.jsp
    Created on : Mar 21, 2025, 2:50:18 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm Đơn Thuốc</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .form-container {
                max-width: 800px;
                margin: 20px auto;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 5px;
            }
            .alert {
                display: none;
            }
        </style>
    </head>
    <body>
        <% if (AuthUtils.isAdmin(session)||AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <div class="form-container">
                <h2 class="text-center mb-4">Thêm đơn thuốc</h2>
                
                <div id="errorAlert" class="alert alert-danger" role="alert"></div>
                <div id="messageAlert" class="alert alert-success" role="alert"></div>
                
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="addPrescription">
                    <input type="hidden" name="maHoSo" value="${maHoSo}">
                    <input type="hidden" name="maBN" value="${maBN}">
                    
                    <div class="mb-3">
                        <label for="maThuoc" class="form-label">Thuốc</label>
                        <select class="form-select" id="maThuoc" name="maThuoc" required>
                            <option value="">Chọn thuốc</option>
                            <c:forEach var="medicine" items="${medicines}">
                                <option value="${medicine.maThuoc}">${medicine.tenThuoc}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="soLuong" class="form-label">Số lượng</label>
                        <input type="number" class="form-control" id="soLuong" name="soLuong" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="lieuDung" class="form-label">Liều dùng</label>
                        <textarea class="form-control" id="lieuDung" name="lieuDung" rows="3" required></textarea>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" name="submitAction" value="Thêm" class="btn btn-primary">Thêm thuốc</button>
                        <button type="submit" name="submitAction" value="Hoàn thành" class="btn btn-success">Hoàn thành</button>
                        <a href="MainController?action=viewPrescription&maHoSo=${maHoSo}&maBN=${maBN}" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>

                <c:if test="${not empty prescriptions}">
                    <h3 class="mt-4">Danh sách thuốc đã thêm</h3>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Tên thuốc</th>
                                    <th>Số lượng</th>
                                    <th>Liều dùng</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="prescription" items="${prescriptions}">
                                    <tr>
                                        <td>
                                            <c:forEach var="medicine" items="${medicines}">
                                                <c:if test="${medicine.maThuoc == prescription.maThuoc}">
                                                    ${medicine.tenThuoc}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${prescription.soLuong}</td>
                                        <td>${prescription.lieuDung}</td>
                                        <td>
                                            <a href="MainController?action=deletePrescription&id=${prescription.maDon}&maHoSo=${maHoSo}&maBN=${maBN}" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa thuốc này?')">
                                                Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>

        <script>
            // Check for error and success messages on page load
            window.onload = function() {
                var errorMessage = "${error}";
                var successMessage = "${message}";
                
                if (errorMessage) {
                    var errorAlert = document.getElementById('errorAlert');
                    errorAlert.textContent = errorMessage;
                    errorAlert.style.display = 'block';
                }
                
                if (successMessage) {
                    var messageAlert = document.getElementById('messageAlert');
                    messageAlert.textContent = successMessage;
                    messageAlert.style.display = 'block';
                }
            }
        </script>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html>
