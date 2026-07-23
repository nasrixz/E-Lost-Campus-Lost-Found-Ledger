package servlet;

import dao.ItemDAO;
import dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        ItemDAO itemDao = new ItemDAO();
        UserDAO userDao = new UserDAO();

        switch (action) {

            case "verify":
                int verifyId = Integer.parseInt(request.getParameter("item_id"));
                itemDao.updateItemStatus(verifyId, "Found");
                break;

            case "reject":
                int rejectId = Integer.parseInt(request.getParameter("item_id"));
                itemDao.deleteItem(rejectId);
                break;

            case "delete_user":
                int deleteUserId = Integer.parseInt(request.getParameter("user_id"));
                userDao.deleteUser(deleteUserId);
                break;

            case "toggle_role":
                int toggleUserId = Integer.parseInt(request.getParameter("user_id"));
                String currentRole = request.getParameter("current_role");
                String newRole = "student".equals(currentRole) ? "admin" : "student";
                userDao.updateUserRole(toggleUserId, newRole);
                break;
        }

        response.sendRedirect("06_admin.jsp");
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