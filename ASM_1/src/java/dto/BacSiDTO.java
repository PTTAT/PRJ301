package dto;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author trana
 */
public class BacSiDTO {
    private int MaBS;
    private String HoTen;
    private String SDT;
    private String Email;

    public BacSiDTO() {
    }

    public BacSiDTO(int MaBS, String HoTen, String SDT, String Email) {
        this.MaBS = MaBS;
        this.HoTen = HoTen;
        this.SDT = SDT;
        this.Email = Email;
    }

    public int getMaBS() {
        return MaBS;
    }

    public void setMaBS(int MaBS) {
        this.MaBS = MaBS;
    }

    public String getHoTen() {
        return HoTen;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public String getSDT() {
        return SDT;
    }

    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }
    
    
}
