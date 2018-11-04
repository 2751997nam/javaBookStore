/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.orders;

import controllers.Controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Order;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "OrderController", urlPatterns = {"/admin/orders"})
public class OrderController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        String search = request.getParameter("search");
        search = search == null ? "" : search;
        ArrayList<HashMap<String, String>> orders = (ArrayList<HashMap<String, String>>) new DB("orders")
                .select("orders.*, users.email, users.name")
                .join("users", "orders.user_id", "users.id")
                .where("users.email", "like", "%" + search + "%")
                .orderBy("orders.created_at desc")
                .paginate(request)
                .get();
        request.setAttribute("orders", orders);
        this.setPaginate(request, number);
        showView(request, response, "admin/orders/index");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
