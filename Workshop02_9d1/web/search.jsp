<%-- 
    Document   : search
    Created on : Feb 28, 2025, 3:45:52 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="dto.ExamDTO"%>
<%@page import="java.awt.print.Book"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Search</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            h1 {
                color: #333;
                margin: 0;
            }

            .logout-btn {
                background-color: #f44336;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                transition: background-color 0.3s;
            }

            .logout-btn:hover {
                background-color: #da190b;
            }

            .search-section {
                margin-bottom: 30px;
                display: flex;
                gap: 10px;
            }

            .search-section input[type="text"] {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                flex: 1;
                font-size: 16px;
            }

            .search-section input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .search-section input[type="submit"]:hover {
                background-color: #45a049;
            }

            .add-btn {
                display: inline-block;
                background-color: #2196F3;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 4px;
                margin-bottom: 20px;
                transition: background-color 0.3s;
            }

            .add-btn:hover {
                background-color: #1976D2;
            }

            .book-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .book-table th {
                background-color: #4CAF50;
                color: white;
                padding: 12px;
                text-align: left;
            }

            .book-table td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            .book-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .book-table tr:hover {
                background-color: #f5f5f5;
            }

            .action-icon {
                height: 25px;
                cursor: pointer;
                transition: transform 0.2s;
            }

            .action-icon:hover {
                transform: scale(1.1);
            }

            .action-link {
                text-decoration: none;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .header {
                    flex-direction: column;
                    gap: 15px;
                }

                .search-section {
                    flex-direction: column;
                }

                .book-table {
                    display: block;
                    overflow-x: auto;
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
            <% if (AuthUtils.isLoggedIn(session)) {
            %>   
            <%
                String searchTerm = request.getAttribute("searchTerm") + "";
                searchTerm = searchTerm.equals("null") ? "" : searchTerm;
            %>
            <div class="search-section">
                <form action="MainController">
                    <input type="hidden" name="action" value="searchCategory"/>
                    Search Category: <input type="text" name="searchTerm" value="<%=searchTerm%>"/>
                    <input type="submit" value="search"/>
                </form>
            </div>
            

            <%}%>

            <% if (AuthUtils.isAdmin(session)) {
            %>   
            <%
                String searchTerm = request.getAttribute("searchTerm") + "";
                searchTerm = searchTerm.equals("null") ? "" : searchTerm;
            %>
            <a href="examForm.jsp" class="add-btn">
                Add New Exam    
            </a> 
                <br>

            <%}%>
            
            <%
                if (request.getAttribute("category") != null) {
                    List<ExamDTO> category = (List<ExamDTO>) request.getAttribute("category");

            %>   

            <table class="book-table">
                <thead>
                    <tr>
                        
                        <th>Category Name</th>
                        <th>Description</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%            for (ExamDTO b : category) {
                    %>
                    <tr>
                       
                        <td><%=b.getCategory_name()%></td>
                        <td><%=b.getDescription()%></td>
                        
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } else { %>
            You do not have permission to access this content.
            <%}%>
        </div>
    </body>
</html>
