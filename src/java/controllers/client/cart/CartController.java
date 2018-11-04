/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Book;
import models.User;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class CartController extends HttpServlet {

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
        HttpSession session = request.getSession();
        String email = session.getAttribute("email") + "";
        if (session.getAttribute("email") != null) {
            List list = new DB("users", "User").where("email", "=", email).get();
            if(list.isEmpty()){
                session.removeAttribute("email");
                session.removeAttribute("book_cart");
                response.sendRedirect("/bookstore/login");
            }
            User user = (User) list.get(0);
            List<Book> books = user.getBooksInCart();
            request.setAttribute("books", books);
            request.getRequestDispatcher("/WEB-INF/client/cart.jsp").forward(request, response);
        }else{
            response.sendRedirect("/bookstore/login");
        }

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
