<%-- 
    Document   : LichHenBN.jsp
    Created on : Mar 22, 2025, 6:30:18 PM
    Author     : trana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch hẹn của bệnh nhân</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container mt-4">
            <h2>Lịch hẹn của tôi</h2>
            
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
                        Bạn chưa có lịch hẹn nào.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Bác sĩ</th>
                                    <th>Ngày hẹn</th>
                                    <th>Giờ hẹn</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="lichHen" items="${lichHenList}">
                                    <tr>
                                        <td>${doctorNames[lichHen.maBS]}</td>
                                        <td><fmt:formatDate value="${lichHen.ngayHen}" pattern="dd/MM/yyyy"/></td>
                                        <td><fmt:formatDate value="${lichHen.gioHen}" pattern="HH:mm"/></td>
                                        <td>
                                            <form action="MainController" method="POST" style="display: inline;">
                                                <input type="hidden" name="action" value="deleteAppointment">
                                                <input type="hidden" name="maLichHen" value="${lichHen.maLichHen}">
                                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa lịch hẹn này?')">
                                                    Xóa
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
