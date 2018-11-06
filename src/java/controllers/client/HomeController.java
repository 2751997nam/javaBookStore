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
import javax.servlet.http.HttpSession;
import models.Book;
import models.Category;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/client/index.jsp");
        List<Book> top_sell = new Book().topSell(5);
        List<Book> new_books = new Book().newBooks(5);
        List<Book> recommend_books = new Book().recommendBooks(7);
        request.setAttribute("recommend_books", recommend_books);
        request.setAttribute("top_sell", top_sell);
        request.setAttribute("new_books", new_books);
        dispatcher.forward(request, response);
    }
}
