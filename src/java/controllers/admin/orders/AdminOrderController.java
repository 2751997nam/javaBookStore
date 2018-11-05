/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.orders;

import controllers.Controller;
import static controllers.Controller.number;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        if(status == null || status.compareTo("") == 0) {
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
        HashMap<String, String> map = new HashMap();
        map.put("status", "2");
        new DB("orders").where("id", "=", id).update(map);
    }
}
