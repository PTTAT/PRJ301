/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author trana
 */
public class LichHenDTO {
    private int MaLichHen;
    private int MaBN;
    private int MaBS;
    private Date NgayHen;
    private Time GioHen;

    public LichHenDTO() {
    }

    public LichHenDTO(int MaLichHen, int MaBN, int MaBS, Date NgayHen, Time GioHen) {
        this.MaLichHen = MaLichHen;
        this.MaBN = MaBN;
        this.MaBS = MaBS;
        this.NgayHen = NgayHen;
        this.GioHen = GioHen;
    }

    public int getMaLichHen() {
        return MaLichHen;
    }

    public void setMaLichHen(int MaLichHen) {
        this.MaLichHen = MaLichHen;
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

    public Date getNgayHen() {
        return NgayHen;
    }

    public void setNgayHen(Date NgayHen) {
        this.NgayHen = NgayHen;
    }

    public Time getGioHen() {
        return GioHen;
    }

    public void setGioHen(Time GioHen) {
        this.GioHen = GioHen;
    }
    
    
}
