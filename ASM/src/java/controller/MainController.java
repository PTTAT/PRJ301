/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import static com.sun.xml.internal.ws.spi.db.BindingContextFactory.LOGGER;
import dto.BacSiDTO;
import dao.*;
import dto.*;
import dto.UserDTO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AuthUtils;
import java.util.ArrayList;
import java.util.UUID;
import java.util.logging.Level;
import utils.EmailUtils;

/**
 *
 * @author trana
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";

    private String login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        //
        String strUserID = request.getParameter("txtUserID");
        String strPassword = request.getParameter("txtPassword");
        if (AuthUtils.isValidLogin(strUserID, strPassword)) {
            url = "search.jsp";
            UserDTO user = AuthUtils.getUser(strUserID);
            request.getSession().setAttribute("user", user);

        } else {
            request.setAttribute("message", "Incorrect UserID or Password");
            url = "login.jsp";
        }
        //
        return url;
    }

    private String logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        //
        HttpSession session = request.getSession();
        if (AuthUtils.isLoggedIn(session)) {
            request.getSession().invalidate(); // Hủy bỏ session
            url = "login.jsp";
        }
        //
        return url;
    }

    private String viewServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "DichVu.jsp";
        try {
            DichVuDAO dvDAO = new DichVuDAO();
            List<DichVuDTO> list = dvDAO.readAll();
            request.setAttribute("dichVuList", list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }

    private String viewPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "BenhNhan.jsp";
        try {
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            List<BenhNhanDTO> list = bnDAO.readAll();
            request.setAttribute("benhNhanList", list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }

    private String addPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        return "AddBenhNhan.jsp";
    }

    private String createPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "BenhNhan.jsp";
        try {
            // Get parameters from the form
            String hoTen = request.getParameter("hoTen");
            String ngaySinhStr = request.getParameter("ngaySinh");
            String gioiTinh = request.getParameter("gioiTinh");
            String sdt = request.getParameter("sdt");
            String diaChi = request.getParameter("diaChi");
            String email = request.getParameter("email");

            // Convert ngaySinh from String to java.sql.Date
            java.sql.Date ngaySinh = java.sql.Date.valueOf(ngaySinhStr);

            // Create new BenhNhanDTO
            BenhNhanDTO newPatient = new BenhNhanDTO();
            newPatient.setHoTen(hoTen);
            newPatient.setNgaySinh(ngaySinh);
            newPatient.setGioiTinh(gioiTinh);
            newPatient.setSDT(sdt);
            newPatient.setDiaChi(diaChi);
            newPatient.setEmail(email);

            // Save to database
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            boolean success = bnDAO.create(newPatient);

            if (success) {
                request.setAttribute("message", "Thêm bệnh nhân thành công!");
                return viewPatients(request, response);
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm bệnh nhân!");
                return "AddBenhNhan.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "AddBenhNhan.jsp";
        }
    }

    private String editPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "EditBenhNhan.jsp";
        try {
            String id = request.getParameter("id");
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            BenhNhanDTO patient = bnDAO.readById(id);
            if (patient != null) {
                request.setAttribute("patient", patient);
            } else {
                request.setAttribute("error", "Không tìm thấy bệnh nhân!");
                return viewPatients(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return viewPatients(request, response);
        }
        return url;
    }

    private String updatePatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters from the form
            int maBN = Integer.parseInt(request.getParameter("maBN"));
            String hoTen = request.getParameter("hoTen");
            String ngaySinhStr = request.getParameter("ngaySinh");
            String gioiTinh = request.getParameter("gioiTinh");
            String sdt = request.getParameter("sdt");
            String diaChi = request.getParameter("diaChi");
            String email = request.getParameter("email");

            // Convert ngaySinh from String to java.sql.Date
            java.sql.Date ngaySinh = java.sql.Date.valueOf(ngaySinhStr);

            // Create BenhNhanDTO with updated info
            BenhNhanDTO patient = new BenhNhanDTO(maBN, hoTen, ngaySinh, gioiTinh, sdt, diaChi, email);

            // Update in database
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            boolean success = bnDAO.update(patient);

            if (success) {
                request.setAttribute("message", "Cập nhật thông tin bệnh nhân thành công!");
                return viewPatients(request, response);
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin!");
                request.setAttribute("patient", patient);
                return "EditBenhNhan.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "EditBenhNhan.jsp";
        }
    }

    private String deletePatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            boolean success = bnDAO.delete(id);

            if (success) {
                request.setAttribute("message", "Xóa bệnh nhân thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi xóa bệnh nhân!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return viewPatients(request, response);
    }

    private String viewMedicalRecord(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "HoSoKham.jsp";
        try {
            // Get patient ID from either 'id' or 'maBN' parameter
            String maBN = request.getParameter("id");
            if (maBN == null || maBN.isEmpty()) {
                maBN = request.getParameter("maBN");
            }

            // Get patient info
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            BenhNhanDTO patient = bnDAO.readById(maBN);
            request.setAttribute("patient", patient);

            // Get medical records
            HoSoKhamDAO hsDAO = new HoSoKhamDAO();
            List<HoSoKhamDTO> records = hsDAO.getByPatientId(maBN);
            request.setAttribute("medicalRecords", records);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return url;
    }

    private String AddMedicalRecord(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "AddHoSoKham.jsp";
        try {
            // Check if user is logged in
            HttpSession session = request.getSession();
            if (!AuthUtils.isLoggedIn(session)) {
                request.setAttribute("error", "Vui lòng đăng nhập để thực hiện chức năng này!");
                return "login.jsp";
            }

            // Get parameters and validate
            String maBNStr = request.getParameter("maBN");
            String maBSStr = request.getParameter("maBS");
            String ngayKhamStr = request.getParameter("ngayKham");
            String trieuChung = request.getParameter("trieuChung");
            String chanDoan = request.getParameter("chanDoan");

            // Validate required fields
            if (maBNStr == null || maBNStr.trim().isEmpty() ||
                maBSStr == null || maBSStr.trim().isEmpty() ||
                ngayKhamStr == null || ngayKhamStr.trim().isEmpty() ||
                trieuChung == null || trieuChung.trim().isEmpty() ||
                chanDoan == null || chanDoan.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                return url;
            }

            // Convert string to numbers
            int maBN = Integer.parseInt(maBNStr);
            int maBS = Integer.parseInt(maBSStr);

            // Convert date
            java.sql.Date ngayKham = java.sql.Date.valueOf(ngayKhamStr);

            // Create DTO
            HoSoKhamDTO record = new HoSoKhamDTO();
            record.setMaBN(maBN);
            record.setMaBS(maBS);
            record.setNgayKham(ngayKham);
            record.setTrieuChung(trieuChung);
            record.setChanDoan(chanDoan);

            // Save to database
            HoSoKhamDAO hsDAO = new HoSoKhamDAO();
            boolean success = hsDAO.create(record);

            if (success) {
                request.setAttribute("message", "Thêm hồ sơ khám bệnh thành công!");
                // Redirect to patient's medical record page
                return "MainController?action=viewMedicalRecord&id=" + maBN;
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm hồ sơ!");
                request.setAttribute("record", record);
                return url;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Vui lòng nhập đúng định dạng số cho mã bệnh nhân và mã bác sĩ!");
            return url;
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Vui lòng nhập đúng định dạng ngày tháng!");
            return url;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return url;
        }
    }

    private String viewPrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "DonThuoc.jsp";
        try {
            String maHoSo = request.getParameter("maHoSo");
            String maBN = request.getParameter("maBN");

            // Get prescriptions for the medical record
            DonThuocDAO dtDAO = new DonThuocDAO();
            List<DonThuocDTO> prescriptions = dtDAO.getByMedicalRecordId(Integer.parseInt(maHoSo));
            request.setAttribute("prescriptions", prescriptions);

            // Get list of medicines
            ThuocDAO tDAO = new ThuocDAO();
            List<ThuocDTO> medicines = tDAO.readAll();
            request.setAttribute("medicines", medicines);

            request.setAttribute("maHoSo", maHoSo);
            request.setAttribute("maBN", maBN);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return url;
    }

    private String addPrescriptionForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String maHoSo = request.getParameter("maHoSo");
            String maBN = request.getParameter("maBN");

            // Get list of medicines
            ThuocDAO tDAO = new ThuocDAO();
            List<ThuocDTO> medicines = tDAO.readAll();
            request.setAttribute("medicines", medicines);

            request.setAttribute("maHoSo", maHoSo);
            request.setAttribute("maBN", maBN);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "AddDonThuoc.jsp";
    }

    private String addPrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "AddDonThuoc.jsp";
        try {
            // Get parameters and validate
            String maHoSoStr = request.getParameter("maHoSo");
            String maThuocStr = request.getParameter("maThuoc");
            String soLuongStr = request.getParameter("soLuong");
            String lieuDungStr = request.getParameter("lieuDung");
            String maBN = request.getParameter("maBN");
            String action = request.getParameter("submitAction");

            // Validate required fields
            if (maHoSoStr == null || maHoSoStr.trim().isEmpty() ||
                maThuocStr == null || maThuocStr.trim().isEmpty() ||
                soLuongStr == null || soLuongStr.trim().isEmpty() ||
                lieuDungStr == null || lieuDungStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                return url;
            }

            // Convert string to numbers
            int maHoSo = Integer.parseInt(maHoSoStr);
            int maThuoc = Integer.parseInt(maThuocStr);
            int soLuong = Integer.parseInt(soLuongStr);

            // Create DTO
            DonThuocDTO prescription = new DonThuocDTO();
            prescription.setMaHoSo(maHoSo);
            prescription.setMaThuoc(maThuoc);
            prescription.setSoLuong(soLuong);
            prescription.setLieuDung(lieuDungStr);

            // Save to database
            DonThuocDAO dtDAO = new DonThuocDAO();
            boolean success = dtDAO.create(prescription);

            if (success) {
                // Get updated list of prescriptions
                List<DonThuocDTO> prescriptions = dtDAO.getByMedicalRecordId(maHoSo);
                request.setAttribute("prescriptions", prescriptions);

                // Get list of medicines for dropdown
                ThuocDAO tDAO = new ThuocDAO();
                List<ThuocDTO> medicines = tDAO.readAll();
                request.setAttribute("medicines", medicines);

                // Set success message and parameters
                request.setAttribute("message", "Thêm đơn thuốc thành công! Bạn có thể tiếp tục thêm đơn thuốc khác.");
                request.setAttribute("maHoSo", maHoSo);
                request.setAttribute("maBN", maBN);

                // If "Hoàn thành" button was clicked, redirect to prescription view
                if ("Hoàn thành".equals(action)) {
                    return "MainController?action=viewPrescription&maHoSo=" + maHoSo + "&maBN=" + maBN;
                }
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm đơn thuốc!");
                request.setAttribute("prescription", prescription);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Vui lòng nhập đúng định dạng số cho mã hồ sơ, mã thuốc và số lượng!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return url;
    }

    private String deletePrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            String maHoSo = request.getParameter("maHoSo");
            String maBN = request.getParameter("maBN");

            DonThuocDAO dtDAO = new DonThuocDAO();
            boolean success = dtDAO.delete(id);

            if (success) {
                request.setAttribute("message", "Xóa đơn thuốc thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi xóa đơn thuốc!");
            }

            // Set parameters for viewPrescription
            request.setAttribute("maHoSo", maHoSo);
            request.setAttribute("maBN", maBN);

            // Return to prescription list
            return viewPrescription(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "DonThuoc.jsp";
        }
    }

    private String viewContacts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "LienHe.jsp";
        try {
            LienHeDAO lhDAO = new LienHeDAO();
            List<LienHeDTO> list = lhDAO.readAll();
            request.setAttribute("lienHeList", list);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return url;
    }

    private String deleteContact(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            LienHeDAO lhDAO = new LienHeDAO();
            boolean success = lhDAO.delete(id);

            if (success) {
                request.setAttribute("message", "Xóa liên hệ thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi xóa liên hệ!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return viewContacts(request, response);
    }

    private String addContact(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters from the form
            String ten = request.getParameter("ten");
            String email = request.getParameter("email");
            String sdt = request.getParameter("sdt");
            String noiDung = request.getParameter("noiDung");

            // Create new LienHeDTO
            LienHeDTO contact = new LienHeDTO();
            contact.setTen(ten);
            contact.setEmail(email);
            contact.setSDT(sdt);
            contact.setNoiDung(noiDung);

            // Save to database
            LienHeDAO lhDAO = new LienHeDAO();
            boolean success = lhDAO.create(contact);

            if (success) {
                request.setAttribute("message", "Gửi liên hệ thành công! Chúng tôi sẽ phản hồi sớm nhất có thể.");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi gửi liên hệ!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "index.jsp";
    }

    private String viewAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "LichHen.jsp";
        try {
            LichHenDAO lhDAO = new LichHenDAO();
            List<LichHenDTO> list = lhDAO.readAll();
            request.setAttribute("lichHenList", list);

            // Get patient names for each appointment
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            Map<Integer, String> patientNames = new HashMap<>();
            for (LichHenDTO lichHen : list) {
                BenhNhanDTO patient = bnDAO.readById(String.valueOf(lichHen.getMaBN()));
                if (patient != null) {
                    patientNames.put(lichHen.getMaBN(), patient.getHoTen());
                }
            }
            request.setAttribute("patientNames", patientNames);

            // Get doctor names for each appointment
            BacSiDAO bsDAO = new BacSiDAO();
            Map<Integer, String> doctorNames = new HashMap<>();
            for (LichHenDTO lichHen : list) {
                BacSiDTO doctor = bsDAO.readById(String.valueOf(lichHen.getMaBS()));
                if (doctor != null) {
                    doctorNames.put(lichHen.getMaBS(), doctor.getHoTen());
                }
            }
            request.setAttribute("doctorNames", doctorNames);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return url;
    }

    private String deleteAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String id = request.getParameter("id");
            LichHenDAO lhDAO = new LichHenDAO();
            boolean success = lhDAO.delete(id);

            if (success) {
                request.setAttribute("message", "Xóa lịch hẹn thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi xóa lịch hẹn!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return viewAppointment(request, response);
    }

    private String addAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "index.jsp";
        try {
            // Get parameters from the form
            int maBN = Integer.parseInt(request.getParameter("maBN"));
            int maBS = Integer.parseInt(request.getParameter("maBS"));
            String ngayHenStr = request.getParameter("ngayHen");
            String gioHenStr = request.getParameter("gioHen");

            // Convert date and time strings to SQL types
            java.sql.Date ngayHen = java.sql.Date.valueOf(ngayHenStr);
            java.sql.Time gioHen = java.sql.Time.valueOf(gioHenStr + ":00");

            // Create new LichHenDTO (MaLichHen will be auto-generated by DB)
            LichHenDTO appointment = new LichHenDTO(0, maBN, maBS, ngayHen, gioHen);

            // Save to database
            LichHenDAO lhDAO = new LichHenDAO();
            boolean success = lhDAO.create(appointment);

            if (success) {
                request.setAttribute("message", "Thêm lịch hẹn thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm lịch hẹn!");
                return "AddLichHen.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "AddLichHen.jsp";
        }
        return url;
    }

    private String addAppointmentForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get list of patients
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            List<BenhNhanDTO> patients = bnDAO.readAll();
            request.setAttribute("patients", patients);

            // Get list of doctors
            BacSiDAO bsDAO = new BacSiDAO();
            List<BacSiDTO> doctors = bsDAO.readAll();
            request.setAttribute("doctors", doctors);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "AddLichHen.jsp";
    }

    private String viewPatientRecords(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "HoSoKhamBN.jsp";
        try {
            String hoTen = request.getParameter("hoTen");
            if (hoTen != null && !hoTen.isEmpty()) {
                // Get patient by name
                BenhNhanDAO bnDAO = new BenhNhanDAO();
                List<BenhNhanDTO> patients = bnDAO.readAll();
                BenhNhanDTO patient = null;

                for (BenhNhanDTO p : patients) {
                    if (p.getHoTen().equalsIgnoreCase(hoTen)) {
                        patient = p;
                        break;
                    }
                }

                if (patient != null) {
                    // Get medical records for the patient
                    HoSoKhamDAO hsDAO = new HoSoKhamDAO();
                    List<HoSoKhamDTO> records = hsDAO.getByPatientId(String.valueOf(patient.getMaBN()));
                    request.setAttribute("medicalRecords", records);
                    request.setAttribute("patient", patient);

                    // Get doctor names for the records
                    BacSiDAO bsDAO = new BacSiDAO();
                    Map<Integer, String> doctorNames = new HashMap<>();
                    for (HoSoKhamDTO record : records) {
                        BacSiDTO doctor = bsDAO.readById(String.valueOf(record.getMaBS()));
                        if (doctor != null) {
                            doctorNames.put(record.getMaBS(), doctor.getHoTen());
                        }
                    }
                    request.setAttribute("doctorNames", doctorNames);
                } else {
                    request.setAttribute("error", "Không tìm thấy bệnh nhân với tên: " + hoTen);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return url;
    }

    private String viewPatientPrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "DTLHBN.jsp";
        try {
            String hoTen = request.getParameter("hoTen");
            if (hoTen != null && !hoTen.isEmpty()) {
                // Get patient by name
                BenhNhanDAO bnDAO = new BenhNhanDAO();
                List<BenhNhanDTO> patients = bnDAO.readAll();
                BenhNhanDTO patient = null;

                for (BenhNhanDTO p : patients) {
                    if (p.getHoTen().equalsIgnoreCase(hoTen)) {
                        patient = p;
                        break;
                    }
                }

                if (patient != null) {
                    // Get medical records for the patient
                    HoSoKhamDAO hsDAO = new HoSoKhamDAO();
                    List<HoSoKhamDTO> records = hsDAO.getByPatientId(String.valueOf(patient.getMaBN()));

                    // Get prescriptions for each medical record
                    DonThuocDAO dtDAO = new DonThuocDAO();
                    List<DonThuocDTO> allPrescriptions = new ArrayList<>();
                    for (HoSoKhamDTO record : records) {
                        List<DonThuocDTO> prescriptions = dtDAO.getByMedicalRecordId(record.getMaHoSo());
                        allPrescriptions.addAll(prescriptions);
                    }

                    // Get medicine names
                    ThuocDAO tDAO = new ThuocDAO();
                    Map<Integer, String> medicineNames = new HashMap<>();
                    for (DonThuocDTO prescription : allPrescriptions) {
                        ThuocDTO medicine = tDAO.readById(String.valueOf(prescription.getMaThuoc()));
                        if (medicine != null) {
                            medicineNames.put(prescription.getMaThuoc(), medicine.getTenThuoc());
                        }
                    }

                    request.setAttribute("prescriptions", allPrescriptions);
                    request.setAttribute("medicineNames", medicineNames);
                    request.setAttribute("patient", patient);
                } else {
                    request.setAttribute("error", "Không tìm thấy bệnh nhân với tên: " + hoTen);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return url;
    }

    private String viewPatientAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "LichHenBN.jsp";
        try {
            // Get the logged-in user
            UserDTO user = AuthUtils.getUser(request.getSession());
            if (user == null) {
                request.setAttribute("error", "Vui lòng đăng nhập để xem lịch hẹn!");
                return "login.jsp";
            }

            // Get patient by name from UserDTO
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            List<BenhNhanDTO> patients = bnDAO.readAll();
            BenhNhanDTO currentPatient = null;

            // Find the patient record matching the logged-in user's name
            for (BenhNhanDTO patient : patients) {
                if (patient.getHoTen().equalsIgnoreCase(user.getName())) {
                    currentPatient = patient;
                    break;
                }
            }

            if (currentPatient == null) {
                request.setAttribute("error", "Không tìm thấy thông tin bệnh nhân!");
                return url;
            }

            // Get all appointments
            LichHenDAO lhDAO = new LichHenDAO();
            List<LichHenDTO> allAppointments = lhDAO.readAll();
            List<LichHenDTO> patientAppointments = new ArrayList<>();
            
            // Get doctor information
            BacSiDAO bsDAO = new BacSiDAO();
            Map<Integer, String> doctorNames = new HashMap<>();
            
            // Filter appointments for current patient only
            for (LichHenDTO lichHen : allAppointments) {
                if (lichHen.getMaBN() == currentPatient.getMaBN()) {
                    patientAppointments.add(lichHen);
                    
                    // Get doctor name
                    BacSiDTO doctor = bsDAO.readById(String.valueOf(lichHen.getMaBS()));
                    if (doctor != null) {
                        doctorNames.put(lichHen.getMaBS(), doctor.getHoTen());
                    }
                }
            }
            
            // Set attributes for the JSP
            request.setAttribute("lichHenList", patientAppointments);
            request.setAttribute("doctorNames", doctorNames);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return url;
    }

    private String addNewAccount(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String url = "DangKyBN.jsp";
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");

            UserDAO dao = new UserDAO();
            
            // Check if username exists
            if (dao.isUsernameExists(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                return url;
            }
            
            // Check if email exists
            if (dao.isEmailExists(email)) {
                request.setAttribute("error", "Email đã được sử dụng!");
                return url;
            }

            // Generate token
            String token = java.util.UUID.randomUUID().toString();
            
            UserDTO user = new UserDTO(username, name, "BenhNhan", password, email, token);
            if (dao.create(user)) {
                // Send confirmation email
                String subject = "Xác nhận đăng ký tài khoản";
                String content = "Xin chào " + name + ",\n\n"
                        + "Cảm ơn bạn đã đăng ký tài khoản tại phòng khám của chúng tôi.\n"
                        + "Vui lòng click vào link sau để xác nhận tài khoản của bạn:\n"
                        + "http://localhost:8080/PRJ301_ASM/MainController?action=confirm&token=" + token + "\n\n"
                        + "Trân trọng,\n"
                        + "Phòng khám";
                
                utils.EmailUtils.sendRegistrationEmail(email, subject, username);
                
                request.setAttribute("message", "Đăng ký tài khoản thành công! "
                        + "Vui lòng kiểm tra email để xác nhận tài khoản.");
                url = "login.jsp";
            } else {
                request.setAttribute("error", "Đăng ký tài khoản thất bại!");
            }
        } catch (Exception e) {
            log("Error at addNewAccount: " + e.toString());
            request.setAttribute("error", "Đã xảy ra lỗi khi đăng ký tài khoản!");
        }
        return url;
    }

    private String addNewAccountBS(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String url = "DangKyBS.jsp";
        try {
            HttpSession session = request.getSession();
            UserDTO currentUser = (UserDTO) session.getAttribute("LOGIN_USER");
            
            if (currentUser == null || !currentUser.getRole().equals("Admin")) {
                request.setAttribute("error", "Bạn không có quyền truy cập trang này!");
                return "login.jsp";
            }

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");

            UserDAO dao = new UserDAO();
            
            // Check if username exists
            if (dao.isUsernameExists(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                return url;
            }
            
            // Check if email exists
            if (dao.isEmailExists(email)) {
                request.setAttribute("error", "Email đã được sử dụng!");
                return url;
            }

            // Generate token
            String token = java.util.UUID.randomUUID().toString();
            
            UserDTO user = new UserDTO(username, name, "BacSi", password, email, token);
            if (dao.create(user)) {
                // Send confirmation email
                String subject = "Xác nhận đăng ký tài khoản bác sĩ";
                String content = "Xin chào " + name + ",\n\n"
                        + "Cảm ơn bạn đã đăng ký tài khoản bác sĩ tại phòng khám của chúng tôi.\n"
                        + "Vui lòng click vào link sau để xác nhận tài khoản của bạn:\n"
                        + "http://localhost:8080/PRJ301_ASM/MainController?action=confirm&token=" + token + "\n\n"
                        + "Trân trọng,\n"
                        + "Phòng khám";
                
                utils.EmailUtils.sendRegistrationEmail(email, subject, username);
                
                request.setAttribute("message", "Đăng ký tài khoản bác sĩ thành công! Vui lòng kiểm tra email để xác nhận tài khoản.");
                url = "index.jsp";
            } else {
                request.setAttribute("error", "Đăng ký tài khoản bác sĩ thất bại!");
            }
        } catch (Exception e) {
            log("Error at addNewAccountBS: " + e.toString());
            request.setAttribute("error", "Đã xảy ra lỗi khi đăng ký tài khoản bác sĩ!");
        }
        return url;
    }

    private String addServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "AddDichVu.jsp";
        try {
            // Get parameters from the form
            String tenDV = request.getParameter("tenDV");
            String moTa = request.getParameter("moTa");
            int gia = Integer.parseInt(request.getParameter("gia"));

            // Create new DichVuDTO
            DichVuDTO newService = new DichVuDTO();
            newService.setTenDV(tenDV);
            newService.setMoTa(moTa);
            newService.setGia(gia);

            // Save to database
            DichVuDAO dvDAO = new DichVuDAO();
            boolean success = dvDAO.create(newService);

            if (success) {
                request.setAttribute("message", "Thêm dịch vụ thành công!");
                return viewServices(request, response);
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm dịch vụ!");
                return url;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return url;
        }
    }

    private String editServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "AddDichVu.jsp";
        try {
            String id = request.getParameter("id");
            DichVuDAO dvDAO = new DichVuDAO();
            DichVuDTO dichVu = dvDAO.readById(id);

            if (dichVu != null) {
                request.setAttribute("dichVu", dichVu);
                return url;
            } else {
                request.setAttribute("error", "Không tìm thấy dịch vụ!");
                return "DichVu.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "DichVu.jsp";
        }
    }

    private String deleteServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            DichVuDAO dvDAO = new DichVuDAO();
            boolean success = dvDAO.delete(id);

            if (success) {
                request.setAttribute("message", "Xóa dịch vụ thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi xóa dịch vụ!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return viewServices(request, response);
    }

    private String addMedicalRecordForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "AddHoSoKham.jsp";
        try {
            // Check if user is logged in
            HttpSession session = request.getSession();
            if (!AuthUtils.isLoggedIn(session)) {
                request.setAttribute("error", "Vui lòng đăng nhập để thực hiện chức năng này!");
                return "login.jsp";
            }

            // Get patient ID
            String maBN = request.getParameter("maBN");
            if (maBN == null || maBN.trim().isEmpty()) {
                request.setAttribute("error", "Không tìm thấy thông tin bệnh nhân!");
                return "HoSoKham.jsp";
            }

            // Get patient info
            BenhNhanDAO bnDAO = new BenhNhanDAO();
            BenhNhanDTO patient = bnDAO.readById(maBN);
            if (patient == null) {
                request.setAttribute("error", "Không tìm thấy thông tin bệnh nhân!");
                return "HoSoKham.jsp";
            }

            // Set patient info to request
            request.setAttribute("patient", patient);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "HoSoKham.jsp";
        }
        return url;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            String action = request.getParameter("action");
            System.out.println("action: " + action);
            if (action == null) {
                url = LOGIN_PAGE;
            } else {
                if (action.equals("login")) { //dang nhap
                    url = login(request, response);
                } else if (action.equals("logout")) { //dang xuat
                    url = logout(request, response);
                } else if (action.equals("viewServices")) { //xem dich vu
                    url = viewServices(request, response);
                } else if (action.equals("viewPatients")) { // xem benh nhan
                    url = viewPatients(request, response);
                } else if (action.equals("addPatient")) { //dan jsp them benh nhan
                    url = addPatient(request, response);
                } else if (action.equals("createPatient")) { //them benh nhan
                    url = createPatient(request, response);
                } else if (action.equals("editPatient")) { //lay id benh nhan
                    url = editPatient(request, response);
                } else if (action.equals("updatePatient")) { //sua benh nhan
                    url = updatePatient(request, response);
                } else if (action.equals("deletePatient")) { //xoa benh nhan
                    url = deletePatient(request, response);
                } else if (action.equals("viewMedicalRecord")) { //xem ho so kham
                    url = viewMedicalRecord(request, response);
                } else if (action.equals("addMedicalRecord")) { // them ho so kham
                    url = AddMedicalRecord(request, response);
                }  else if (action.equals("viewPrescription")) { //xem don thuoc
                    url = viewPrescription(request, response);
                } else if (action.equals("addPrescriptionForm")) { // lay id BN don thuoc
                    url = addPrescriptionForm(request, response);
                } else if (action.equals("addPrescription")) { // them don thuoc
                    url = addPrescription(request, response);
                } else if (action.equals("viewContacts")) {//xem lien he
                    url = viewContacts(request, response);
                } else if (action.equals("deletePrescription")) {//xoa don thuoc
                    url = deletePrescription(request, response);
                } else if (action.equals("deleteContact")) { //xoa lien he
                    url = deleteContact(request, response);
                } else if (action.equals("addContact")) { //them lien he
                    url = addContact(request, response);
                } else if (action.equals("viewAppointment")) {//xem lich hen
                    url = viewAppointment(request, response);
                } else if (action.equals("deleteAppointment")) {//xoa lich hen
                    url = deleteAppointment(request, response);
                } else if (action.equals("addAppointment")) {//them lich hen
                    url = addAppointment(request, response);
                } else if (action.equals("addAppointmentForm")) {//lay id benh nhan
                    url = addAppointmentForm(request, response);
                } else if (action.equals("viewPatientRecords")) {//BN xem ho so kham
                    url = viewPatientRecords(request, response);
                } else if (action.equals("viewPatientPrescription")) {//BN xem don thuoc
                    url = viewPatientPrescription(request, response);
                } else if (action.equals("viewPatientAppointment")) { //BN xem lich hen
                    url = viewPatientAppointment(request, response);
                } else if (action.equals("addNewAccount")) { //tao tk bn
                    url = addNewAccount(request, response);
                } else if (action.equals("addServices")) { //them dich vu
                    url = addServices(request, response);
                } else if (action.equals("editServices")) { //sua dich vu
                    url = editServices(request, response);
                } else if (action.equals("deleteServices")) { //xoa dich vu
                    url = deleteServices(request, response);
                } else if (action.equals("addNewAccountBS")) { //tao tk bn
                    url = addNewAccountBS(request, response);
                } else if (action.equals("addMedicalRecordForm")) { //lay id BN ho so kham
                    url = addMedicalRecordForm(request, response);
                }
            }

        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
