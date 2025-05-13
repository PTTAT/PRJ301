<%-- 
    Document   : ansQuestion
    Created on : Mar 12, 2025, 12:56:59 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="java.util.List"%>
<%@page import="dto.AnsQuestionDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Answer Questions</title>
        <style>
            .book-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            .book-table th, .book-table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            .book-table th {
                background-color: #f4f4f4;
            }
            .book-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .book-table tr:hover {
                background-color: #f5f5f5;
            }
            .radio-group {
                display: flex;
                gap: 20px;
            }
            .radio-option {
                display: flex;
                align-items: center;
                gap: 5px;
                padding: 5px 10px;
                border-radius: 4px;
            }
            .submit-btn {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                margin-top: 20px;
            }
            .submit-btn:hover {
                background-color: #45a049;
            }
            .score-display {
                margin: 20px 0;
                padding: 15px;
                background-color: #e8f5e9;
                border: 1px solid #c8e6c9;
                border-radius: 4px;
                font-size: 18px;
                color: #2e7d32;
            }
            .correct-answer {
                background-color: #c8e6c9;
            }
            .wrong-answer {
                background-color: #ffcdd2;
            }
            .back-link {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #2196F3;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }
            .back-link:hover {
                background-color: #1976D2;
            }
        </style>
    </head>
    <body>
        <%
            // Forward the request to MainController if coming directly to this page
            if (request.getParameter("action") == null) {
                String examId = request.getParameter("exam_id");
                if (examId != null && !examId.trim().isEmpty()) {
                    request.getRequestDispatcher("MainController?action=ansQuestion&exam_id=" + examId).forward(request, response);
                    return;
                }
            }
        %>
        
        <% if (AuthUtils.isUser(session)) { %>
            <% if (request.getAttribute("score") != null) { %>
                <div class="score-display">
                    Your score: <%= request.getAttribute("score") %>/<%= request.getAttribute("totalQuestions") %>
                    (<%= String.format("%.1f", ((Integer)request.getAttribute("score") * 100.0 / (Integer)request.getAttribute("totalQuestions"))) %>%)
                </div>
            <% } %>
            
            <form action="MainController" method="post">
                <input type="hidden" name="action" value="submitAnswers"/>
                <input type="hidden" name="exam_id" value="${param.exam_id}"/>
         
                <% if (request.getAttribute("ques") != null) {
                    List<AnsQuestionDTO> ques = (List<AnsQuestionDTO>) request.getAttribute("ques");
                    if (!ques.isEmpty()) {
                %>       
                <table class="book-table">
                    <thead>
                        <tr>
                            <th>Question</th>
                            <th>Options</th>
                            <% if (request.getAttribute("score") != null) { %>
                                <th>Correct Answer</th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (AnsQuestionDTO b : ques) { 
                            String userAnswer = request.getParameter("answer_" + b.getQuestion_id());
                        %>
                        <tr>
                            <td><%=b.getQuestion_text()%></td>
                            <td>
                                <div class="radio-group">
                                    <input type="hidden" name="question_id_<%=b.getQuestion_id()%>" value="<%=b.getQuestion_id()%>"/>
                                    <div class="radio-option <%= (userAnswer != null && userAnswer.equals("A")) ? (userAnswer.equals(b.getCorrect_option()) ? "correct-answer" : "wrong-answer") : "" %>">
                                        <input type="radio" id="optionA_<%=b.getQuestion_id()%>" 
                                               name="answer_<%=b.getQuestion_id()%>" value="A" required
                                               <%= (userAnswer != null && userAnswer.equals("A")) ? "checked" : "" %>
                                               <%= (request.getAttribute("score") != null) ? "disabled" : "" %>/>
                                        <label for="optionA_<%=b.getQuestion_id()%>"><%=b.getOption_a()%></label>
                                    </div>
                                    <div class="radio-option <%= (userAnswer != null && userAnswer.equals("B")) ? (userAnswer.equals(b.getCorrect_option()) ? "correct-answer" : "wrong-answer") : "" %>">
                                        <input type="radio" id="optionB_<%=b.getQuestion_id()%>" 
                                               name="answer_<%=b.getQuestion_id()%>" value="B"
                                               <%= (userAnswer != null && userAnswer.equals("B")) ? "checked" : "" %>
                                               <%= (request.getAttribute("score") != null) ? "disabled" : "" %>/>
                                        <label for="optionB_<%=b.getQuestion_id()%>"><%=b.getOption_b()%></label>
                                    </div>
                                    <div class="radio-option <%= (userAnswer != null && userAnswer.equals("C")) ? (userAnswer.equals(b.getCorrect_option()) ? "correct-answer" : "wrong-answer") : "" %>">
                                        <input type="radio" id="optionC_<%=b.getQuestion_id()%>" 
                                               name="answer_<%=b.getQuestion_id()%>" value="C"
                                               <%= (userAnswer != null && userAnswer.equals("C")) ? "checked" : "" %>
                                               <%= (request.getAttribute("score") != null) ? "disabled" : "" %>/>
                                        <label for="optionC_<%=b.getQuestion_id()%>"><%=b.getOption_c()%></label>
                                    </div>
                                    <div class="radio-option <%= (userAnswer != null && userAnswer.equals("D")) ? (userAnswer.equals(b.getCorrect_option()) ? "correct-answer" : "wrong-answer") : "" %>">
                                        <input type="radio" id="optionD_<%=b.getQuestion_id()%>" 
                                               name="answer_<%=b.getQuestion_id()%>" value="D"
                                               <%= (userAnswer != null && userAnswer.equals("D")) ? "checked" : "" %>
                                               <%= (request.getAttribute("score") != null) ? "disabled" : "" %>/>
                                        <label for="optionD_<%=b.getQuestion_id()%>"><%=b.getOption_d()%></label>
                                    </div>
                                </div>
                            </td>
                            <% if (request.getAttribute("score") != null) { %>
                                <td>
                                    Option <%= b.getCorrect_option() %>
                                </td>
                            <% } %>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <% if (request.getAttribute("score") == null) { %>
                    <input type="submit" value="Submit Answers" class="submit-btn"/>
                <% } %>
                
                <% } else { %>
                    <p>No questions available for this exam.</p>
                <% } %>
            <% } else { %>
                <p>No questions available.</p>
            <% } %>
            
            <div style="margin-top: 20px;">
                <a href="MainController?action=searchCategory" class="back-link">Back to Category List</a>
            </div>
        </form>
        <% } else { %>            
            <p>You do not have permission to access this content.</p>
        <% } %>
    </body>
</html>
