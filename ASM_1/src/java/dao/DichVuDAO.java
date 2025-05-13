/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.DichVuDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author trana
 */
public class DichVuDAO implements IDAO<DichVuDTO, String> {

    @Override
    public boolean create(DichVuDTO entity) {
        String sql = "INSERT INTO DichVu (TenDV, MoTa, Gia) VALUES (?, ?, ?)";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, entity.getTenDV());
            ps.setString(2, entity.getMoTa());
            ps.setInt(3, entity.getGia());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DichVuDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public List<DichVuDTO> readAll() {
        List<DichVuDTO> list = new ArrayList<>();
        String sql = "SELECT MaDV, TenDV, MoTa, Gia FROM DichVu";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                DichVuDTO dv = new DichVuDTO();
                dv.setMaDV(rs.getInt("MaDV"));
                dv.setTenDV(rs.getString("TenDV"));
                dv.setMoTa(rs.getString("MoTa"));
                dv.setGia(rs.getInt("Gia"));
                list.add(dv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DichVuDAO.class.getName()).log(Level.SEVERE, null, ex);
        } 
        return list;
    }

    @Override
    public DichVuDTO readById(String id) {
        String sql = "SELECT MaDV, TenDV, MoTa, Gia FROM DichVu WHERE MaDV = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                DichVuDTO dv = new DichVuDTO();
                dv.setMaDV(rs.getInt("MaDV"));
                dv.setTenDV(rs.getString("TenDV"));
                dv.setMoTa(rs.getString("MoTa"));
                dv.setGia(rs.getInt("Gia"));
                return dv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DichVuDAO.class.getName()).log(Level.SEVERE, null, ex);
        } 
        return null;
    }

    @Override
    public boolean update(DichVuDTO entity) {
        String sql = "UPDATE DichVu SET TenDV = ?, MoTa = ?, Gia = ? WHERE MaDV = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, entity.getTenDV());
            ps.setString(2, entity.getMoTa());
            ps.setInt(3, entity.getGia());
            ps.setInt(4, entity.getMaDV());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DichVuDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean delete(String id) {
        String sql = "DELETE FROM DichVu WHERE MaDV = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DichVuDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public List<DichVuDTO> search(String searchTerm) {
        List<DichVuDTO> list = new ArrayList<>();
        String sql = "SELECT MaDV, TenDV, MoTa, Gia FROM DichVu WHERE TenDV LIKE ? OR MoTa LIKE ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DichVuDTO dv = new DichVuDTO();
                dv.setMaDV(rs.getInt("MaDV"));
                dv.setTenDV(rs.getString("TenDV"));
                dv.setMoTa(rs.getString("MoTa"));
                dv.setGia(rs.getInt("Gia"));
                list.add(dv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DichVuDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

}
