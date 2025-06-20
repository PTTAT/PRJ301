<%-- 
    Document   : footer
    Created on : Feb 17, 2025, 10:56:02 AM
    Author     : trana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .footer {
        background-color: green;
        color: #fff;
        padding: 3rem 0;
        margin-top: 2rem;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1rem;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 2rem;
    }

    .footer-section h3 {
        font-size: 1.2rem;
        margin-bottom: 1rem;
        color: #3498db;
    }

    .footer-section p {
        margin-bottom: 0.5rem;
        font-size: 0.9rem;
        line-height: 1.5;
    }

    .footer-links {
        list-style: none;
    }

    .footer-links li {
        margin-bottom: 0.5rem;
    }

    .footer-links a {
        color: #fff;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .footer-links a:hover {
        color: #3498db;
    }

    .social-links {
        display: flex;
        gap: 1rem;
        margin-top: 1rem;
    }

    .social-links a {
        color: #fff;
        text-decoration: none;
        font-size: 1.5rem;
    }

    .copyright {
        text-align: center;
        padding-top: 2rem;
        margin-top: 2rem;
        border-top: 1px solid #34495e;
        font-size: 0.9rem;
    }
</style>

<footer class="footer">
    <div class="footer-container">
       

        <div class="footer-section">
            <h3>Liên kết nhanh</h3>
            <ul class="footer-links">
                <li><a href="index.jsp">Trang chủ</a></li>
                <li><a href="MainController?action=viewServices">Bảng giá</a></li>             
                <li><a href="AddLienHe.jsp">Liên hệ</a></li>
            </ul>
        </div>

        <div class="footer-section">
            <h3>Liên hệ</h3>
            <p>76 Lê Đức Thọ, Quận 1, TP.HCM</p>
            <p>📞 (84) 0908042***</p>
            <p>✉️ info@nhakhoa.com</p>
        </div>

        <div class="footer-section">
            <h3>Chính sách</h3>

            <ul class="footer-links">
                <li><a href="#">Chính sách bảo mật</a></li>
                <li><a href="#">Chính sách ưu đãi</a></li>
                <li><a href="#">Chính sách bảo hành</a></li>
            </ul>
        </div>

        <div class="footer-section">
            <h3>Theo dõi chúng tôi</h3>
            <p>Cập nhật tin tức mới nhất và khuyến mãi từ chúng tôi</p>
            <div class="social-links">
                <a href="#">📱</a>
                <a href="#">💬</a>
                <a href="#">📷</a>
            </div>
        </div>
    </div>

    <div class="copyright">
        <p>&copy; Nha Khoa. Tất cả quyền được bảo lưu.</p>
    </div>
</footer>