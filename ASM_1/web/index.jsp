<%-- 
    Document   : index
    Created on : Mar 20, 2025, 8:44:01 PM
    Author     : trana
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Nha Khoa - Chăm sóc nụ cười của bạn</title>
        <meta charset="UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background-color: #f5f5f5;
            }

            .hero-section {
                background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('assets/images/hero-bg.jpg');
                background-size: cover;
                background-position: center;
                height: 80vh;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                color: white;
            }

            .hero-content {
                max-width: 800px;
                padding: 0 20px;
            }

            .hero-content h1 {
                font-size: 3.5rem;
                margin-bottom: 20px;
                font-weight: 700;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            }

            .hero-content p {
                font-size: 1.2rem;
                margin-bottom: 30px;
                line-height: 1.6;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
            }

            .cta-button {
                display: inline-block;
                padding: 15px 40px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 30px;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .cta-button:hover {
                background-color: #45a049;
            }

            .services-section {
                padding: 80px 0;
                background-color: white;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .section-title {
                text-align: center;
                margin-bottom: 50px;
            }

            .section-title h2 {
                font-size: 2.5rem;
                color: #333;
                margin-bottom: 15px;
            }

            .section-title p {
                color: #666;
                font-size: 1.1rem;
            }

            .services-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
            }

            .service-card {
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
            }

            .service-card:hover {
                transform: translateY(-5px);
            }

            .service-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .service-content {
                padding: 20px;
            }

            .service-content h3 {
                font-size: 1.5rem;
                color: #333;
                margin-bottom: 10px;
            }

            .service-content p {
                color: #666;
                line-height: 1.6;
            }

            .features-section {
                padding: 80px 0;
                background-color: #f9f9f9;
            }

            .features-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 30px;
            }

            .feature-card {
                text-align: center;
                padding: 30px;
            }

            .feature-icon {
                font-size: 2.5rem;
                color: #4CAF50;
                margin-bottom: 20px;
            }

            .feature-card h3 {
                font-size: 1.3rem;
                color: #333;
                margin-bottom: 15px;
            }

            .feature-card p {
                color: #666;
                line-height: 1.6;
            }

            .contact-section {
                padding: 80px 0;
                background-color: white;
            }

            .contact-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 40px;
            }

            .contact-info {
                padding: 30px;
                background-color: #f9f9f9;
                border-radius: 10px;
            }

            .contact-info h3 {
                font-size: 1.5rem;
                color: #333;
                margin-bottom: 20px;
            }

            .contact-info p {
                color: #666;
                margin-bottom: 15px;
            }

            .contact-form {
                padding: 30px;
                background-color: #f9f9f9;
                border-radius: 10px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                color: #333;
            }

            .form-group input,
            .form-group textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 1rem;
            }

            .form-group textarea {
                height: 150px;
                resize: vertical;
            }

            .submit-button {
                background-color: #4CAF50;
                color: white;
                padding: 12px 30px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s;
            }

            .submit-button:hover {
                background-color: #45a049;
            }

            /* Thêm CSS cho alert */
            .alert {
                margin-bottom: 20px;
                border-radius: 5px;
                padding: 15px;
                position: relative;
            }

            .alert-success {
                background-color: #d4edda;
                border-color: #c3e6cb;
                color: #155724;
            }

            .alert-danger {
                background-color: #f8d7da;
                border-color: #f5c6cb;
                color: #721c24;
            }

            .alert-dismissible .btn-close {
                position: absolute;
                top: 0;
                right: 0;
                padding: 1rem;
                color: inherit;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <section class="hero-section">
            <div class="hero-content">
                <h1>Chào mừng đến với Nha Khoa</h1>
                <p>Chúng tôi cam kết mang đến cho bạn nụ cười rạng rỡ và sức khỏe răng miệng tốt nhất</p>
                <% if (AuthUtils.isLoggedIn(session)) { %>
                <a href="MainController?action=addAppointmentForm" class="cta-button">Đặt lịch ngay</a>
                <%}%>
            </div>
        </section>

        <section class="services-section">
            
            <div class="container"> 
                <!-- Thêm phần hiển thị thông báo -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
                <% if (AuthUtils.isNotLog(session)) { %>
                <div class="services-grid">
                    <div class="service-card">
                        <img src="assets/images/th (1).jpg"   alt="Khám răng" class="service-image">
                        <div class="service-content">
                            <h3>Dịch vụ của chúng tôi</h3>
                            <p>Kiểm tra sức khỏe răng miệng định kỳ và tư vấn chuyên môn</p>
                            <br>
                            <a href="MainController?action=viewServices" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/th (2).jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Bảng giá dịch vụ</h3>
                            <p>Tích lũy giá trị, tích lũy niềm tin</p>  
                            <br>
                            <a href="MainController?action=viewServices#price-table" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>

                </div>
                <% }%>

                <% if (AuthUtils.isAdmin(session)) { %>
                <div class="services-grid">
                    <div class="service-card">
                        <img src="assets/images/th (1).jpg"   alt="Khám răng" class="service-image">
                        <div class="service-content">
                            <h3>Xem danh sách bệnh nhân</h3>
                            <br>
                            <a href="MainController?action=viewPatients" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/lienhe.png" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Danh sách liên hệ</h3>
                            <br>
                            <a href="MainController?action=viewContacts#price-table" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/lichhen.jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Danh sách lịch hẹn</h3>
                            <br>
                            <a href="MainController?action=viewAppointment#price-table" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                </div>
                <% }%>

                <% if (AuthUtils.isUser(session)) { %>
                <div class="services-grid">
                    <div class="service-card">
                        <img src="assets/images/th (1).jpg"   alt="Khám răng" class="service-image">
                        <div class="service-content">
                            <h3>Xem hồ sơ khám và đơn thuốc</h3>
                            <br>
                            <a href="MainController?action=viewPatientRecords" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/lichhen.jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Xem lịch hẹn</h3>
                            <br>
                            <a href="MainController?action=viewPatientAppointment" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/lichhen.jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Đặt lịch hẹn</h3>
                            <br>
                            <a href="MainController?action=addAppointmentForm" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                </div>
                <% }%>

                <% if (AuthUtils.isBoss(session)) { %>
                <div class="services-grid">
                    <div class="service-card">
                        <img src="assets/images/416-1584499148-7463-1584511148.jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Xem bảng dịch vụ</h3>  
                            <br>
                            <a href="MainController?action=viewServices#price-table" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/th (2).jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Xem danh sách bệnh nhân</h3>  
                            <br>
                            <a href="MainController?action=viewPatients" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/lienhe.png" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Danh sách liên hệ</h3>
                            <br>
                            <a href="MainController?action=viewContacts#price-table" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/lichhen.jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Danh sách lịch hẹn</h3>
                            <br>
                            <a href="MainController?action=viewAppointment#price-table" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/images.jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Xem danh sách bác sĩ</h3>
                            <br>
                            <a href="MainController?action=viewDoctors" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                    <div class="service-card">
                        <img src="assets/images/images.jpg" alt="Tẩy trắng răng" class="service-image">
                        <div class="service-content" >
                            <h3>Tạo tài khoản dành cho bác sĩ</h3>
                            <br>
                            <a href="DangKyBS.jsp" class="cta-button">Tìm hiểu ngay</a>
                        </div>
                    </div>
                </div>
                <% }%>

            </div>
        </div>
    </section>
    <%--
            <section class="features-section">
                <div class="container">
                    <div class="section-title">
                        <h2>Tại sao chọn chúng tôi?</h2>
                        <p>Những lý do khiến chúng tôi trở thành lựa chọn hàng đầu</p>
                    </div>
                    <div class="features-grid">
                        <div class="feature-card">
                            <div class="feature-icon">👨‍⚕️</div>
                            <h3>Đội ngũ bác sĩ chuyên môn</h3>
                            <p>Đội ngũ bác sĩ giàu kinh nghiệm và tận tâm</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">🏥</div>
                            <h3>Cơ sở vật chất hiện đại</h3>
                            <p>Trang thiết bị y tế tiên tiến, phòng khám sạch sẽ</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">💯</div>
                            <h3>Chất lượng dịch vụ</h3>
                            <p>Cam kết mang đến dịch vụ tốt nhất cho khách hàng</p>
                        </div>
                    </div>
                </div>
            </section>
    --%>
    <section class="contact-section">
        <div class="container">
            <div class="section-title">
                <h2>Liên hệ với chúng tôi</h2>
                <p>Hãy để lại thông tin, chúng tôi sẽ liên hệ với bạn</p>
            </div>

            <!-- Thêm phần hiển thị thông báo -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="contact-grid">
                <div class="contact-info">
                    <h3>Thông tin liên hệ</h3>
                    <p>76 Lê Đức Thọ, Quận 1, TP.HCM</p>
                    <p>📞 (84) 0908042***</p>
                    <p>✉️ info@nhakhoa.com</p>
                </div>
                <div class="contact-form">
                    <form action="MainController" method="POST">
                        <input type="hidden" name="action" value="addContact">
                        <div class="form-group">
                            <label for="name">Họ và tên</label>
                            <input type="text" id="name" name="ten" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Số điện thoại</label>
                            <input type="tel" id="phone" name="sdt" required>
                        </div>
                        <div class="form-group">
                            <label for="message">Nội dung</label>
                            <textarea id="message" name="noiDung" required></textarea>
                        </div>
                        <button type="submit" class="submit-button">Gửi tin nhắn</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
