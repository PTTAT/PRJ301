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
public class ThuocDTO {
    private int MaThuoc;
    private String TenThuoc;

    public ThuocDTO() {
    }

    public ThuocDTO(int MaThuoc, String TenThuoc) {
        this.MaThuoc = MaThuoc;
        this.TenThuoc = TenThuoc;
    }

    public int getMaThuoc() {
        return MaThuoc;
    }

    public void setMaThuoc(int MaThuoc) {
        this.MaThuoc = MaThuoc;
    }

    public String getTenThuoc() {
        return TenThuoc;
    }

    public void setTenThuoc(String TenThuoc) {
        this.TenThuoc = TenThuoc;
    }
    
    
}
