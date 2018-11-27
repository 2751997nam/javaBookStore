/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.users;

import controllers.Controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.MD5;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "AddManagerController", urlPatterns = {"/admin/managers/add"})
public class AddManagerController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        showView(request, response, "admin/users/add_manager");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }

        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        if (name == null || name.equals("") || password == null || password.equals("") || email == null || email.equals("")) {
            request.setAttribute("message", "Please input required field");
            showView(request, response, "admin/users/add_manager");
            return;
        }

        if (new DB("users").where("email", "=", email).checkQuery()) {
            request.setAttribute("message", "This email was existed");
            showView(request, response, "admin/users/add_manager");
            return;
        };

        password = MD5.md5(password);

        HashMap<String, String> map = new HashMap<>();
        map.put("name", name);
        map.put("email", email);
        map.put("password", password);
        map.put("role_id", "3");
        map.put("status", "1");
        map.put("remember_token", "");
        new DB("users").insert(map);

        response.sendRedirect("/bookstore/admin/managers");
    }
}
