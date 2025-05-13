<%-- 
    Document   : AddLichHen.jsp
    Created on : Mar 21, 2025, 5:28:29 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm lịch hẹn mới</title>
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
        <% if (AuthUtils.isLoggedIn(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title mb-0">Thêm lịch hẹn mới</h3>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="addAppointment">
                                
                                <div class="mb-3">
                                    <label class="form-label">Bệnh nhân</label>
                                    <c:choose>
                                        <c:when test="${sessionScope.user.role eq 'BenhNhan'}">
                                            <input type="text" class="form-control" value="${sessionScope.user.name}" readonly>
                                            <c:forEach var="patient" items="${patients}">
                                                <c:if test="${patient.hoTen eq sessionScope.user.name}">
                                                    <input type="hidden" name="maBN" value="${patient.maBN}">
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <select name="maBN" class="form-select" required>
                                                <option value="">Chọn bệnh nhân</option>
                                                <c:forEach var="patient" items="${patients}">
                                                    <option value="${patient.maBN}">${patient.hoTen}</option>
                                                </c:forEach>
                                            </select>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-3">
                                    <label for="maBS" class="form-label">Bác sĩ</label>
                                    <c:choose>
                                        <c:when test="${sessionScope.user.role eq 'BacSi'}">
                                            <input type="text" class="form-control" value="${sessionScope.user.name}" readonly>
                                            <c:forEach var="doctor" items="${doctors}">
                                                <c:if test="${doctor.hoTen eq sessionScope.user.name}">
                                                    <input type="hidden" name="maBS" value="${doctor.maBS}">
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <select name="maBS" id="maBS" class="form-select" required>
                                                <option value="">Chọn bác sĩ</option>
                                                <c:forEach var="doctor" items="${doctors}">
                                                    <option value="${doctor.maBS}">${doctor.hoTen}</option>
                                                </c:forEach>
                                            </select>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-3">
                                    <label for="ngayHen" class="form-label">Ngày hẹn</label>
                                    <input type="date" class="form-control" id="ngayHen" name="ngayHen" required>
                                </div>

                                <div class="mb-3">
                                    <label for="gioHen" class="form-label">Giờ hẹn</label>
                                    <input type="time" class="form-control" id="gioHen" name="gioHen" required>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Thêm lịch hẹn</button>
                                    <a href="index.jsp" class="btn btn-secondary">Hủy</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
           
        </div>

        <jsp:include page="footer.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Set minimum date to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('ngayHen').min = today;

            function validateForm() {
                const ngayHen = document.getElementById('ngayHen').value;
                const gioHen = document.getElementById('gioHen').value;
                const selectedDateTime = new Date(ngayHen + 'T' + gioHen);
                const now = new Date();

                // Reset seconds and milliseconds for accurate comparison
                now.setSeconds(0, 0);
                selectedDateTime.setSeconds(0, 0);

                if (selectedDateTime < now) {
                    alert('Vui lòng chọn thời gian trong tương lai!');
                    return false;
                }
                return true;
            }
        </script>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html>
