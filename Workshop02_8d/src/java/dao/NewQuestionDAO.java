/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ExamCategoryDTO;
import dto.NewQuestionDTO;
import java.util.List;

/**
 *
 * @author trana
 */
public class NewQuestionDAO implements IDAO<NewQuestionDTO, String>{

    @Override
    public boolean create(NewQuestionDTO entity) {
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
