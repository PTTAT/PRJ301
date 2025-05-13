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
        return false;
    }

    @Override
    public List<AnsQuestionDTO> readAll() {
        return null;
    }

    @Override
    public AnsQuestionDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(AnsQuestionDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<AnsQuestionDTO> search(String searchTerm) {
        return null;
    }
    
    public List<AnsQuestionDTO> getQuestionsByExamId(int examId) {
        List<AnsQuestionDTO> questions = new ArrayList<>();
        String sql = "SELECT question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option " +
                    "FROM tblQuestions WHERE exam_id = ?";
        
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, examId);
            System.out.println("Executing query for exam_id: " + examId);
            ResultSet rs = ps.executeQuery();
            
            int count = 0;
            while (rs.next()) {
                count++;
                AnsQuestionDTO question = new AnsQuestionDTO(
                    rs.getInt("question_id"),
                    rs.getInt("exam_id"),
                    rs.getString("question_text"),
                    rs.getString("option_a"),
                    rs.getString("option_b"),
                    rs.getString("option_c"),
                    rs.getString("option_d"),
                    rs.getString("correct_option")
                );
                questions.add(question);
            }
            System.out.println("Found " + count + " questions for exam_id: " + examId);
            
            if (count == 0) {
                System.out.println("No questions found in database for exam_id: " + examId);
            }
            
        } catch (Exception e) {
            System.out.println("Error in getQuestionsByExamId: " + e.toString());
            e.printStackTrace();
        }
        return questions;
    }
}
