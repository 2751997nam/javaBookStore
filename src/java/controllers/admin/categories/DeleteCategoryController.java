/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.categories;

import controllers.Controller;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "DeleteCategoryController", urlPatterns = {"/admin/categories/delete"})
public class DeleteCategoryController extends Controller {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        String id = request.getParameter("id");
        new DB("categories").delete().where("id", "=", id).execute();

        String url = (String) request.getHeader("Referer");
        response.sendRedirect(url);
    }
}
