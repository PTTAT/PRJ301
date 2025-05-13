/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.AnsQuestionDTO;
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
public class AnsQuestionDAO implements IDAO<AnsQuestionDTO, String> {

    @Override
    public boolean create(AnsQuestionDTO entity) {
        String sql = "INSERT INTO AnsQuestion (question_id, exam_id, option_a, option_b, option_c, option_d, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, entity.getQuestion_id());
            ps.setInt(2, entity.getExam_id());
            ps.setString(3, entity.getOption_a());
            ps.setString(4, entity.getOption_b());
            ps.setString(5, entity.getOption_c());
            ps.setString(6, entity.getOption_d());
            ps.setString(7, entity.getCorrect_option());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<AnsQuestionDTO> readAll() {
        List<AnsQuestionDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM AnsQuestion";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AnsQuestionDTO question = new AnsQuestionDTO(
                    rs.getInt("question_id"),
                    rs.getInt("exam_id"),
                    rs.getString("option_a"),
                    rs.getString("option_b"),
                    rs.getString("option_c"),
                    rs.getString("option_d"),
                    rs.getString("correct_option")
                );
                list.add(question);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public AnsQuestionDTO readById(String id) {
        String sql = "SELECT * FROM AnsQuestion WHERE question_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new AnsQuestionDTO(
                    rs.getInt("question_id"),
                    rs.getInt("exam_id"),
                    rs.getString("option_a"),
                    rs.getString("option_b"),
                    rs.getString("option_c"),
                    rs.getString("option_d"),
                    rs.getString("correct_option")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(AnsQuestionDTO entity) {
        String sql = "UPDATE AnsQuestion SET option_a = ?, option_b = ?, option_c = ?, option_d = ?, correct_option = ? WHERE question_id = ? AND exam_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, entity.getOption_a());
            ps.setString(2, entity.getOption_b());
            ps.setString(3, entity.getOption_c());
            ps.setString(4, entity.getOption_d());
            ps.setString(5, entity.getCorrect_option());
            ps.setInt(6, entity.getQuestion_id());
            ps.setInt(7, entity.getExam_id());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(String id) {
        String sql = "DELETE FROM AnsQuestion WHERE question_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<AnsQuestionDTO> search(String searchTerm) {
        List<AnsQuestionDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM AnsQuestion WHERE option_a LIKE ? OR option_b LIKE ? OR option_c LIKE ? OR option_d LIKE ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AnsQuestionDTO question = new AnsQuestionDTO(
                    rs.getInt("question_id"),
                    rs.getInt("exam_id"),
                    rs.getString("option_a"),
                    rs.getString("option_b"),
                    rs.getString("option_c"),
                    rs.getString("option_d"),
                    rs.getString("correct_option")
                );
                list.add(question);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<AnsQuestionDTO> getQuestionsByExamId(int examId) {
        List<AnsQuestionDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM AnsQuestion WHERE exam_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, examId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AnsQuestionDTO question = new AnsQuestionDTO(
                    rs.getInt("question_id"),
                    rs.getInt("exam_id"),
                    rs.getString("option_a"),
                    rs.getString("option_b"),
                    rs.getString("option_c"),
                    rs.getString("option_d"),
                    rs.getString("correct_option")
                );
                list.add(question);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
