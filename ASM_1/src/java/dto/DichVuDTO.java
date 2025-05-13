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
public class DichVuDTO {
    private int MaDV;
    private String TenDV;
    private String MoTa;
    private int Gia;

    public DichVuDTO() {
    }

    public DichVuDTO(int MaDV, String TenDV, String MoTa, int Gia) {
        this.MaDV = MaDV;
        this.TenDV = TenDV;
        this.MoTa = MoTa;
        this.Gia = Gia;
    }

    public int getMaDV() {
        return MaDV;
    }

    public void setMaDV(int MaDV) {
        this.MaDV = MaDV;
    }

    public String getTenDV() {
        return TenDV;
    }

    public void setTenDV(String TenDV) {
        this.TenDV = TenDV;
    }

    public String getMoTa() {
        return MoTa;
    }

    public void setMoTa(String MoTa) {
        this.MoTa = MoTa;
    }

    public int getGia() {
        return Gia;
    }

    public void setGia(int Gia) {
        this.Gia = Gia;
    }
    
    
}
