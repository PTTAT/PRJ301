<%-- 
    Document   : ansQuestion
    Created on : Mar 12, 2025, 12:56:59 PM
    Author     : trana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Answer Questions</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>Answer Questions</h1>
                <div>
                    <span class="me-3">Welcome, ${sessionScope.user.userID}</span>
                    <a href="MainController?action=logout" class="btn btn-danger">Logout</a>
                </div>
            </div>
            
            <c:if test="${not empty error_message}">
                <div class="alert alert-danger" role="alert">
                    ${error_message}
                </div>
            </c:if>

            <c:if test="${empty questions}">
                <div class="alert alert-warning" role="alert">
                    No questions available for this exam.
                </div>
            </c:if>

            <c:if test="${not empty questions}">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="submitAnswers">
                    <input type="hidden" name="exam_id" value="${exam_id}">
                    
                    <c:forEach items="${questions}" var="question" varStatus="status">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Question ${status.index + 1}</h5>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="answer_${question.question_id}" 
                                           id="optionA_${question.question_id}" value="A" required>
                                    <label class="form-check-label" for="optionA_${question.question_id}">
                                        A. ${question.option_a}
                                    </label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="answer_${question.question_id}" 
                                           id="optionB_${question.question_id}" value="B" required>
                                    <label class="form-check-label" for="optionB_${question.question_id}">
                                        B. ${question.option_b}
                                    </label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="answer_${question.question_id}" 
                                           id="optionC_${question.question_id}" value="C" required>
                                    <label class="form-check-label" for="optionC_${question.question_id}">
                                        C. ${question.option_c}
                                    </label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="answer_${question.question_id}" 
                                           id="optionD_${question.question_id}" value="D" required>
                                    <label class="form-check-label" for="optionD_${question.question_id}">
                                        D. ${question.option_d}
                                    </label>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Submit Answers</button>
                        <a href="MainController?action=search" class="btn btn-secondary">Back to Search</a>
                    </div>
                </form>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
