package servlet;

import dao.UserDAO;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    private static final String SMTP_EMAIL = "your.email@gmail.com";
    private static final String SMTP_PASSWORD = "your-app-password";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("student_id");
        String email = request.getParameter("email");

        UserDAO dao = new UserDAO();

        if (!dao.verifyIdentity(studentId, email)) {
            request.setAttribute("error", "No account found with that ID and email combination.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        String tempPassword = generateTempPassword();

        if (!dao.resetPassword(studentId, tempPassword)) {
            request.setAttribute("error", "Could not reset password. Please try again.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        boolean emailSent = sendEmail(email, tempPassword);

        if (emailSent) {
            request.setAttribute("success",
                "A new temporary password has been sent to <b>" + email + "</b>. Check your inbox and sign in with it.");
        } else {
            request.setAttribute("success",
                "Your password has been reset. Your new temporary password is: <b>" + tempPassword + "</b><br>Please sign in and change it immediately.");
        }

        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }

    private String generateTempPassword() {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    private boolean sendEmail(String toEmail, String tempPassword) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                        return new javax.mail.PasswordAuthentication(SMTP_EMAIL, SMTP_PASSWORD);
                    }
                });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("E-Lost: Your Password Has Been Reset");
            message.setContent(
                "<div style='font-family:Arial,sans-serif;max-width:480px;'>"
                + "<h2 style='color:#1B2A4A;'>Campus Lost &amp; Found Ledger</h2>"
                + "<p>Your password has been reset. Here is your new temporary password:</p>"
                + "<div style='background:#f4f4f4;padding:16px 20px;font-size:22px;"
                + "font-family:monospace;letter-spacing:2px;font-weight:bold;text-align:center;"
                + "border-left:4px solid #8b2e2a;margin:16px 0;'>"
                + tempPassword
                + "</div>"
                + "<p>Please sign in and change your password immediately.</p>"
                + "<p style='color:#888;font-size:13px;margin-top:24px;'>"
                + "If you did not request this reset, please contact the administrator.</p>"
                + "</div>",
                "text/html");

            Transport.send(message);
            return true;

        } catch (Exception e) {
            System.out.println("Email sending failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}