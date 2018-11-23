/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.users;

import controllers.Controller;
import static controllers.Controller.number;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ManagerController", urlPatterns = {"/admin/managers"})
public class ManagerController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        String search = request.getParameter("search");
        search = search == null ? "" : search;
        ArrayList<User> users = (ArrayList<User>) new DB("users", "User")
                .where("email", "like", "%" + search + "%")
                .where("role_id", "=", "3")
                .orderBy("created_at")
                .paginate(request)
                .get();
        request.setAttribute("users", users);
        this.setPaginate(request, number);
        showView(request, response, "admin/users/manager");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
    }
}
