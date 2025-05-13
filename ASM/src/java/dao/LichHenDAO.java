/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.DichVuDTO;
import dto.LichHenDTO;
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
public class LichHenDAO implements IDAO<LichHenDTO, String> {

    @Override
    public boolean create(LichHenDTO entity) {
        String sql = "INSERT INTO LichHen (MaBN, MaBS, NgayHen, GioHen) VALUES (?, ?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, entity.getMaBN());
            ps.setInt(2, entity.getMaBS());
            ps.setDate(3, entity.getNgayHen());
            ps.setTime(4, entity.getGioHen());
            
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
    public List<LichHenDTO> readAll() {
        List<LichHenDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM LichHen ORDER BY NgayHen DESC, GioHen ASC";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                LichHenDTO lichHen = new LichHenDTO(
                    rs.getInt("MaLichHen"),
                    rs.getInt("MaBN"),
                    rs.getInt("MaBS"),
                    rs.getDate("NgayHen"),
                    rs.getTime("GioHen")
                );
                list.add(lichHen);
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
    public LichHenDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(LichHenDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        String sql = "DELETE FROM LichHen WHERE MaLichHen = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            
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
    public List<LichHenDTO> search(String searchTerm) {
        return null;
    }

}
