/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.books;

import controllers.Controller;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Book;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "AddBookController", urlPatterns = {"/admin/books/add"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 5) // 5MB

public class AddBookController extends Controller {

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
        List categories = new DB("categories", "Category").orderBy("name").get();
        request.setAttribute("categories", categories);
        RequestDispatcher dispathcher = request.getRequestDispatcher("/WEB-INF/admin/books/add.jsp");
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HashMap<String, String> map = new HashMap();
            map.put("name", request.getParameter("name"));
            map.put("author", request.getParameter("author"));
            map.put("publisher", request.getParameter("publisher"));
            map.put("price", request.getParameter("price"));
            map.put("quantity", request.getParameter("quantity"));
            map.put("description", request.getParameter("description"));
            
            String[] categories = request.getParameterValues("categories");
            
            String image = uploadFile(request);
            
            new DB("books").insert(map);
            Book book = (Book) new DB("books", "Book").orderBy("created_at desc").limit(1).get().get(0);
            
            map = new HashMap<String, String>();
            map.put("link", image);
            map.put("book_id", "" + book.getId());
            new DB("images").insert(map);
            
            for(String cate: categories) {
                map = new HashMap<String, String>();
                map.put("book_id", "" + book.getId());
                map.put("category_id", cate);
                new DB("book_category").insert(map);
            }
            
            response.sendRedirect("/bookstore/admin/books");
        } catch (IOException e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/bookstore/admin/books/add");
            dispatcher.forward(request, response);
        }
    }
}
