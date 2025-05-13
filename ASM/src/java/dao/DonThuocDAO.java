/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.DonThuocDTO;
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
public class DonThuocDAO implements IDAO<DonThuocDTO, String> {

    @Override
    public boolean create(DonThuocDTO entity) {
        String sql = "INSERT INTO DonThuoc (MaHoSo, MaThuoc, SoLuong, LieuDung) VALUES (?, ?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, entity.getMaHoSo());
            ps.setInt(2, entity.getMaThuoc());
            ps.setInt(3, entity.getSoLuong());
            ps.setString(4, entity.getLieuDung());
            
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
    public List<DonThuocDTO> readAll() {
        List<DonThuocDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM DonThuoc";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DonThuocDTO dto = new DonThuocDTO(
                    rs.getInt("MaDon"),
                    rs.getInt("MaHoSo"),
                    rs.getInt("MaThuoc"),
                    rs.getInt("SoLuong"),
                    rs.getString("LieuDung")
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
    public DonThuocDTO readById(String id) {
        DonThuocDTO dto = null;
        String sql = "SELECT * FROM DonThuoc WHERE MaDon = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                dto = new DonThuocDTO(
                    rs.getInt("MaDon"),
                    rs.getInt("MaHoSo"),
                    rs.getInt("MaThuoc"),
                    rs.getInt("SoLuong"),
                    rs.getString("LieuDung")
                );
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    @Override
    public boolean update(DonThuocDTO entity) {
        String sql = "UPDATE DonThuoc SET MaThuoc=?, SoLuong=?, LieuDung=? WHERE MaHoSo=?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, entity.getMaThuoc());
            ps.setInt(2, entity.getSoLuong());
            ps.setString(3, entity.getLieuDung());
            ps.setInt(4, entity.getMaHoSo());
            
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
        String sql = "DELETE FROM DonThuoc WHERE MaDon = ?";
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
    public List<DonThuocDTO> search(String searchTerm) {
        return null;
    }

    public List<DonThuocDTO> getByMedicalRecordId(int maHoSo) {
        List<DonThuocDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM DonThuoc WHERE MaHoSo = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, maHoSo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DonThuocDTO dto = new DonThuocDTO(
                    rs.getInt("MaDon"),
                    rs.getInt("MaHoSo"),
                    rs.getInt("MaThuoc"),
                    rs.getInt("SoLuong"),
                    rs.getString("LieuDung")
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
}
