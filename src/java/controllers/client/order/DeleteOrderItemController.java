/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client.order;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class DeleteOrderItemController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            String id = request.getPathInfo().replace("/", "");
            new DB("order_details", "OrderDetail").where("id", "=", id).delete().execute();
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }
        session.removeAttribute("email");
        response.sendRedirect("login");
    }
}
