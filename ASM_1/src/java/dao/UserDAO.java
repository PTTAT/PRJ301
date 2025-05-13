/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author tungiF
 */
public class UserDAO implements IDAO<UserDTO, String> {

    @Override
    public boolean create(UserDTO entity) {
        String sql = "INSERT INTO Users (username, Name, Role, password, Email, Token) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getName());
            ps.setString(4, entity.getRole());
            ps.setString(3, entity.getPassword());
            ps.setString(5, entity.getEmail());
            ps.setString(6, entity.getToken());
            int rowsAffected = ps.executeUpdate();
            ps.close();
            conn.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(String email) throws Exception {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, email);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    @Override
    public List<UserDTO> readAll() {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Users]";
        try {
            Connection conn = DBUtils.getConnection();
            conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery(sql);
            while (rs.next()) {
                UserDTO user = new UserDTO(
                        rs.getString("username"),
                        rs.getString("Name"),
                        rs.getString("password"),
                        rs.getString("Role"),
                        rs.getString("Email"),
                        rs.getString("Token"));
                list.add(user);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    @Override
    public UserDTO readById(String id) {
        String sql = "SELECT * FROM Users WHERE username= ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserDTO user = new UserDTO(
                        rs.getString("username"),
                        rs.getString("Name"),
                        rs.getString("password"),
                        rs.getString("Role"),
                        rs.getString("Email"),
                        rs.getString("Token"));
                return user;
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean update(UserDTO entity) {
//        String sql = "UPDATE [tblUsers] SET "
//                + "[fullName] = ?, "
//                + "[roleID] = ?, "
//                + "[password] =? "
//                + "WHERE [userID] = ?";
//        Connection conn;
//        try {
//            conn = DBUtils.getConnection();
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, entity.getFullName());
//            ps.setString(2, entity.getRoleID());
//            ps.setString(3, entity.getPassword());
//            ps.setString(4, entity.getUserID());
//            int n = ps.executeUpdate();
//            return n > 0;
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
        return false;
    }

    @Override
    public boolean delete(String id) {
//        String sql = "DELETE FROM [tblUsers] WHERE [userID] = ?";
//        Connection conn;
//        try {
//            conn = DBUtils.getConnection();
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, id);
//            int n = ps.executeUpdate();
//            return n > 0;
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
        return false;
    }

    @Override
    public List<UserDTO> search(String searchTerm) {
//        List<UserDTO> list = new ArrayList<>();
//        String sql = "SELECT [userID], [fullName], [roleID], [password] FROM [tblUsers] "
//                + "WHERE [userID] LIKE ? "
//                + "OR [fullName] LIKE ? "
//                + "OR [roleID] LIKE ?";
//
//        try (Connection conn = DBUtils.getConnection();
//                PreparedStatement pstmt = conn.prepareStatement(sql)) {
//
//            String searchPattern = "%" + searchTerm + "%";
//            // Thiết lập giá trị cho tất cả các tham số
//            pstmt.setString(1, searchPattern);
//            pstmt.setString(2, searchPattern);
//            pstmt.setString(3, searchPattern);
//
//            try (ResultSet rs = pstmt.executeQuery()) {
//                while (rs.next()) {
//                    UserDTO user = new UserDTO(
//                            rs.getString("userID"),
//                            rs.getString("fullName"),
//                            rs.getString("roleID"),
//                            rs.getString("password")
//                    );
//                    list.add(user);
//                }
//            }
//        } catch (ClassNotFoundException | SQLException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }

        return null;
    }

}
