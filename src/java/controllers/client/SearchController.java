/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Book;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class SearchController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String q = request.getParameter("q");
        String filter = request.getParameter("filter");
        List<Book> books = null;
        String query = "";
        if (filter == null) {
            books = (List) new DB("books", "Book").where("name", "LIKE", "%" + q + "%").get();
        } else {
            switch (filter) {
                case "top sell":
                    books = new Book().topSell();
                    request.setAttribute("filter", filter);
                    break;
                case "new update":
                    books = new Book().newBooks();
                    request.setAttribute("filter", filter);
                    break;
                case "recommend":
                    books = new Book().recommendBooks();
                    request.setAttribute("filter", filter);
                    break;
                default:
                    query = "SELECT b.id, b.name, b.author, b.price, b.description, b.quantity, b.publisher, b.created_at, b.updated_at "
                            + "FROM ((( SELECT * FROM books WHERE books.name LIKE '%" + q + "%') AS b "
                            + "INNER JOIN book_category ON book_category.book_id = b.id) "
                            + "INNER JOIN categories ON categories.id = book_category.category_id AND categories.name ='" + filter + "')";
                    books = new DB("books", "Book").execute(query);
                    request.setAttribute("filter", filter);
                    break;
            }
        }
        request.setAttribute("key", q);
        request.setAttribute("books", books);
        request.getRequestDispatcher("/WEB-INF/client/search.jsp").forward(request, response);
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
        String[] values = request.getParameterValues("filter");
        PrintWriter out = response.getWriter();
        for (String value : values) {
            out.println(value);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
