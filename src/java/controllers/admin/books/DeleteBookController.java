/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.books;

import controllers.Controller;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Image;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "DeleteBookController", urlPatterns = {"/admin/books/delete"})
public class DeleteBookController extends Controller {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        int id = Integer.parseInt(request.getParameter("id"));
        ArrayList<Image> images = (ArrayList<Image>) new DB("images", "Image")
                                    .where("book_id", "=", "" + id)
                                    .get();
        for(Image img: images) {
            deleteFile(request, img.getLink());
        }
        new DB("books").delete().where("id", "=", "" + id).execute();
        
        String url = (String) request.getHeader("Referer");
        response.sendRedirect(url);
    }
}
