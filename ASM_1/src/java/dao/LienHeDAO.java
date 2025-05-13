/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BenhNhanDTO;
import dto.DichVuDTO;
import dto.LienHeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author trana
 */
public class LienHeDAO implements IDAO<LienHeDTO, String> {

    @Override
    public boolean create(LienHeDTO entity) {
        String sql = "INSERT INTO LienHe (Ten, Email, SDT, NoiDung) VALUES (?, ?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getTen());
            ps.setString(2, entity.getEmail());
            ps.setString(3, entity.getSDT());
            ps.setString(4, entity.getNoiDung());
            
            int rowsAffected = ps.executeUpdate();
            ps.close();
            conn.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<LienHeDTO> readAll() {
        List<LienHeDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM LienHe";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LienHeDTO dto = new LienHeDTO(
                    rs.getInt("MaLH"),
                    rs.getString("Ten"),
                    rs.getString("Email"),
                    rs.getString("SDT"),
                    rs.getString("NoiDung")
                );
                list.add(dto);
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
    public LienHeDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(LienHeDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        String sql = "DELETE FROM LienHe WHERE MaLH = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            
            int rowsAffected = ps.executeUpdate();
            ps.close();
            conn.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<LienHeDTO> search(String searchTerm) {
        return null;
    }

    

}
