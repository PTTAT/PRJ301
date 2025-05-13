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
        <title>Project Management - Search</title>
        
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
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }
            
            h1 {
                color: #333;
                margin-bottom: 30px;
                font-size: 28px;
            }
            
            .header-section {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }
            
            .logout-form {
                margin-left: auto;
            }
            
            .search-section {
                margin-bottom: 30px;
                display: flex;
                gap: 10px;
                align-items: center;
            }
            
            .search-section input[type="text"] {
                flex: 1;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }
            
            .search-section input[type="text"]:focus {
                outline: none;
                border-color: #4a90e2;
                box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
            }
            
            .button {
                padding: 12px 24px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            
            .primary-button {
                background-color: #4a90e2;
                color: white;
            }
            
            .primary-button:hover {
                background-color: #357abd;
            }
            
            .secondary-button {
                background-color: #e0e0e0;
                color: #333;
            }
            
            .secondary-button:hover {
                background-color: #d0d0d0;
            }
            
            .action-buttons {
                display: flex;
                gap: 10px;
                margin-bottom: 30px;
            }
            
            .action-link {
                display: inline-block;
                padding: 12px 24px;
                background-color: #4a90e2;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-weight: 600;
                transition: background-color 0.3s ease;
            }
            
            .action-link:hover {
                background-color: #357abd;
            }

            .book-table {
                width: 100%;
                border-collapse: collapse;
                margin: 25px 0;
                font-size: 14px;
                background: white;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            .book-table thead th {
                background-color: #4a90e2;
                color: #ffffff;
                text-align: left;
                font-weight: 600;
                padding: 15px;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .book-table tbody tr {
                border-bottom: 1px solid #f0f0f0;
            }

            .book-table tbody tr:nth-of-type(even) {
                background-color: #f8f9fa;
            }

            .book-table tbody tr:last-of-type {
                border-bottom: none;
            }

            .book-table tbody td {
                padding: 15px;
                color: #333;
            }

            .book-table tbody tr:hover {
                background-color: #f5f5f5;
                transition: 0.3s ease;
            }
            
            .error-message {
                text-align: center;
                padding: 40px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                color: #dc3545;
                font-size: 18px;
            }

            @media screen and (max-width: 768px) {
                .container {
                    padding: 20px;
                }
                
                .header-section {
                    flex-direction: column;
                    gap: 20px;
                    text-align: center;
                }
                
                .logout-form {
                    margin: 0;
                }
                
                .search-section {
                    flex-direction: column;
                }
                
                .action-buttons {
                    flex-direction: column;
                }
                
                .book-table {
                    font-size: 12px;
                }

                .book-table thead th,
                .book-table tbody td {
                    padding: 10px;
                }
            }
        </style> 
    </head>
    <body>
        <div class="container">
            <%                if (session.getAttribute("user") != null) {
                    UserDTO user = (UserDTO) session.getAttribute("user");
            %>
            <div class="header-section">
                <h1>Welcome, <%=user.getName()%></h1>
                <form action="MainController" class="logout-form">
                    <input type="hidden" name="action" value="logout"/>
                    <input type="submit" value="Logout" class="button secondary-button"/>
                </form>
            </div>
            
            <% if (AuthUtils.isAdmin(session)) {
            %>   
            <%
                String searchTerm = request.getAttribute("searchTerm") + "";
                searchTerm = searchTerm.equals("null") ? "" : searchTerm;
            %>
            <div class="search-section">
                <form action="MainController" style="width: 100%; display: flex; gap: 10px;">
                    <input type="hidden" name="action" value="search"/>
                    <input type="text" name="searchTerm" value="<%=searchTerm%>" placeholder="Search projects..."/>
                    <input type="submit" value="Search" class="button primary-button"/>
                </form>
            </div>
                
            <div class="action-buttons">
                <a href="projectForm.jsp" class="action-link">Add New Project</a>
                <a href="updateStatus.jsp" class="action-link">Update Status</a>
            </div>
            <%}%>
            
            <%
                if (request.getAttribute("projects") != null) {
                    List<ProjectDTO> projects = (List<ProjectDTO>) request.getAttribute("projects");
            %>   
            
            <table class="book-table">
                <thead>
                    <tr>
                        <th>Project ID</th>
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
            <div class="error-message">
                You do not have permission to access this content.
            </div>
            <%}%>
        </div>
    </body>
</html>
