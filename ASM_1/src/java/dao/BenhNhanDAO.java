/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BenhNhanDTO;
import dto.DichVuDTO;
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
public class BenhNhanDAO implements IDAO<BenhNhanDTO, String> {

    @Override
    public boolean create(BenhNhanDTO entity) {
        String sql = "INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, Email) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getHoTen());
            ps.setDate(2, entity.getNgaySinh());
            ps.setString(3, entity.getGioiTinh());
            ps.setString(4, entity.getSDT());
            ps.setString(5, entity.getDiaChi());
            ps.setString(6, entity.getEmail());
            
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
    public List<BenhNhanDTO> readAll() {
        List<BenhNhanDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM BenhNhan";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BenhNhanDTO bn = new BenhNhanDTO(
                    rs.getInt("MaBN"),
                    rs.getString("HoTen"),
                    rs.getDate("NgaySinh"),
                    rs.getString("GioiTinh"),
                    rs.getString("SDT"),
                    rs.getString("DiaChi"),
                    rs.getString("Email")
                );
                list.add(bn);
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
    public BenhNhanDTO readById(String id) {
        BenhNhanDTO bn = null;
        String sql = "SELECT * FROM BenhNhan WHERE MaBN = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bn = new BenhNhanDTO(
                    rs.getInt("MaBN"),
                    rs.getString("HoTen"),
                    rs.getDate("NgaySinh"),
                    rs.getString("GioiTinh"),
                    rs.getString("SDT"),
                    rs.getString("DiaChi"),
                    rs.getString("Email")
                );
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bn;
    }

    @Override
    public boolean update(BenhNhanDTO entity) {
        String sql = "UPDATE BenhNhan SET HoTen=?, NgaySinh=?, GioiTinh=?, SDT=?, DiaChi=?, Email=? WHERE MaBN=?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getHoTen());
            ps.setDate(2, entity.getNgaySinh());
            ps.setString(3, entity.getGioiTinh());
            ps.setString(4, entity.getSDT());
            ps.setString(5, entity.getDiaChi());
            ps.setString(6, entity.getEmail());
            ps.setInt(7, entity.getMaBN());
            
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
    public boolean delete(String id) {
        String sql = "DELETE FROM BenhNhan WHERE MaBN = ?";
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
    public List<BenhNhanDTO> search(String searchTerm) {
        return null;
    }

    

}
