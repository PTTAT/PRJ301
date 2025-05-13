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
    
//    public String add(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String url = LOGIN_PAGE;
//        HttpSession session = request.getSession();
//        if (AuthUtils.isAdmin(session)) {
//            try {
//                boolean checkError = false;
//
//                int projectID = Integer.parseInt(request.getParameter("txtProjectID"));
//                String projectName = request.getParameter("txtProjectName");
//                String description = request.getParameter("txtDescription");
//                String status = request.getParameter("txtStatus");
//                String estimatedLaunch = request.getParameter("txtEstimatedLaunch");
//
//                if (projectID <= 0) {
//                    checkError = true;
//                    request.setAttribute("txtProjectID_error", "Project ID > 0");
//                }
//
//                if (projectName == null || projectName.trim().isEmpty()) {
//                    checkError = true;
//                    request.setAttribute("txtProjectName_error", "Project Name cannot be empty.");
//                }
//
//                if (description == null || description.trim().isEmpty()) {
//                    checkError = true;
//                    request.setAttribute("txtDescription_error", "Description cannot be empty.");
//                }
//
//                if (status == null || status.trim().isEmpty()) {
//                    checkError = true;
//                    request.setAttribute("txtStatus_error", "Status cannot be empty.");
//                }
//
//                if (estimatedLaunch == null || estimatedLaunch.trim().isEmpty()) {
//                    checkError = true;
//                    request.setAttribute("txtEstimatedLaunch_error", "Estimated Launch cannot be empty.");
//                }
//
//                ExamDTO project = new ExamDTO(projectID, projectName, description, status, estimatedLaunch);
//
//                if (!checkError) {
//                    projectDAO.create(project);
//                    // search
//                    search(request, response);
//                    url = "search.jsp";
//                } else {
//                    url = "projectForm.jsp";
//                    request.setAttribute("project", project);
//                }
//            } catch (Exception e) {
//            }
//        }
//        return url;
//    }

//    public String update(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String url = LOGIN_PAGE;
//        HttpSession session = request.getSession();
//
//            if (AuthUtils.isAdmin(session)) {
//                try {
//                    int projectId = Integer.parseInt(request.getParameter("projectId"));
//                    String newStatus = request.getParameter("status");
//
//                    ExamDTO project = new ExamDTO();
//                    project.setProject_id(projectId);
//                    project.setStatus(newStatus);
//
//                    boolean success = projectDAO.update(project);
//
//                    if (success) {
//                        request.setAttribute("SUCCESS_STATUS", "Project status updated successfully!");
//                        // Refresh the project list after update
//                        search(request, response);
//
//                    } else {
//                        request.setAttribute("ERROR_STATUS", "Failed to update project status.");
//
//                    }
//                    url = "updateStatus.jsp";
//                } catch (Exception e) {
//                    
//                    request.setAttribute("ERROR_STATUS", "An error occurred while updating project status.");
//                    url = "updateStatus.jsp";
//                }
//             
//        } else {
//            url = "login.jsp";
//        }
//
//        return url;
//    }

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
//                } else if (action.equals("update")) {
//                    url = update(request, response);
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
