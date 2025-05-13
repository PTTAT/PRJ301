<%-- 
    Document   : projectForm
    Created on : Mar 3, 2025, 3:40:09 PM
    Author     : trana
--%>

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
    </head>
    <body>


        <div>
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
                // get error information
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

                    <div>
                        <label for="txtProjectID">Project ID:</label>
                        <input type="text" id="txtProjectID" name="txtProjectID" value="<%=project.getProject_id()%>"/>
                        <% if (!txtProjectID_error.isEmpty()) {%>
                        <div class="error-message"><%=txtProjectID_error%></div>
                        <% }%>
                    </div>

                    <div >
                        <label for="txtProjectName">Project Name</label>
                        <input type="text" id="txtProjectName" name="txtProjectName" value="<%=project.getProject_name()%>"/>
                        <% if (!txtProjectName_error.isEmpty()) {%>
                        <div class="error-message"><%=txtProjectName_error%></div>
                        <% }%>
                    </div>

                    <div>
                        <label for="txtDescription=">Description</label>
                        <input type="text" id="txtDescription" name="txtDescription" value="<%=project.getDescription()%>"/>
                        <% if (!txtDescription_error.isEmpty()) {%>
                        <div class="error-message"><%=txtDescription_error%></div>
                        <% }%>
                    </div>

                    <div>
                        <label for="txtStatus">Status</label>
                        <select id="txtStatus" name="txtStatus" class="form-control">
                            <option value="Ideation" <%= "Ideation".equals(project.getStatus()) ? "selected" : ""%>>Ideation</option>
                            <option value="Development" <%= "Development".equals(project.getStatus()) ? "selected" : ""%>>Development</option>
                            <option value="Launch" <%= "Launch".equals(project.getStatus()) ? "selected" : ""%>>Launch</option>
                            <option value="Scaling" <%= "Scaling".equals(project.getStatus()) ? "selected" : ""%>>Scaling</option>
                        </select>
                    </div>



                    <div>
                        <label for="txtEstimatedLaunch">Estimated Launch:</label>
                        <input type="date" id="txtEstimatedLaunch" name="txtEstimatedLaunch" value="<%=project.getEstimated_launch()%>"/>
                        <% if (!txtEstimatedLaunch_error.isEmpty()) {%>
                        <div class="error-message"><%=txtEstimatedLaunch_error%></div>
                        <% }%>
                    </div>        

                    <div>
                        <input type="submit" value="Save" />
                        <input type="reset" value="Reset"/>
                    </div>
                </form>

                <a href="MainController?action=search" class="back-link">Back to Project List</a>
            </div>
            <%} else {%>
            <div >
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
