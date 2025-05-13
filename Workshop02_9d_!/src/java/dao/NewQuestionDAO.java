/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ExamCategoryDTO;
import dto.NewQuestionDTO;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import utils.DBUtils;

/**
 *
 * @author trana
 */
public class NewQuestionDAO implements IDAO<NewQuestionDTO, String>{

    @Override
    public boolean create(NewQuestionDTO entity) {
        String sql = "INSERT INTO tblQuestions (exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, entity.getExam_id());
            ps.setString(2, entity.getQuestion_text());
            ps.setString(3, entity.getOption_a());
            ps.setString(4, entity.getOption_b());
            ps.setString(5, entity.getOption_c());
            ps.setString(6, entity.getOption_d());
            ps.setString(7, entity.getCorrect_option());
            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            System.out.println("Error in create: " + e.toString());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<NewQuestionDTO> readAll() {
        return null;
    }

    @Override
    public NewQuestionDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(NewQuestionDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<NewQuestionDTO> search(String searchTerm) {
        return null;
    }
    
}
