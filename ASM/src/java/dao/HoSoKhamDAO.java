/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.DichVuDTO;
import dto.HoSoKhamDTO;
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
public class HoSoKhamDAO implements IDAO<HoSoKhamDTO, String> {

    @Override
    public boolean create(HoSoKhamDTO entity) {
        String sql = "INSERT INTO HoSoKham (MaBN, MaBS, NgayKham, TrieuChung, ChanDoan) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtils.getConnection();
            if (conn == null) {
                System.out.println("Connection error!");
                return false;
            }
            
            ps = conn.prepareStatement(sql);
            ps.setInt(1, entity.getMaBN());
            ps.setInt(2, entity.getMaBS());
            ps.setDate(3, new java.sql.Date(entity.getNgayKham().getTime()));
            ps.setString(4, entity.getTrieuChung());
            ps.setString(5, entity.getChanDoan());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error at create(HoSoKhamDAO): " + e.toString());
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.out.println("Error closing connection: " + e.toString());
            }
        }
    }

    @Override
    public List<HoSoKhamDTO> readAll() {
        return null;
    }

    public List<HoSoKhamDTO> getByPatientId(String maBN) {
        List<HoSoKhamDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM HoSoKham WHERE MaBN = ? ORDER BY NgayKham DESC";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(maBN));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HoSoKhamDTO record = new HoSoKhamDTO(
                    rs.getInt("MaHoSo"),    
                    rs.getInt("MaBN"),
                    rs.getInt("MaBS"),
                    rs.getDate("NgayKham"),
                    rs.getString("TrieuChung"),
                    rs.getString("ChanDoan")
                );
                list.add(record);
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
    public HoSoKhamDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(HoSoKhamDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<HoSoKhamDTO> search(String searchTerm) {
        return null;
    }

    public HoSoKhamDTO getByPatientIdAndDate(int maBN, java.util.Date ngayKham) {
        HoSoKhamDTO record = null;
        String sql = "SELECT * FROM HoSoKham WHERE MaBN = ? AND NgayKham = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, maBN);
            ps.setDate(2, new java.sql.Date(ngayKham.getTime()));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                record = new HoSoKhamDTO(
                    rs.getInt("MaHoSo"),
                    rs.getInt("MaBN"),
                    rs.getInt("MaBS"),
                    rs.getDate("NgayKham"),
                    rs.getString("TrieuChung"),
                    rs.getString("ChanDoan")
                );
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return record;
    }

    public boolean updateRecord(HoSoKhamDTO record, java.util.Date oldNgayKham) {
        String sql = "UPDATE HoSoKham SET NgayKham=?, MaBS=?, TrieuChung=?, ChanDoan=? WHERE MaBN=? AND NgayKham=?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(record.getNgayKham().getTime()));
            ps.setInt(2, record.getMaBS());
            ps.setString(3, record.getTrieuChung());
            ps.setString(4, record.getChanDoan());
            ps.setInt(5, record.getMaBN());
            ps.setDate(6, new java.sql.Date(oldNgayKham.getTime()));
            
            int rowsAffected = ps.executeUpdate();
            ps.close();
            conn.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRecord(int maBN, java.util.Date ngayKham) {
        String sql = "DELETE FROM HoSoKham WHERE MaBN = ? AND NgayKham = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, maBN);
            ps.setDate(2, new java.sql.Date(ngayKham.getTime()));
            
            int rowsAffected = ps.executeUpdate();
            ps.close();
            conn.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
