<%-- 
    Document   : login
    Created on : Feb 28, 2025, 3:38:32 PM
    Author     : trana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .login-container {
                background-color: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }

            .login-form {
                text-align: center;
            }

            .form-title {
                color: #333;
                margin-bottom: 30px;
                font-size: 24px;
            }

            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: bold;
            }

            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }

            .submit-btn {
                background-color: #4CAF50;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            .submit-btn:hover {
                background-color: #45a049;
            }

            .error-message {
                color: #f44336;
                margin-top: 10px;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-form">
                <h2 class="form-title">Đăng nhập</h2>
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="login" />

                    <div class="form-group">
                        <label for="userId">Tên đăng nhập</label>
                        <input type="text" id="userId" name="txtUserID" required />
                    </div>

                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="txtPassword" required />
                    </div>

                    <button type="submit" class="submit-btn">Đăng nhập</button>
                    
                    <%
                        String message = request.getAttribute("message")+"";
                    %>
                    <%=message.equals("null")?"":message%>
                </form>
            </div>
        </div>
    </body>
</html>
