package controllers.client.order;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Book;
import models.Order;
import models.User;
import models.database.DB;
import models.OrderDetail;

/**
 *
 * @author nguye
 */
public class OrderDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        if (session.getAttribute("email") != null) {
            List<User> listUser = new DB("users", "User").where("email", "=", session.getAttribute("email") + "").get();
            if (listUser.isEmpty()) {
                session.removeAttribute("email");
                session.removeAttribute("book_cart");
                response.sendRedirect("/bookstore/login");
                return;
            }
            String action = request.getPathInfo().charAt(request.getPathInfo().length() - 1) + "";
            String paramater = request.getPathInfo().replace("/", "");
//            v có nghĩa là chỉ cho xem, vì order đã được giao
            if ("v".equals(action)) {
                action = "view";
                paramater = request.getPathInfo().substring(1, request.getPathInfo().length() - 1);
            }
            Order order = (Order) new DB("orders", "Order").where("id", "=", paramater).get().get(0);
            List<OrderDetail> items = (List) new DB("order_details", "OrderDetail").where("order_id", "=", paramater).get();
            request.setAttribute("action", action);
            request.setAttribute("items", items);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/WEB-INF/client/order/order_detail.jsp").forward(request, response);
        }
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
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            HashMap<String, String> item = new HashMap();
            item.put("quantity", Integer.parseInt(request.getParameter("quantity")) + "");
            new DB("order_details").where("id", "=", request.getParameter("order_detail_id")).update(item);
            response.sendRedirect(request.getHeader("Referer"));
            return;
        } else {
            response.sendRedirect("/bookstore/login");
            return;
        }
    }
}
