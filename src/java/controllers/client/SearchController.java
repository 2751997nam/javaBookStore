/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client;

import controllers.Controller;
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
public class SearchController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String q = request.getParameter("q");
        String filter = request.getParameter("filter");
        List<Book> books = null;
        String query = "";
        if (filter == null) {
            books = (List) new DB("books", "Book").where("name", "LIKE", "%" + q + "%").get();
        } else {
            switch (filter) {
                case "top sell":
                    books = new Book().topSell(10);
                    request.setAttribute("filter", filter);
                    break;
                case "new update":
                    books = new Book().newBooks(10);
                    request.setAttribute("filter", filter);
                    break;
                case "recommend":
                    books = new Book().recommendBooks(10);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] values = request.getParameterValues("filter");
        PrintWriter out = response.getWriter();
        for (String value : values) {
            out.println(value);
        }
    }
}
