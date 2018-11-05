/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client;

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
import models.User;
import models.Order;
import models.Profile;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class OrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            User user = (User) new DB("users", "User").where("email", "=", session.getAttribute("email") + "").get().get(0);
            List<Order> Orders = new DB("orders", "Order").where("user_id", "=", user.getId() + "").get();
            request.setAttribute("orders", Orders);
            request.getRequestDispatcher("/WEB-INF/client/order/order.jsp").forward(request, response);
        } else {
            session.removeAttribute("email");
            session.removeAttribute("book_cart");
            response.sendRedirect("/bookstore/login");
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

            List list = new DB("users", "User").where("email", "=", session.getAttribute("email") + "").get();

            if (list.isEmpty()) {
                session.removeAttribute("email");
                session.removeAttribute("book_cart");
                response.sendRedirect("/bookstore/login");
                return;
            }
            User user = (User) list.get(0);
            List<Book> books = user.getBooksInCart();
            if (books.isEmpty()) {
                response.sendRedirect("/bookstore/cart");
                return;
            }
            HashMap<String, String> order = new HashMap<>();
            order.put("user_id", user.getId() + "");
            order.put("address", request.getParameter("address"));
            order.put("phone", request.getParameter("phone"));
            order.put("note", request.getParameter("note"));

            new DB("orders").insert(order);
            int order_id = Integer.parseInt(((Order) new DB("orders", "Order").where("user_id", "=", user.getId() + "").orderBy("created_at DESC").get().get(0)).getId() + "");
            for (Book book : books) {
                order.clear();
                order.put("name", book.getName());
                order.put("price", book.getPrice() + "");
                order.put("quantity", book.getQuantity() + "");
                order.put("order_id", order_id + "");
                order.put("book_id", book.getId() + "");
                new DB("order_details").insert(order);
                new DB("book_user").where("book_id", "=", book.getId() + "").delete().execute();
            }
            session.setAttribute("book_cart", "");
            response.sendRedirect("/bookstore/order");
            return;
        } else {
            response.sendRedirect("/bookstore/login");
            return;
        }
    }

}
