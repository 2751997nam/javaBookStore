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
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/client/index.jsp");
        List<Book> top_sell = new Book().topSell();
//        List<Book> literary = ((Category)new DB("categories", "Category").where("id", "=", "3").get().get(0)).books();
//        PrintWriter out = response.getWriter();
//        top_sell.forEach((book) -> {
//            out.println(new DB("categories", "Category").where("id", "=", "3").checkQuery());
//        });
        request.setAttribute("top_sell", top_sell);
//        request.setAttribute("literary", literary);
        dispatcher.forward(request, response);
    }
}
