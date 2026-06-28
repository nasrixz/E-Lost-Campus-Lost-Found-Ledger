package servlet;

import bean.User;
import dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lname");
        String studentId = request.getParameter("student_id");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String faculty = request.getParameter("department");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Password and Confirm Password do not match.");
            request.getRequestDispatcher("02_register.jsp").forward(request, response);
            return;
        }

        User user = new User();

        user.setFullName(firstName + " " + lastName);
        user.setStudentId(studentId);
        user.setEmail(email);
        user.setPhone(phone);
        user.setFaculty(faculty);
        user.setPasswordHash(password);
        user.setRole("student");

        UserDAO dao = new UserDAO();

        if (dao.register(user)) {
            response.sendRedirect("01_login.jsp");
        } else {
            request.setAttribute("error", "Registration failed.");
            request.getRequestDispatcher("02_register.jsp").forward(request, response);
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