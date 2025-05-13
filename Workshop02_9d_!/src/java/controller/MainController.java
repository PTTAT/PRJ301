/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import dto.*;
import dto.UserDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AuthUtils;

/**
 *
 * @author trana
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private ExamDAO examDAO = new ExamDAO();
    private ExamCategoryDAO examCategoryDAO = new ExamCategoryDAO();

    private static final String LOGIN_PAGE = "login.jsp";

    private String login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        //
        String strUserID = request.getParameter("txtUserID");
        String strPassword = request.getParameter("txtPassword");
        if (AuthUtils.isValidLogin(strUserID, strPassword)) {
            url = "search.jsp";
            UserDTO user = AuthUtils.getUser(strUserID);
            request.getSession().setAttribute("user", user);

            // search
            search(request, response);
        } else {
            request.setAttribute("message", "Incorrect UserID or Password");
            url = "login.jsp";
        }
        //
        return url;
    }

    private String logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        //
        HttpSession session = request.getSession();
        if (AuthUtils.isLoggedIn(session)) {
            request.getSession().invalidate(); // Hủy bỏ session
            url = "login.jsp";
        }
        //
        return url;
    }

    //search
    public String search(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isLoggedIn(session)) {
            // search
            String searchTerm = request.getParameter("searchTerm");
            if (searchTerm == null) {
                searchTerm = "";
            }
            List<ExamDTO> category = examDAO.searchByTitle(searchTerm);
            request.setAttribute("category", category);
            request.setAttribute("searchTerm", searchTerm);
            url = "search.jsp";
        }
        return url;
    }

    public String searchCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isLoggedIn(session)) {
            // search
            String searchTerm = request.getParameter("searchTerm");
            if (searchTerm == null) {
                searchTerm = "";
            }
            List<ExamCategoryDTO> category = examCategoryDAO.search(searchTerm);
            request.setAttribute("category", category);
            request.setAttribute("searchTerm", searchTerm);
            url = "searchCategory.jsp";
        }
        return url;
    }

    public String add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isAdmin(session)) {
            try {
                boolean checkError = false;

                String examTitle = request.getParameter("txtExamTitle");
                String subject = request.getParameter("txtSubject");
                String categoryName = request.getParameter("txtCategoryName");
                String totalMarksStr = request.getParameter("txtTotalMarks");
                String durationStr = request.getParameter("txtDuration");

                if (examTitle == null || examTitle.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("txtExamTitle_error", "Exam Title cannot be empty.");
                }

                if (subject == null || subject.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("txtSubject_error", "Subject cannot be empty.");
                }

                if (categoryName == null || categoryName.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("txtCategoryName_error", "Category Name cannot be empty.");
                }

                int totalMarks = Integer.parseInt(totalMarksStr);
                if (totalMarks <= 0) {
                    checkError = true;
                    request.setAttribute("txtTotalMarks_error", "Total Marks must be greater than 0");
                }

                int duration = Integer.parseInt(durationStr);
                if (duration <= 0) {
                    checkError = true;
                    request.setAttribute("txtDuration_error", "Duration must be greater than 0");
                }

                if (!checkError) {
                    ExamCategoryDTO newExam = new ExamCategoryDTO(0, examTitle, subject, categoryName, totalMarks, duration);

                    if (examCategoryDAO.create(newExam)) {
                        // Search after successful creation
                        search(request, response);
                        url = "search.jsp";
                    } else {
                        request.setAttribute("error_message", "Failed to create exam. Please try again.");
                        url = "examForm.jsp";
                        request.setAttribute("newExam", newExam);
                    }
                } else {
                    url = "examForm.jsp";
                    ExamCategoryDTO newExam = new ExamCategoryDTO(0,
                            examTitle != null ? examTitle : "",
                            subject != null ? subject : "",
                            categoryName != null ? categoryName : "",
                            totalMarksStr != null && !totalMarksStr.isEmpty() ? Integer.parseInt(totalMarksStr) : 0,
                            durationStr != null && !durationStr.isEmpty() ? Integer.parseInt(durationStr) : 0);
                    request.setAttribute("newExam", newExam);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error_message", "An error occurred. Please try again.");
                url = "examForm.jsp";
            }
        }
        return url;
    }

    public String addQuestion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isAdmin(session)) {
            try {
                boolean checkError = false;

                String examIdStr = request.getParameter("exam_id");
                String questionText = request.getParameter("question_text");
                String optionA = request.getParameter("option_a");
                String optionB = request.getParameter("option_b");
                String optionC = request.getParameter("option_c");
                String optionD = request.getParameter("option_d");
                String correctOption = request.getParameter("correct_option");

                if (questionText == null || questionText.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("question_text_error", "Question text cannot be empty.");
                }

                if (optionA == null || optionA.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("option_a_error", "Option A cannot be empty.");
                }

                if (optionB == null || optionB.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("option_b_error", "Option B cannot be empty.");
                }

                if (optionC == null || optionC.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("option_c_error", "Option C cannot be empty.");
                }

                if (optionD == null || optionD.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("option_d_error", "Option D cannot be empty.");
                }

                if (correctOption == null || correctOption.trim().isEmpty()) {
                    checkError = true;
                    request.setAttribute("correct_option_error", "Please select the correct option.");
                }

                int examId = Integer.parseInt(examIdStr);

                if (!checkError) {
                    NewQuestionDTO newQuestion = new NewQuestionDTO(0, examId, questionText, optionA, optionB, optionC, optionD, correctOption);
                    NewQuestionDAO questionDAO = new NewQuestionDAO();

                    if (questionDAO.create(newQuestion)) {
                        // Set success message
                        request.setAttribute("success_message", "Question added successfully!");
                        url = "questionForm.jsp?exam_id=" + examId;
                    } else {
                        request.setAttribute("error_message", "Failed to add question. Please try again.");
                        url = "questionForm.jsp";
                        request.setAttribute("newQuestion", newQuestion);
                    }
                } else {
                    url = "questionForm.jsp";
                    NewQuestionDTO newQuestion = new NewQuestionDTO(0, examId, 
                            questionText != null ? questionText : "",
                            optionA != null ? optionA : "",
                            optionB != null ? optionB : "",
                            optionC != null ? optionC : "",
                            optionD != null ? optionD : "",
                            correctOption != null ? correctOption : "");
                    request.setAttribute("newQuestion", newQuestion);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error_message", "An error occurred. Please try again.");
                url = "questionForm.jsp";
            }
        }
        return url;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            String action = request.getParameter("action");
            System.out.println("action: " + action);
            if (action == null) {
                url = LOGIN_PAGE;
            } else {
                if (action.equals("login")) {
                    url = login(request, response);
                } else if (action.equals("logout")) {
                    url = logout(request, response);
                } else if (action.equals("search")) {
                    url = search(request, response);
                } else if (action.equals("searchCategory")) {
                    url = searchCategory(request, response);
                } else if (action.equals("add")) {
                    url = add(request, response);
                } else if (action.equals("addQuestion")) {
                    url = addQuestion(request, response);
                } 
            }

        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
