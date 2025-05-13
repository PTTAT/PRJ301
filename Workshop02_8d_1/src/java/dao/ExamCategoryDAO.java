/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ExamCategoryDTO;
import dto.ExamDTO;
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
public class ExamCategoryDAO implements IDAO<ExamCategoryDTO, String> {

    @Override
    public boolean create(ExamCategoryDTO entity) {
        String sql = "INSERT INTO tblExams (exam_title, Subject, category_id, total_marks, Duration) "
                + "VALUES (?, ?, "
                + "(SELECT category_id FROM tblExamCategories WHERE category_name = ?), "
                + "?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getExam_title());
            ps.setString(2, entity.getSubject());
            ps.setString(3, entity.getCategory_name());
            ps.setInt(4, entity.getTotal_marks());
            ps.setInt(5, entity.getDuration());
            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            System.out.println("Error in create: " + e.toString());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<ExamCategoryDTO> readAll() {
        return null;
    }

    @Override
    public ExamCategoryDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(ExamCategoryDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<ExamCategoryDTO> search(String searchTerm) {
        String sql = "SELECT e.*\n"
                + "FROM tblExams e\n"
                + "JOIN tblExamCategories c ON e.category_id = c.category_id\n"
                + "WHERE c.category_name LIKE ?;";
        List<ExamCategoryDTO> list = new ArrayList<ExamCategoryDTO>();

        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ExamCategoryDTO b = new ExamCategoryDTO(
                        rs.getInt("exam_id"),
                        rs.getString("exam_title"),
                        rs.getString("Subject"),
                        rs.getInt("category_id"),
                        rs.getInt("total_marks"),
                        rs.getInt("Duration"));

                list.add(b);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }

}
