/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ExamDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javafx.scene.text.Text;
import utils.DBUtils;

/**
 *
 * @author trana
 */
public class ExamDAO implements IDAO<ExamDTO, String>{

    @Override
    public boolean create(ExamDTO entity) {
//        String sql = "INSERT INTO tblStartupProjects "
//                + " (project_id, project_name, Description, Status, estimated_launch) "
//                + " VALUES (?, ?, ?, ?, ?) ";
//        try {
//            Connection conn = DBUtils.getConnection();
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setInt(1, entity.getProject_id());
//            ps.setString(2, entity.getProject_name());
//            ps.setString(3, entity.getDescription());
//            ps.setString(4, entity.getStatus());
//            ps.setString(5, entity.getEstimated_launch());
//            int i = ps.executeUpdate();
//            return i > 0;
//        } catch (Exception e) {
//            System.out.println(e.toString());
//        }
        return false;
    }

    @Override
    public List<ExamDTO> readAll() {
        return null;
    }

    @Override
    public ExamDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(ExamDTO entity) {
//        String sql = "UPDATE tblStartupProjects SET Status = ? WHERE project_id = ?";
//        try {
//            Connection conn = DBUtils.getConnection();
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, entity.getStatus());
//            ps.setInt(2, entity.getProject_id());
//            int i = ps.executeUpdate();
//            return i > 0;
//        } catch (Exception e) {
//            System.out.println(e.toString());
//        }
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<ExamDTO> search(String searchTerm) {
        return null;
    }
    
    public List<ExamDTO> searchByTitle(String searchTerm) {
        String sql = "SELECT * FROM tblExamCategories WHERE category_name LIKE ?";
        List<ExamDTO> list = new ArrayList<ExamDTO>();
        
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%"+searchTerm+"%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ExamDTO b = new ExamDTO(
                        rs.getInt("category_id"), 
                        rs.getString("category_name"), 
                        rs.getString("description"));
                
                list.add(b);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }
    
   
    
}
