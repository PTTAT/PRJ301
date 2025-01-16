/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author trana
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    public boolean isValid (String username, String password){
        return username.equals("admin")&&password.equals("12345678");
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if(username.trim().length()==0){
            out.println("Please enter Username");
            return;
        }
        if(password.trim().length()==0 || password.trim().length()<8){
            out.println("Please enter Password and greatr than 8 character");
            return;
        }
        
        if(isValid(username, password)){
            // forward search.html
            RequestDispatcher rd = request.getRequestDispatcher("search.html"); //dẫn qua trang khác
            rd.forward(request, response); //lưu dữ liệu đc nhập từ trang trước chuyền vào trang sau
        }else{
            // forward / redirect invalid.html
            // forward search.html
            // RequestDispatcher rd = request.getRequestDispatcher("invalid.html");
            // rd.forward(request, response); 
            
            // redirect search.html
            response.sendRedirect("invalid.html"); //ép chuyển trang đổi url
            
            //compare RequestDispatcher /  response.sendRedirect? khac biet? khi nao nen dung?
//            RequestDispatcher : chuyển trang nhưng ko đổi địa chỉ trang và dữ liệu đc nhập từ trang trước lưu trữ và chuyển vào trang sau
//            response.sendRedirect : ép chuyển trang đổi địa chỉ trang và đổi địa chỉ trang nhưng dữ liệu đc nhập từ trang trước ko đc lưu trữ vào trang 
//          khi nao nen dung?
//            Dùng RequestDispatcher:
//            Khi bạn muốn thực hiện chuyển tiếp nội bộ giữa các thành phần trong ứng dụng.
//            Khi không cần thay đổi URL trên trình duyệt.
//            Khi cần xử lý hiệu suất cao hơn do không có thêm yêu cầu HTTP.

//            Dùng response.sendRedirect:
//            Khi cần chuyển hướng người dùng đến tài nguyên bên ngoài hoặc một URL hoàn toàn khác.
//            Khi muốn thay đổi URL hiển thị cho người dùng.
//            Khi muốn buộc người dùng thực hiện yêu cầu mới (ví dụ: xử lý post/redirect/get để tránh vấn đề refresh form).
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
