/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.AnsQuestionDTO;
import java.util.List;

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

}
