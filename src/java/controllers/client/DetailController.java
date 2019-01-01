/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Book;
import models.Comment;
import models.Rate;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class DetailController extends HttpServlet {

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
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/client/detail.jsp");
        String id = request.getPathInfo().replace("/", "");

        Book book = (Book) new DB("books", "Book").where("id", "=", id).get().get(0);
        List<Comment> comments = new DB("comments", "Comment").where("book_id", "=", book.getId() + "").limit(3).get();
        List<Rate> rates = new DB("rates", "Rate").where("book_id", "=", book.getId() + "").limit(3).get();
        List<Book> top_sell = new Book().topSell(5);

        request.setAttribute("book", book);
        request.setAttribute("comments", comments);
        request.setAttribute("rates", rates);
        request.setAttribute("top_sell", top_sell);
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
    }
}
