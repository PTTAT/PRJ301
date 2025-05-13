/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BenhNhanDTO;
import dto.DichVuDTO;
import dto.ThuocDTO;
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
public class ThuocDAO implements IDAO<ThuocDTO, String> {

    @Override
    public boolean create(ThuocDTO entity) {
        return false;
    }

    @Override
    public List<ThuocDTO> readAll() {
        List<ThuocDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Thuoc";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ThuocDTO dto = new ThuocDTO(
                    rs.getInt("MaThuoc"),
                    rs.getString("TenThuoc")
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
    public ThuocDTO readById(String id) {
        ThuocDTO dto = null;
        String sql = "SELECT * FROM Thuoc WHERE MaThuoc = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                dto = new ThuocDTO(
                    rs.getInt("MaThuoc"),
                    rs.getString("TenThuoc")
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
    public boolean update(ThuocDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<ThuocDTO> search(String searchTerm) {
        return null;
    }
    

    

}
