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
public class DonThuocDTO {
    private int MaDon;
    private int MaHoSo;
    private int MaThuoc;
    private int SoLuong;
    private String LieuDung;

    public DonThuocDTO() {
    }

    public DonThuocDTO(int MaDon, int MaHoSo, int MaThuoc, int SoLuong, String LieuDung) {
        this.MaDon = MaDon;
        this.MaHoSo = MaHoSo;
        this.MaThuoc = MaThuoc;
        this.SoLuong = SoLuong;
        this.LieuDung = LieuDung;
    }


    public int getMaDon() {
        return MaDon;
    }

    public void setMaDon(int MaDon) {
        this.MaDon = MaDon;
    }

    public int getMaHoSo() {
        return MaHoSo;
    }

    public void setMaHoSo(int MaHoSo) {
        this.MaHoSo = MaHoSo;
    }

    public int getMaThuoc() {
        return MaThuoc;
    }

    public void setMaThuoc(int MaThuoc) {
        this.MaThuoc = MaThuoc;
    }

    public int getSoLuong() {
        return SoLuong;
    }

    public void setSoLuong(int SoLuong) {
        this.SoLuong = SoLuong;
    }

    public String getLieuDung() {
        return LieuDung;
    }

    public void setLieuDung(String LieuDung) {
        this.LieuDung = LieuDung;
    }
    
    
}
