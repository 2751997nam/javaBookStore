/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.users;

import config.Database;
import controllers.Controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "UserController", urlPatterns = {"/admin/users"})
public class UserController extends Controller {

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
                .where("role_id", ">", "1")
                .paginate(request)
                .get();
        request.setAttribute("users", users);
        this.setPaginate(request, number);

        showView(request, response, "admin/users/index");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        User user = (User) new DB("users", "User").find(id);
        String status = user.getStatus() == 1 ? "2" : "1";
        HashMap<String, String> map = new HashMap();
        map.put("status", status);
        new DB("users").where("id", "=", "" + id).update(map);

        redirectBack(request, response);
    }
}
