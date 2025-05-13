<%-- 
    Document   : AddDichVu.jsp
    Created on : Mar 22, 2025, 10:52:49 AM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${dichVu != null ? 'Chỉnh sửa dịch vụ' : 'Thêm mới dịch vụ'}</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background-color: #f5f5f5;
                min-height: 100vh;
            }

            .container {
                max-width: 800px;
                margin: 40px auto;
                padding: 20px;
            }

            .form-container {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            }

            .form-title {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
                font-size: 24px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }

            .form-group input,
            .form-group textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
            }

            .form-group textarea {
                height: 100px;
                resize: vertical;
            }

            .btn-group {
                display: flex;
                gap: 10px;
                justify-content: center;
                margin-top: 30px;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .btn-primary {
                background-color: #4CAF50;
                color: white;
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }

            .btn:hover {
                opacity: 0.9;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                display: none;
            }

            .alert-error {
                background-color: #f2dede;
                border-color: #ebccd1;
                color: #a94442;
            }
        </style>
    </head>
    <body>
        <% if (AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        
        <div class="container">
            <div class="form-container">
                <h2 class="form-title">${dichVu != null ? 'Chỉnh sửa dịch vụ' : 'Thêm mới dịch vụ'}</h2>

                

                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="${dichVu != null ? 'updateServices' : 'addServices'}">
                    <c:if test="${dichVu != null}">
                        <input type="hidden" name="maDV" value="${dichVu.maDV}">
                    </c:if>

                    <div class="form-group">
                        <label for="tenDV">Tên dịch vụ</label>
                        <input type="text" id="tenDV" name="tenDV" value="${dichVu.tenDV}" required>
                    </div>

                    <div class="form-group">
                        <label for="moTa">Mô tả</label>
                        <textarea id="moTa" name="moTa" required>${dichVu.moTa}</textarea>
                    </div>

                    <div class="form-group">
                        <label for="gia">Giá</label>
                        <input type="number" id="gia" name="gia" value="${dichVu.gia}" required min="0">
                    </div>

                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">
                            ${dichVu != null ? 'Cập nhật' : 'Thêm mới'}
                        </button>
                        <a href="MainController?action=viewServices" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

        <script>
            // Check if there's an error message and show the alert if there is
            window.onload = function() {
                var errorMessage = '${error}';
                if (errorMessage && errorMessage.trim() !== '') {
                    document.getElementById('errorAlert').style.display = 'block';
                }
            };
        </script>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html>
