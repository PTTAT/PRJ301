<%-- 
    Document   : questionForm
    Created on : Mar 3, 2025, 3:40:09 PM
    Author     : trana
--%>

<%@page import="dto.NewQuestionDTO"%>
<%@page import="utils.AuthUtils"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Question</title>
        <style>
            .success-message {
                background-color: #d4edda;
                border-color: #c3e6cb;
                color: #155724;
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 4px;
            }
            
            .error-message {
                background-color: #f8d7da;
                border-color: #f5c6cb;
                color: #721c24;
                padding: 10px;
                margin: 5px 0;
                border: 1px solid transparent;
                border-radius: 4px;
            }
            
            .form-container {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
            }
            
            .form-group {
                margin-bottom: 15px;
            }
            
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            
            input[type="text"], textarea, select {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            
            .button-group {
                margin-top: 20px;
            }
            
            input[type="submit"], input[type="reset"] {
                padding: 10px 20px;
                margin-right: 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            
            input[type="submit"] {
                background-color: #28a745;
                color: white;
            }
            
            input[type="reset"] {
                background-color: #6c757d;
                color: white;
            }
            
            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: #007bff;
                text-decoration: none;
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
                NewQuestionDTO newQuestion = new NewQuestionDTO();
                try {
                    newQuestion = (NewQuestionDTO) request.getAttribute("newQuestion");
                } catch (Exception e) {
                    newQuestion = new NewQuestionDTO();
                }
                if (newQuestion == null) {
                    newQuestion = new NewQuestionDTO();
                }
                
                String question_text_error = request.getAttribute("question_text_error") + "";
                question_text_error = question_text_error.equals("null") ? "" : question_text_error;
                
                String option_a_error = request.getAttribute("option_a_error") + "";
                option_a_error = option_a_error.equals("null") ? "" : option_a_error;
                
                String option_b_error = request.getAttribute("option_b_error") + "";
                option_b_error = option_b_error.equals("null") ? "" : option_b_error;
                
                String option_c_error = request.getAttribute("option_c_error") + "";
                option_c_error = option_c_error.equals("null") ? "" : option_c_error;
                
                String option_d_error = request.getAttribute("option_d_error") + "";
                option_d_error = option_d_error.equals("null") ? "" : option_d_error;
                
                String correct_option_error = request.getAttribute("correct_option_error") + "";
                correct_option_error = correct_option_error.equals("null") ? "" : correct_option_error;
                
                String success_message = request.getAttribute("success_message") + "";
                success_message = success_message.equals("null") ? "" : success_message;
                
                String error_message = request.getAttribute("error_message") + "";
                error_message = error_message.equals("null") ? "" : error_message;
            %>
            <div class="form-container">
                <h1>Add New Question</h1>
                
                <% if (!success_message.isEmpty()) { %>
                <div class="success-message">
                    <%= success_message %>
                </div>
                <% } %>
                
                <% if (!error_message.isEmpty()) { %>
                <div class="error-message">
                    <%= error_message %>
                </div>
                <% } %>
                
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="addQuestion"/>
                    <input type="hidden" name="exam_id" value="${param.exam_id}"/>

                    <div class="form-group">
                        <label for="question_text">Question Text:</label>
                        <textarea id="question_text" name="question_text" rows="4" cols="50"><%=newQuestion.getQuestion_text()%></textarea>
                        <% if (!question_text_error.isEmpty()) {%>
                        <div class="error-message"><%=question_text_error%></div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="option_a">Option A:</label>
                        <input type="text" id="option_a" name="option_a" value="<%=newQuestion.getOption_a()%>"/>
                        <% if (!option_a_error.isEmpty()) {%>
                        <div class="error-message"><%=option_a_error%></div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="option_b">Option B:</label>
                        <input type="text" id="option_b" name="option_b" value="<%=newQuestion.getOption_b()%>"/>
                        <% if (!option_b_error.isEmpty()) {%>
                        <div class="error-message"><%=option_b_error%></div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="option_c">Option C:</label>
                        <input type="text" id="option_c" name="option_c" value="<%=newQuestion.getOption_c()%>"/>
                        <% if (!option_c_error.isEmpty()) {%>
                        <div class="error-message"><%=option_c_error%></div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="option_d">Option D:</label>
                        <input type="text" id="option_d" name="option_d" value="<%=newQuestion.getOption_d()%>"/>
                        <% if (!option_d_error.isEmpty()) {%>
                        <div class="error-message"><%=option_d_error%></div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="correct_option">Correct Option:</label>
                        <select id="correct_option" name="correct_option">
                            <option value="A" <%=newQuestion.getCorrect_option().equals("A") ? "selected" : ""%>>A</option>
                            <option value="B" <%=newQuestion.getCorrect_option().equals("B") ? "selected" : ""%>>B</option>
                            <option value="C" <%=newQuestion.getCorrect_option().equals("C") ? "selected" : ""%>>C</option>
                            <option value="D" <%=newQuestion.getCorrect_option().equals("D") ? "selected" : ""%>>D</option>
                        </select>
                        <% if (!correct_option_error.isEmpty()) {%>
                        <div class="error-message"><%=correct_option_error%></div>
                        <% }%>
                    </div>

                    <div class="button-group">
                        <input type="submit" value="Save Question" />
                        <input type="reset" value="Reset"/>
                    </div>
                </form>

                <a href="MainController?action=search" class="back-link">Back to Exam List</a>
            </div>
            <%} else {%>
            <div>
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
