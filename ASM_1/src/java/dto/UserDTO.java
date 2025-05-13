/*
DTO (Data Transfer Object):
DTO là một design pattern dùng để đóng gói và truyền dữ liệu giữa các thành phần/layer trong ứng dụng
Là một class đơn giản chỉ chứa các thuộc tính (properties) và các phương thức getter/setter
Không chứa bất kỳ business logic nào
Mục đích chính là đóng gói dữ liệu để truyền qua network hoặc giữa các layer
 */
package dto;

/**
 *
 * @author tungi
 */
public class UserDTO {

    private String username;
    private String Name;
    private String password;
    private String Role;
    private String Email;
    private String Token;

    public UserDTO() {
    }

    public UserDTO(String username, String Name, String password, String Role, String Email, String Token) {

        this.username = username;
        this.Name = Name;
        this.password = password;
        this.Role = Role;
        this.Email = Email;
        this.Token = Token;
    }

    public String getToken() {
        return Token;
    }

    public void setToken(String Token) {
        this.Token = Token;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return Role;
    }

    public void setRole(String Role) {
        this.Role = Role;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "username=" + username + ", Name=" + Name + ", password=" + password + ", Role=" + Role + ", Email=" + Email + ", Token=" + Token + '}';
    }

    

}
