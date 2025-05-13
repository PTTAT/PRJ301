/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;


import java.util.Date;

/**
 *
 * @author trana
 */
public class HoSoKhamDTO {
    private int MaHoSo;
    private int MaBN;
    private int MaBS;
    private Date NgayKham;
    private String TrieuChung;
    private String ChanDoan;

    public HoSoKhamDTO() {
    }

    public HoSoKhamDTO(int MaHoSo, int MaBN, int MaBS, Date NgayKham, String TrieuChung, String ChanDoan) {
        this.MaHoSo = MaHoSo;
        this.MaBN = MaBN;
        this.MaBS = MaBS;
        this.NgayKham = NgayKham;
        this.TrieuChung = TrieuChung;
        this.ChanDoan = ChanDoan;
    }

    public int getMaHoSo() {
        return MaHoSo;
    }

    public void setMaHoSo(int MaHoSo) {
        this.MaHoSo = MaHoSo;
    }
    
    public int getMaBN() {
        return MaBN;
    }

    public void setMaBN(int MaBN) {
        this.MaBN = MaBN;
    }

    public int getMaBS() {
        return MaBS;
    }

    public void setMaBS(int MaBS) {
        this.MaBS = MaBS;
    }

    public Date getNgayKham() {
        return NgayKham;
    }

    public void setNgayKham(Date NgayKham) {
        this.NgayKham = NgayKham;
    }

    public String getTrieuChung() {
        return TrieuChung;
    }

    public void setTrieuChung(String TrieuChung) {
        this.TrieuChung = TrieuChung;
    }

    public String getChanDoan() {
        return ChanDoan;
    }

    public void setChanDoan(String ChanDoan) {
        this.ChanDoan = ChanDoan;
    }
    
    
}
