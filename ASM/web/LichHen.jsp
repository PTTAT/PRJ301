<%-- 
    Document   : LichHen.jsp
    Created on : Mar 21, 2025, 5:06:50 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách lịch hẹn</title>
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
            .table {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .table th {
                background-color: #4CAF50;
                color: white;
                font-weight: 500;
            }
            .table-hover tbody tr:hover {
                background-color: #f8f9fa;
            }
            .btn-add {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            .btn-add:hover {
                background-color: #45a049;
                color: white;
            }
            .alert {
                margin-bottom: 20px;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <% if (AuthUtils.isAdmin(session)||AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h2>Danh sách lịch hẹn</h2>
                <a href="index.jsp" class="btn btn-secondary">Quay lại</a><br>
            </div>
            <a href="MainController?action=addAppointmentForm" class="btn btn-add">                  
                <i class="fas fa-plus"></i> Thêm lịch hẹn</a>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success" role="alert">
                    ${message}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty lichHenList}">
                    <div class="alert alert-info" role="alert">
                        Chưa có lịch hẹn nào.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Tên bệnh nhân</th>
                                    <th>Bác sĩ</th>
                                    <th>Ngày hẹn</th>
                                    <th>Giờ hẹn</th>
                                    <% if (AuthUtils.isAdmin(session)||AuthUtils.isBoss(session)) { %>
                                    <th>Thao tác</th>
                                        <% } else { %>            
                            <p>You do not have permission to access this content.</p>
                            <% } %>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="lichHen" items="${lichHenList}">
                                    <tr>
                                        <td>${patientNames[lichHen.maBN]}</td>
                                        <td>${doctorNames[lichHen.maBS]}</td>
                                        <td><fmt:formatDate value="${lichHen.ngayHen}" pattern="dd/MM/yyyy"/></td>
                                        <td><fmt:formatDate value="${lichHen.gioHen}" pattern="HH:mm"/></td>
                                        <% if (AuthUtils.isAdmin(session)||AuthUtils.isBoss(session)) { %>
                                        <td>
                                            <a href="#" onclick="confirmDelete(${lichHen.maLichHen})" class="btn btn-sm btn-danger">
                                                <i class="fas fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                        <% } else { %>            
                            <p>You do not have permission to access this content.</p>
                            <% } %>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="footer.jsp"/>

        <!-- Bootstrap JS and Font Awesome -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/your-code.js"></script>

        <script>
                                                function confirmDelete(id) {
                                                    if (confirm('Bạn có chắc muốn xóa lịch hẹn này?')) {
                                                        window.location.href = 'MainController?action=deleteAppointment&id=' + id;
                                                    }
                                                }
        </script>

        <% } else { %>            
        <p>You do not have permission to access this content.</p>
        <% }%>
    </body>
</html>
