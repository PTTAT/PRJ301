/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BacSiDTO;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DBUtils;

/**
 *
 * @author trana
 */
public class BacSiDAO implements IDAO<BacSiDTO, String> {

    @Override
    public boolean create(BacSiDTO entity) {
        String sql = "INSERT INTO BacSi (HoTen, SDT, Email) VALUES (?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getHoTen());
            ps.setString(2, entity.getSDT());
            ps.setString(3, entity.getEmail());
            
            boolean result = ps.executeUpdate() > 0;
            
            ps.close();
            conn.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<BacSiDTO> readAll() {
        List<BacSiDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM BacSi";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BacSiDTO bacSi = new BacSiDTO(
                    rs.getInt("MaBS"),
                    rs.getString("HoTen"),
                    rs.getString("SDT"),
                    rs.getString("Email")
                );
                list.add(bacSi);
            }
            
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public BacSiDTO readById(String id) {
        String sql = "SELECT * FROM BacSi WHERE MaBS = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                BacSiDTO bacSi = new BacSiDTO(
                    rs.getInt("MaBS"),
                    rs.getString("HoTen"),
                    rs.getString("SDT"),
                    rs.getString("Email")
                );
                
                rs.close();
                ps.close();
                conn.close();
                return bacSi;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(BacSiDTO entity) {
        String sql = "UPDATE BacSi SET HoTen = ?, SDT = ?, Email = ? WHERE MaBS = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getHoTen());
            ps.setString(2, entity.getSDT());
            ps.setString(3, entity.getEmail());
            ps.setInt(4, entity.getMaBS());
            
            boolean result = ps.executeUpdate() > 0;
            
            ps.close();
            conn.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(String id) {
        String sql = "DELETE FROM BacSi WHERE MaBS = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            
            boolean result = ps.executeUpdate() > 0;
            
            ps.close();
            conn.close();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<BacSiDTO> search(String searchTerm) {
        List<BacSiDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM BacSi WHERE HoTen LIKE ? OR SDT LIKE ? OR Email LIKE ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BacSiDTO bacSi = new BacSiDTO(
                    rs.getInt("MaBS"),
                    rs.getString("HoTen"),
                    rs.getString("SDT"),
                    rs.getString("Email")
                );
                list.add(bacSi);
            }
            
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
