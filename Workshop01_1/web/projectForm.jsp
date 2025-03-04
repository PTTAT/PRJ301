<%@page import="utils.AuthUtils"%>
<%@page import="dto.UserDTO"%>
<%@page import="dto.ProjectDTO"%>
<%@page import="java.awt.print.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Project Management</title>
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
                max-width: 800px;
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
            
            .form-group {
                margin-bottom: 20px;
            }
            
            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }
            
            input[type="text"],
            input[type="date"],
            select {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }
            
            input[type="text"]:focus,
            input[type="date"]:focus,
            select:focus {
                outline: none;
                border-color: #4a90e2;
                box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
            }
            
            .button-group {
                display: flex;
                gap: 10px;
                margin-top: 30px;
            }
            
            input[type="submit"],
            input[type="reset"] {
                padding: 12px 24px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            
            input[type="submit"] {
                background-color: #4a90e2;
                color: white;
                flex: 1;
            }
            
            input[type="submit"]:hover {
                background-color: #357abd;
            }
            
            input[type="reset"] {
                background-color: #e0e0e0;
                color: #333;
                flex: 1;
            }
            
            input[type="reset"]:hover {
                background-color: #d0d0d0;
            }
            
            .error-message {
                color: #dc3545;
                font-size: 14px;
                margin-top: 5px;
            }
            
            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: #4a90e2;
                text-decoration: none;
                font-weight: 500;
            }
            
            .back-link:hover {
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
        </style>
    </head>
    <body>
        <div class="container">
            <% if (AuthUtils.isLoggedIn(session)) {
                    UserDTO user = AuthUtils.getUser(session);
                    if (AuthUtils.isAdmin(session)) {
            %>
            <%
                ProjectDTO project = new ProjectDTO();
                try {
                    project = (ProjectDTO) request.getAttribute("project");
                } catch (Exception e) {
                    project = new ProjectDTO();
                }
                if (project == null) {
                    project = new ProjectDTO();
                }
                String txtProjectID_error = request.getAttribute("txtProjectID_error") + "";
                txtProjectID_error = txtProjectID_error.equals("null") ? "" : txtProjectID_error;
                String txtProjectName_error = request.getAttribute("txtProjectName_error") + "";
                txtProjectName_error = txtProjectName_error.equals("null") ? "" : txtProjectName_error;
                String txtDescription_error = request.getAttribute("txtDescription_error") + "";
                txtDescription_error = txtDescription_error.equals("null") ? "" : txtDescription_error;
                String txtEstimatedLaunch_error = request.getAttribute("txtEstimatedLaunch_error") + "";
                txtEstimatedLaunch_error = txtEstimatedLaunch_error.equals("null") ? "" : txtEstimatedLaunch_error;
            %>
            <div>
                <h1>Project Information</h1>
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="add"/>

                    <div class="form-group">
                        <label for="txtProjectID">Project ID:</label>
                        <input type="text" id="txtProjectID" name="txtProjectID" value="<%=project.getProject_id()%>"/>
                        <% if (!txtProjectID_error.isEmpty()) {%>
                        <div class="error-message"><%=txtProjectID_error%></div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="txtProjectName">Project Name</label>
                        <input type="text" id="txtProjectName" name="txtProjectName" value="<%=project.getProject_name()%>"/>
                        <% if (!txtProjectName_error.isEmpty()) {%>
                        <div class="error-message"><%=txtProjectName_error%></div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="txtDescription">Description</label>
                        <input type="text" id="txtDescription" name="txtDescription" value="<%=project.getDescription()%>"/>
                        <% if (!txtDescription_error.isEmpty()) {%>
                        <div class="error-message"><%=txtDescription_error%></div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="txtStatus">Status</label>
                        <select id="txtStatus" name="txtStatus">
                            <option value="Ideation" <%= "Ideation".equals(project.getStatus()) ? "selected" : ""%>>Ideation</option>
                            <option value="Development" <%= "Development".equals(project.getStatus()) ? "selected" : ""%>>Development</option>
                            <option value="Launch" <%= "Launch".equals(project.getStatus()) ? "selected" : ""%>>Launch</option>
                            <option value="Scaling" <%= "Scaling".equals(project.getStatus()) ? "selected" : ""%>>Scaling</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="txtEstimatedLaunch">Estimated Launch:</label>
                        <input type="date" id="txtEstimatedLaunch" name="txtEstimatedLaunch" value="<%=project.getEstimated_launch()%>"/>
                        <% if (!txtEstimatedLaunch_error.isEmpty()) {%>
                        <div class="error-message"><%=txtEstimatedLaunch_error%></div>
                        <% }%>
                    </div>        

                    <div class="button-group">
                        <input type="submit" value="Save" />
                        <input type="reset" value="Reset"/>
                    </div>
                </form>

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