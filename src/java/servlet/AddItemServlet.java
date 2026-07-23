package servlet;

import bean.Item;
import bean.User;
import dao.ItemDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddItemServlet")
public class AddItemServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        Item item = new Item();

        item.setItemName(request.getParameter("item_name"));
        item.setCategory(request.getParameter("category"));
        item.setReportType(request.getParameter("report_type"));
        item.setDateLostFound(request.getParameter("date_lost_found"));
        item.setDescription(request.getParameter("description"));
        item.setBuilding(request.getParameter("building"));
        item.setSpecificLoc(request.getParameter("specific_loc"));

        item.setPhoto("");

        item.setStatus("Pending");

        item.setUserId(user.getUserId());

        ItemDAO dao = new ItemDAO();

        if (dao.addItem(item)) {

            response.sendRedirect("04_items.jsp");

        } else {

            response.sendRedirect("05_report.jsp");

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