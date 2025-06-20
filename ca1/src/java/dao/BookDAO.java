/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.HouseDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author tungi
 */
public class BookDAO implements IDAO<HouseDTO, String>{

    @Override
    public boolean create(HouseDTO entity) {
         return false;
    }

    @Override
    public List<HouseDTO> readAll() {
        return null;
    }

    @Override
    public HouseDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(HouseDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<HouseDTO> search(String searchTerm) {
        return null;
    }
    
    public List<HouseDTO> searchByTitle(String searchTerm) {
        String sql = "SELECT * FROM tblBooks WHERE title LIKE ?";
        List<HouseDTO> list = new ArrayList<HouseDTO>();
        
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%"+searchTerm+"%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                HouseDTO b = new HouseDTO(
                        rs.getString("BookID"), 
                        rs.getString("Title"), 
                        rs.getString("Author"), 
                        rs.getInt("PublishYear"), 
                        rs.getDouble("Price"), 
                        rs.getInt("Quantity"));
                
                list.add(b);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }
     public List<HouseDTO> searchByTitle2(String searchTerm) {
        String sql = "SELECT * FROM tblBooks WHERE title LIKE ? AND Quantity>0";
        List<HouseDTO> list = new ArrayList<HouseDTO>();
        
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%"+searchTerm+"%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                HouseDTO b = new HouseDTO(
                        rs.getString("BookID"), 
                        rs.getString("Title"), 
                        rs.getString("Author"), 
                        rs.getInt("PublishYear"), 
                        rs.getDouble("Price"), 
                        rs.getInt("Quantity"));
                
                list.add(b);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }

    public boolean updateQuantityToZero(String id) {
        String sql = "UPDATE tblBooks SET Quantity=0 WHERE BookID=?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            int i = ps.executeUpdate();
            return i>0;
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return false;
    }
}