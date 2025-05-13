<%-- 
    Document   : projectForm
    Created on : Mar 3, 2025, 3:40:09 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="dto.UserDTO"%>
<%@page import="dto.ExamCategoryDTO"%>
<%@page import="java.awt.print.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Exam Management</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }

            h1 {
                color: #333;
                margin-bottom: 30px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: bold;
            }

            input[type="text"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }

            .error-message {
                color: #f44336;
                font-size: 14px;
                margin-top: 5px;
            }

            .button-group {
                margin-top: 30px;
                text-align: center;
            }

            input[type="submit"], input[type="reset"] {
                padding: 12px 25px;
                margin: 0 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            input[type="reset"] {
                background-color: #f44336;
                color: white;
            }

            input[type="reset"]:hover {
                background-color: #da190b;
            }

            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: #2196F3;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            .error-page {
                text-align: center;
                padding: 50px;
            }

            .error-page h1 {
                color: #f44336;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>


        <div>
            <% if (AuthUtils.isLoggedIn(session)) {
                    UserDTO user = AuthUtils.getUser(session);
                    if (AuthUtils.isAdmin(session)) {
            %>
            <%
                ExamCategoryDTO newcategory = new ExamCategoryDTO();
                try {
                    newcategory = (ExamCategoryDTO) request.getAttribute("newcategory");
                } catch (Exception e) {
                    newcategory = new ExamCategoryDTO();
                }
                if (newcategory == null) {
                    newcategory = new ExamCategoryDTO();
                }
                // get error information
                String txtExamTitle_error = request.getAttribute("txtExamTitle_error") + "";
                txtExamTitle_error = txtExamTitle_error.equals("null") ? "" : txtExamTitle_error;

                String txtSubject_error = request.getAttribute("txtSubject_error") + "";
                txtSubject_error = txtSubject_error.equals("null") ? "" : txtSubject_error;

                String txtCategoryName_error = request.getAttribute("txtCategoryName_error") + "";
                txtCategoryName_error = txtCategoryName_error.equals("null") ? "" : txtCategoryName_error;

                String txtTotalMarks_error = request.getAttribute("txtTotalMarks_error") + "";
                txtTotalMarks_error = txtTotalMarks_error.equals("null") ? "" : txtTotalMarks_error;

                String txtDuration_error = request.getAttribute("txtDuration_error") + "";
                txtDuration_error = txtDuration_error.equals("null") ? "" : txtDuration_error;
            %>
            <div>
                <h1>Exam Information</h1>
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="add"/>

                    <div>
                        <label for="txtExamTitle">Exam Title:</label>
                        <input type="text" id="txtExamTitle" name="txtExamTitle" value="<%=newcategory.getExam_title()%>"/>
                        <% if (!txtExamTitle_error.isEmpty()) {%>
                        <div class="error-message"><%=txtExamTitle_error%></div>
                        <% }%>
                    </div>

                    <div >
                        <label for="txtSubject">Subject:</label>
                        <input type="text" id="txtSubject" name="txtSubject" value="<%=newcategory.getSubject()%>"/>
                        <% if (!txtSubject_error.isEmpty()) {%>
                        <div class="error-message"><%=txtSubject_error%></div>
                        <% }%>
                    </div>

                    <div>
                        <label for="txtCategoryName=">Category Name:</label>
                        <input type="text" id="txtCategoryName" name="txtCategoryName" value="<%=newcategory.getCategory_name()%>"/>
                        <% if (!txtCategoryName_error.isEmpty()) {%>
                        <div class="error-message"><%=txtCategoryName_error%></div>
                        <% }%>
                    </div>

                    <div>
                        <label for="txtTotalMarks">Total Marks:</label>
                        <input type="text" id="txtProjectID" name="txtTotalMarks" value="<%=newcategory.getTotal_marks()%>"/>
                        <% if (!txtTotalMarks_error.isEmpty()) {%>
                        <div class="error-message"><%=txtTotalMarks_error%></div>
                        <% }%>
                    </div>

                    <div>
                        <label for="txtDuration">Duration:</label>
                        <input type="text" id="txtDuration" name="txtDuration" value="<%=newcategory.getDuration()%>"/>
                        <% if (!txtDuration_error.isEmpty()) {%>
                        <div class="error-message"><%=txtDuration_error%></div>
                        <% }%>
                    </div>

                    <div>
                        <input type="submit" value="Save" />
                        <input type="reset" value="Reset"/>
                    </div>
                </form>

                <a href="MainController?action=search" class="back-link">Back to Exam List</a>
            </div>
            <%} else {%>
            <div >
                <h1>403 Error</h1>
                <p>You do not have permission to access this content!</p>
                <a href="MainController?action=search" class="back-link">Back to Exam List</a>
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
