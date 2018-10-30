/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.books;

import controllers.Controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import models.Book;
import models.Category;
import models.Image;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "EditBookController", urlPatterns = {"/admin/books/edit"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 5) // 5MB

public class EditBookController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        Book book = (Book) new DB("books", "Book").find(id);
        ArrayList<Category> categories = (ArrayList<Category>) new DB("categories", "Category").orderBy("name").get();
        ArrayList<Category> bookCates = (ArrayList<Category>) book.categories();
        request.setAttribute("book", book);
        request.setAttribute("categories", categories);
        request.setAttribute("bookCates", bookCates);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/books/edit.jsp");
        dispatcher.forward(request, response);
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
        if(!this.auth(request)) {
            response.sendRedirect("/bookstore/admin");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        String[] cateIds = request.getParameterValues("categories");
        System.out.println(request.getParameter("categories"));
        if (cateIds != null) {
            new DB("book_category")
                    .where("book_id", "=", "" + id)
                    .delete()
                    .execute();
            for (String cate : cateIds) {
                HashMap<String, String> map = new HashMap();
                map.put("category_id", cate);
                map.put("book_id", "" + id);
                new DB("book_category")
                        .insert(map);
            }
        }

        Part part = request.getPart("image");

        if (part != null && !extractFileName(part).isEmpty()) {
            String image = uploadFile(request);
            ArrayList<Image> images = (ArrayList<Image>) new DB("images", "Image").where("book_id", "=", "" + id).get();
            for (Image img : images) {
                deleteFile(request, img.getLink());
            }
            HashMap<String, String> map = new HashMap();
            map.put("link", image);
            if (images.size() > 0) {
                new DB("images")
                        .where("book_id", "=", "" + id)
                        .update(map);
            } else {
                map.put("book_id", "" + id);
                new DB("images")
                        .insert(map);
            }
        }

        new DB("books")
                .where("id", "=", "" + id)
                .update(this.getOnly(request, new String[]{
            "name",
            "author",
            "description",
            "publisher",
            "price",
            "quantity"
        }));

        response.sendRedirect("/bookstore/admin/books");
    }
}
