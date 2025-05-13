<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm Hồ Sơ Khám Bệnh</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .form-container {
                max-width: 800px;
                margin: 20px auto;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <% if (AuthUtils.isAdmin(session) || AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        
        <div class="container mt-4">
            <div class="form-container">
                <h2 class="mb-4">Thêm Hồ Sơ Khám Bệnh</h2>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>

                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="addMedicalRecord">
                    <input type="hidden" name="maBN" value="${patient.maBN}">
                    
                    <div class="mb-3">
                        <label class="form-label">Mã Bệnh Nhân</label>
                        <input type="text" class="form-control" value="${patient.maBN}" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Họ Tên Bệnh Nhân</label>
                        <input type="text" class="form-control" value="${patient.hoTen}" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Mã Bác Sĩ</label>
                        <input type="number" class="form-control" name="maBS" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Ngày Khám</label>
                        <input type="date" class="form-control" name="ngayKham" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Triệu Chứng</label>
                        <textarea class="form-control" name="trieuChung" rows="3" required></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Chẩn Đoán</label>
                        <textarea class="form-control" name="chanDoan" rows="3" required></textarea>
                    </div>
                    
                    <div class="d-flex justify-content-between">
                        <a href="MainController?action=viewMedicalRecord&id=${patient.maBN}" class="btn btn-secondary">Quay lại</a>
                        <button type="submit" class="btn btn-primary">Lưu Hồ Sơ</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Set minimum date to today
            const today = new Date().toISOString().split('T')[0];
            document.querySelector('input[name="ngayKham"]').min = today;

            function validateForm() {
                const ngayKham = document.querySelector('input[name="ngayKham"]').value;
                const selectedDate = new Date(ngayKham);
                const now = new Date();
                
                // Reset time to midnight for accurate date comparison
                now.setHours(0, 0, 0, 0);
                selectedDate.setHours(0, 0, 0, 0);

                if (selectedDate < now) {
                    alert('Vui lòng chọn ngày khám trong tương lai!');
                    return false;
                }
                return true;
            }
        </script>
        <jsp:include page="footer.jsp"/>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html> 