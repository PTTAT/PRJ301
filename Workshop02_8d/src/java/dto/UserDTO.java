/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author trana
 */
public class UserDTO {
    private String Username;
    private String name;
    private String password;
    private String role;

    public UserDTO() {
    }

    public UserDTO(String Username, String name, String password, String role) {
        this.Username = Username;
        this.name = name;
        this.password = password;
        this.role = role;
    }

    public String getUserName() {
        return Username;
    }

    public void setUserName(String userID) {
        this.Username = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "UserName=" + Username + ", name=" + name + ", password=" + password + ", role=" + role + '}';
    }
    
    
    
}
