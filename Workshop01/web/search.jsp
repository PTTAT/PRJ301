<%-- 
    Document   : search
    Created on : Feb 28, 2025, 3:45:52 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="dto.ProjectDTO"%>
<%@page import="java.awt.print.Book"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <style>
            .book-table {
                width: 100%;
                border-collapse: collapse;
                margin: 25px 0;
                font-size: 14px;
                font-family: Arial, sans-serif;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }

            .book-table thead th {
                background-color: #009879;
                color: #ffffff;
                text-align: left;
                font-weight: bold;
                padding: 12px 15px;
            }

            .book-table tbody tr {
                border-bottom: 1px solid #dddddd;
            }

            .book-table tbody tr:nth-of-type(even) {
                background-color: #f3f3f3;
            }

            .book-table tbody tr:last-of-type {
                border-bottom: 2px solid #009879;
            }

            .book-table tbody td {
                padding: 12px 15px;
            }

            .book-table tbody tr:hover {
                background-color: #f5f5f5;
                transition: 0.3s ease;
            }

            /* Responsive design */
            @media screen and (max-width: 600px) {
                .book-table {
                    font-size: 12px;
                }

                .book-table thead th,
                .book-table tbody td {
                    padding: 8px 10px;
                }
            }
        </style> 
    </head>
    <body>
        <div style="min-height: 500px; padding: 10px">
            <%                if (session.getAttribute("user") != null) {
                    UserDTO user = (UserDTO) session.getAttribute("user");
            %>
            <h1> Welcome <%=user.getName()%> </h1>
            <form action="MainController">
                <input type="hidden" name="action" value="logout"/>
                <input type="submit" value="Logout"/>
            </form>
            <br/>
              <% if (AuthUtils.isAdmin(session)) {
            %>   
            <%
                String searchTerm = request.getAttribute("searchTerm") + "";
                searchTerm = searchTerm.equals("null") ? "" : searchTerm;
            %>
            <div class="search-section">
            <form action="MainController">
                <input type="hidden" name="action" value="search"/>
                Search Projects: <input type="text" name="searchTerm" value="<%=searchTerm%>"/>
                <input type="submit" value="Search"/>
            </form>
                </div>
                
            <a href="projectForm.jsp" class="add-btn">
                Add New Project    
            </a> 
                <br>
            <a href="updateStatus.jsp" class="add-btn">
                Update Status   
            </a>
            <%}%>
            
             <%
                if (request.getAttribute("projects") != null) {
                    List<ProjectDTO> projects = (List<ProjectDTO>) request.getAttribute("projects");

            %>   
            
            <table class="book-table">
                <thead>
                    <tr>
                        <th>Project Id</th>
                        <th>Project Name</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Estimated Launch</th>
                    </tr>
                </thead>
                <tbody>
                    <%            for (ProjectDTO b : projects) {
                    %>
                    <tr>
                        <td><%=b.getProject_id()%></td>
                        <td><%=b.getProject_name()%></td>
                        <td><%=b.getDescription()%></td>
                        <td><%=b.getStatus()%></td>
                        <td><%=b.getEstimated_launch()%></td>
                                                    
                    </tr>
                    <%
                        }
                    %>
                </tbody>
                </table>
            <%    
            }} else { %>
            You do not have permission to access this content.
            <%}%>
        </div>
    </body>
</html>
