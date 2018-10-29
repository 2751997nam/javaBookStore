/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.categories;

import config.Database;
import controllers.Controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "CategoryController", urlPatterns = {"/admin/categories"})
public class CategoryController extends Controller {

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
        String search = request.getParameter("search");
        search = search == null ? "" : search;
        ArrayList<Category> categories = (ArrayList<Category>) new DB("categories", "Category")
                .where("name", "like", "%" + search + "%")
                .orderBy("name")
                .paginate(
                        request,
                        Integer.parseInt(new Database().get("paginate"))
                )
                .get();

        request.setAttribute("categories", categories);
        this.setPaginate(request, number);
        RequestDispatcher dispathcher = request.getRequestDispatcher("/WEB-INF/admin/categories/index.jsp");
        dispathcher.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
