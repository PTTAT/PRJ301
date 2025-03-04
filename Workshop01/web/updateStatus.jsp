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
            .message {
                padding: 10px;
                margin: 10px 0;
                border-radius: 4px;
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
            .form-container {
                max-width: 500px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            select, input[type="submit"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            input[type="submit"] {
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #0056b3;
            }
            .back-link {
                display: block;
                text-align: center;
                margin-top: 15px;
                color: #007bff;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
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
                        <br/>
                        <a href="MainController?action=search" class="back-link">Back to Project List</a>
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
                        <label for="projectId">Project ID:</label>
                        <input type="number" id="projectId" name="projectId" required />
                    </div>

                    <div class="form-group">
                        <label for="status">New Status:</label>
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

                <% if (successMessage != null) { %>
                    <div class="message success">
                        <%= successMessage %>
                        <br/>
                        <a href="MainController?action=search" class="back-link">Back to Project List</a>
                    </div>
                <% } else { %>
                    <a href="MainController?action=search" class="back-link">Back to Project List</a>
                <% } %>
            <%} else {%>
                <div>
                    <h1>403 Error</h1>
                    <p>You do not have permission to access this content!</p>
                    <a href="MainController?action=search" class="back-link">Back to Project List</a>
                </div>
            <%}
            } else {%>
                <div>
                    <h1>Access Denied</h1>
                    <p>Please log in to access this page.</p>
                    <a href="login.jsp" class="back-link">Go to Login</a>
                </div>
            <%}%>
        </div>
    </body>
</html> 