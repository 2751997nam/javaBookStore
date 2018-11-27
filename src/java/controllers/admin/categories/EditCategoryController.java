/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.categories;

import controllers.Controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Category;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "EditCategoryController", urlPatterns = {"/admin/categories/edit"})
public class EditCategoryController extends Controller {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        String id = request.getParameter("id");
        Category category = (Category) new DB("categories", "Category").find(Integer.parseInt(id));
        request.setAttribute("category", category);

        showView(request, response, "admin/categories/edit");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        HashMap<String, String> map = new HashMap();
        map.put("name", name);
        new DB("categories")
                .where("id", "=", id)
                .update(map);

        response.sendRedirect("/bookstore/admin/categories");
    }
}
