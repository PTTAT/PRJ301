/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ProjectDTO;
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
public class ProjectDAO implements IDAO<ProjectDTO, String>{

    @Override
    public boolean create(ProjectDTO entity) {
        String sql = "INSERT INTO tblStartupProjects "
                + " (project_id, project_name, Description, Status, estimated_launch) "
                + " VALUES (?, ?, ?, ?, ?) ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, entity.getProject_id());
            ps.setString(2, entity.getProject_name());
            ps.setString(3, entity.getDescription());
            ps.setString(4, entity.getStatus());
            ps.setString(5, entity.getEstimated_launch());
            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return false;
    }

    @Override
    public List<ProjectDTO> readAll() {
        return null;
    }

    @Override
    public ProjectDTO readById(String id) {
        String sql = "SELECT * FROM tblStartupProjects WHERE project_id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ProjectDTO(
                    rs.getInt("project_id"),
                    rs.getString("project_name"),
                    rs.getString("Description"),
                    rs.getString("Status"),
                    rs.getString("estimated_launch")
                );
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return null;
    }

    @Override
    public boolean update(ProjectDTO entity) {
        String sql = "UPDATE tblStartupProjects SET Status = ? WHERE project_id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getStatus());
            ps.setInt(2, entity.getProject_id());
            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<ProjectDTO> search(String searchTerm) {
        return null;
    }
    
    public List<ProjectDTO> searchByTitle(String searchTerm) {
        String sql = "SELECT * FROM tblStartupProjects WHERE project_name LIKE ?";
        List<ProjectDTO> list = new ArrayList<ProjectDTO>();
        
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%"+searchTerm+"%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ProjectDTO b = new ProjectDTO(
                        rs.getInt("project_id"), 
                        rs.getString("project_name"), 
                        rs.getString("Description"),  
                        rs.getString("Status"),
                        rs.getString("estimated_launch"));
                
                list.add(b);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }
    
   
    
}
