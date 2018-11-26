/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.orders;

import controllers.Controller;
import static controllers.Controller.number;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Book;
import models.OrderDetail;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "AdminOrderController", urlPatterns = {"/admin/orders"})
public class AdminOrderController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        String search = request.getParameter("search");
        search = search == null ? "" : search;
        String status = request.getParameter("status");
        ArrayList<HashMap<String, String>> orders;
        System.out.println(status);
        if (status == null || status.compareTo("") == 0) {
            orders = (ArrayList<HashMap<String, String>>) new DB("orders")
                    .select("orders.*, users.email, users.name")
                    .join("users", "orders.user_id", "users.id")
                    .where("users.email", "like", "%" + search + "%")
                    .orderBy("orders.created_at desc")
                    .paginate(request)
                    .get();
        } else {
            orders = (ArrayList<HashMap<String, String>>) new DB("orders")
                    .select("orders.*, users.email, users.name")
                    .join("users", "orders.user_id", "users.id")
                    .where("users.email", "like", "%" + search + "%")
                    .where("orders.status", "=", status)
                    .orderBy("orders.created_at desc")
                    .paginate(request)
                    .get();
        }
        this.setPaginate(request, number);

        request.setAttribute("orders", orders);
        showView(request, response, "admin/orders/index");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        String id = request.getParameter("id");

        ArrayList<OrderDetail> orderDetails = (ArrayList<OrderDetail>) new DB("order_details", "OrderDetail").where("order_id", "=", id).get();
        DB db = new DB("books");
        Connection con = db.getConnection();
        try {
            con.setAutoCommit(false);
            for (OrderDetail detail : orderDetails) {
                HashMap<String, String> map = new HashMap();
                Book book = (Book) db.newQuery("books", "Book").find(detail.getBook_id());
                if (book.getQuantity() >= detail.getQuantity()) {
                    map.put("quantity", "" + (book.getQuantity() - detail.getQuantity()));
                    db.newQuery("books").where("id", "=", "" + detail.getBook_id()).update(map);
                } else {
                    con.rollback();
                    request.setAttribute("message", "Order quantity bigger than book quantity");
                    return;
                }
            }

            HashMap<String, String> map = new HashMap();
            map.put("status", "2");
            new DB("orders").where("id", "=", id).update(map);

            con.commit();
        } catch (SQLException ex) {
            try {
                con.rollback();

                request.setAttribute("message", ex);
            } catch (SQLException ex1) {
                request.setAttribute("message", ex1);
            }
        }

        request.setAttribute("message", "success");
    }
}
