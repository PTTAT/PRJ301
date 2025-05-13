<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa Thông Tin Bệnh Nhân</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <% if (AuthUtils.isAdmin(session)||AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        <div class="container mt-4">
            <h1 class="mb-4">Chỉnh sửa Thông Tin Bệnh Nhân</h1>
            
            
            
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="updatePatient">
                <input type="hidden" name="maBN" value="${patient.maBN}">
                
                <div class="mb-3">
                    <label for="hoTen" class="form-label">Họ Tên</label>
                    <input type="text" class="form-control" id="hoTen" name="hoTen" value="${patient.hoTen}" required>
                </div>
                
                <div class="mb-3">
                    <label for="ngaySinh" class="form-label">Ngày Sinh</label>
                    <input type="date" class="form-control" id="ngaySinh" name="ngaySinh" value="${patient.ngaySinh}" required>
                </div>
                
                <div class="mb-3">
                    <label for="gioiTinh" class="form-label">Giới Tính</label>
                    <select class="form-select" id="gioiTinh" name="gioiTinh" required>
                        <option value="Nam" ${patient.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                        <option value="Nu" ${patient.gioiTinh == 'Nu' ? 'selected' : ''}>Nữ</option>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="sdt" class="form-label">Số Điện Thoại</label>
                    <input type="tel" class="form-control" id="sdt" name="sdt" value="${patient.SDT}" required>
                </div>
                
                <div class="mb-3">
                    <label for="diaChi" class="form-label">Địa Chỉ</label>
                    <textarea class="form-control" id="diaChi" name="diaChi" rows="3" required>${patient.diaChi}</textarea>
                </div>
                
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="${patient.email}" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                <a href="MainController?action=viewPatients" class="btn btn-secondary">Hủy</a>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="footer.jsp"/>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html> 