/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;

/**
 *
 * @author trana
 */
public interface IDAO<T, K> {
    boolean create(T entity);
    List<T> readAll();  
    public T readById(K id);
    public boolean update (T entity);
    public boolean delete (K id);
    public List<T> search (String searchTerm);
}
