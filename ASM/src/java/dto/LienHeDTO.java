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
public class LienHeDTO {
    private int MaLH;
    private String Ten;
    private String Email;
    private String SDT;
    private String NoiDung;

    public LienHeDTO() {
    }

    public LienHeDTO(int MaLH, String Ten, String Email, String SDT, String NoiDung) {
        this.MaLH = MaLH;
        this.Ten = Ten;
        this.Email = Email;
        this.SDT = SDT;
        this.NoiDung = NoiDung;
    }

    public int getMaLH() {
        return MaLH;
    }

    public void setMaLH(int MaLH) {
        this.MaLH = MaLH;
    }

    public String getTen() {
        return Ten;
    }

    public void setTen(String Ten) {
        this.Ten = Ten;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getSDT() {
        return SDT;
    }

    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    public String getNoiDung() {
        return NoiDung;
    }

    public void setNoiDung(String NoiDung) {
        this.NoiDung = NoiDung;
    }
    
    
}
