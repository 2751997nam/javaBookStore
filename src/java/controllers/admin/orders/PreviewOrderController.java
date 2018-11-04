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
import java.util.Enumeration;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Order;
import models.OrderDetail;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "PreviewOrderController", urlPatterns = {"/admin/orders/preview"})
public class PreviewOrderController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = (Order) new DB("orders", "Order").find(id);
        ArrayList<OrderDetail> details = (ArrayList<OrderDetail>) new DB("order_details", "OrderDetail")
                .where("order_id", "=", "" + id)
                .get();
        HashMap<String, String> sum = (HashMap<String, String>) new DB("order_details")
                .select("SUM(price * quantity) as total")
                .where("order_id", "=", "" + id)
                .get()
                .get(0);
        String total = sum.get("total");
        request.setAttribute("order", order);
        request.setAttribute("details", details);
        request.setAttribute("total", total);

        showView(request, response, "admin/orders/detail");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
