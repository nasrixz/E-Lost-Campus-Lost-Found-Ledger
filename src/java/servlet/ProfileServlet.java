package servlet;

import bean.User;
import dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("01_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();

        if ("update".equals(action)) {
            String fullName = request.getParameter("full_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String faculty = request.getParameter("faculty");

            if (dao.updateProfile(user.getUserId(), fullName, email, phone, faculty)) {
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setFaculty(faculty);
                session.setAttribute("user", user);
                request.setAttribute("success", "Profile updated successfully.");
            } else {
                request.setAttribute("error", "Failed to update profile.");
            }
        } else if ("password".equals(action)) {
            String oldPassword = request.getParameter("old_password");
            String newPassword = request.getParameter("new_password");
            String confirmPassword = request.getParameter("confirm_password");

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match.");
            } else if (newPassword.length() < 6) {
                request.setAttribute("error", "Password must be at least 6 characters.");
            } else if (dao.changePassword(user.getUserId(), oldPassword, newPassword)) {
                request.setAttribute("success", "Password changed successfully.");
            } else {
                request.setAttribute("error", "Current password is incorrect.");
            }
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
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