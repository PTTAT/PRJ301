<%@page import="utils.AuthUtils"%>
<%@page import="dto.UserDTO"%>
<%@page import="dto.ProjectDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Project Status</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                padding: 40px 20px;
            }
            
            .container {
                max-width: 600px;
                margin: 0 auto;
                background: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }
            
            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 30px;
                font-size: 28px;
            }
            
            .message {
                padding: 15px;
                margin: 20px 0;
                border-radius: 5px;
                font-size: 16px;
                text-align: center;
            }
            
            .success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            
            .error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            
            .form-group {
                margin-bottom: 20px;
            }
            
            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }
            
            input[type="number"],
            select {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }
            
            input[type="number"]:focus,
            select:focus {
                outline: none;
                border-color: #4a90e2;
                box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
            }
            
            input[type="submit"] {
                width: 100%;
                padding: 12px;
                background-color: #4a90e2;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            
            input[type="submit"]:hover {
                background-color: #357abd;
            }
            
            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: #4a90e2;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }
            
            .back-link:hover {
                color: #357abd;
                text-decoration: underline;
            }
            
            .error-container {
                text-align: center;
                padding: 40px;
            }
            
            .error-container h1 {
                color: #dc3545;
                margin-bottom: 20px;
            }
            
            .error-container p {
                color: #666;
                margin-bottom: 20px;
                font-size: 16px;
            }
            
            @media screen and (max-width: 768px) {
                .container {
                    padding: 20px;
                }
                
                h1 {
                    font-size: 24px;
                }
                
                .message {
                    padding: 12px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <% if (AuthUtils.isLoggedIn(session)) {
                UserDTO user = AuthUtils.getUser(session);
                if (AuthUtils.isAdmin(session)) {
                    String successMessage = (String) request.getAttribute("SUCCESS_MESSAGE");
                    String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
            %>
                <h1>Update Project Status</h1>
                
                <% if (successMessage != null) { %>
                    <div class="message success">
                        <%= successMessage %>
                    </div>
                <% } %>
                
                <% if (errorMessage != null) { %>
                    <div class="message error">
                        <%= errorMessage %>
                    </div>
                <% } %>

                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="update"/>
                    <div class="form-group">
                        <label for="projectId">Project ID</label>
                        <input type="number" id="projectId" name="projectId" required />
                    </div>

                    <div class="form-group">
                        <label for="status">New Status</label>
                        <select id="status" name="status" required>
                            <option value="Ideation">Ideation</option>
                            <option value="Development">Development</option>
                            <option value="Launch">Launch</option>
                            <option value="Scaling">Scaling</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <input type="submit" value="Update Status" />
                    </div>
                </form>

                <div style="text-align: center;">
                    <a href="MainController?action=search" class="back-link">Back to Project List</a>
                </div>
            <%} else {%>
                <div class="error-container">
                    <h1>403 Error</h1>
                    <p>You do not have permission to access this content!</p>
                    <a href="MainController?action=search" class="back-link">Back to Project List</a>
                </div>
            <%}
            } else {%>
                <div class="error-container">
                    <h1>Access Denied</h1>
                    <p>Please log in to access this page.</p>
                    <a href="login.jsp" class="back-link">Go to Login</a>
                </div>
            <%}%>
        </div>
    </body>
</html> 