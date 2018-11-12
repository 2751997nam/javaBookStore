/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin;

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
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "DashBoardController", urlPatterns = {"/admin/dashboard"})
public class DashBoardController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        ArrayList<HashMap<String, String>> revenues = (ArrayList<HashMap<String, String>>) 
                new DB().excuteWithoutClass("SELECT MONTH(created_at) as month, YEAR(created_at) as year, sum(price) as revenue \n"
                + "from ( SELECT orders.*, SUM(quantity * price) as price "
                + "FROM `orders` "
                + "INNER JOIN order_details "
                + "ON orders.id = order_details.order_id "
                + "WHERE status = 2 GROUP BY orders.id) as boxoffice "
                + "WHERE year(created_at) = year(CURRENT_DATE)"
                + "group by YEAR(created_at), MONTH(created_at) with rollup");
        request.setAttribute("revenues", revenues);

        showView(request, response, "admin/dashboard");
    }
}
