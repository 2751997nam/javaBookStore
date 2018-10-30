package controllers.auth;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import controllers.Controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.MD5;
import models.RandomString;
import models.User;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(urlPatterns = {"/admin"})
public class AdminLoginController extends Controller {


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
        if(this.auth(request)) {
            response.sendRedirect("/bookstore/admin/books");
            return;
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/login.jsp");
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        password = MD5.md5(password);
        HttpSession session = request.getSession();
        String url = (String) request.getHeader("Referer");
        if (!User.checkAuth(email, password)) {
            session.setAttribute("message", "Email or password incorrect");
            response.sendRedirect(url);
            return;
        }
        User user = (User) new DB("users", "User").where("email", "=", email).get().get(0);
        session.setAttribute("user", user);
        
        if (request.getParameter("remember") != null && request.getParameter("remember").length() > 0) {
            String token = RandomString.randomString(40);
            HashMap<String, String> map = new HashMap();
            map.put("remember_token", token);
            new DB("users").where("id", "=", "" + user.getId()).update(map);
            
            Cookie cookie = new Cookie("bookstore.remember", token);
            cookie.setMaxAge(30 * 60 * 60 * 24);
            response.addCookie(cookie);
        }
        if(user.role().getName().compareTo("admin") == 0) {
            response.sendRedirect("/bookstore/admin/books");
            return;
        }
        response.sendRedirect("/bookstore/admin");
    }
}
