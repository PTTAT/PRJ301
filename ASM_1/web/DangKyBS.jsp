<%-- 
    Document   : DangKyBS.jsp
    Created on : Mar 22, 2025, 11:44:55 AM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký tài khoản bác sĩ</title>
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

            .form-group input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
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

            .alert-success {
                background-color: #dff0d8;
                border-color: #d6e9c6;
                color: #3c763d;
            }

            .password-error {
                color: #a94442;
                font-size: 14px;
                margin-top: 5px;
                display: none;
            }
        </style>
    </head>
    <body>
        <% if (AuthUtils.isBoss(session)) { %>
        <jsp:include page="header.jsp"/>
        
        <div class="container">
            <div class="form-container">
                <h2 class="form-title">Đăng ký tài khoản bác sĩ</h2>

                <div id="errorAlert" class="alert alert-error">
                    ${error}
                </div>

                <div id="messageAlert" class="alert alert-success">
                    ${message}
                </div>

                <form action="MainController" method="POST" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="addNewAccountBS">

                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <input type="text" id="username" name="username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="password" required>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                        <div id="passwordError" class="password-error">Mật khẩu không trùng khớp!</div>
                    </div>

                    <div class="form-group">
                        <label for="name">Họ và tên</label>
                        <input type="text" id="name" name="name" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="text" id="email" name="email" required>
                    </div>
                    
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">Đăng ký</button>
                        <a href="index.jsp" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

        <script>
            // Check if there's an error or success message and show the appropriate alert
            window.onload = function() {
                var errorMessage = '${error}';
                var successMessage = '${message}';
                
                if (errorMessage && errorMessage.trim() !== '') {
                    document.getElementById('errorAlert').style.display = 'block';
                }
                
                if (successMessage && successMessage.trim() !== '') {
                    document.getElementById('messageAlert').style.display = 'block';
                }
            };

            // Password validation
            function validateForm() {
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var passwordError = document.getElementById("passwordError");

                if (password !== confirmPassword) {
                    passwordError.style.display = "block";
                    return false;
                } else {
                    passwordError.style.display = "none";
                    return true;
                }
            }
        </script>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html>
