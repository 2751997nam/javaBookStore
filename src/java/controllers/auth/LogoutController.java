/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.auth;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "LogoutController", urlPatterns = {"/admin/logout"})
public class LogoutController extends HttpServlet {

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            session.invalidate();
            response.sendRedirect("/bookstore");
            return;
        }
        Cookie remember_cookie = null;
        Cookie[] cookies = request.getCookies();
        String remember = "";
        for (Cookie cookie : cookies) {
            if (cookie.getName().compareTo("bookstore.remember") == 0) {
                remember = cookie.getValue();
                cookie.setMaxAge(0);
                cookie.setPath("");
                response.addCookie(cookie);
                break;
            }
        }

        HashMap<String, String> map = new HashMap();
        map.put("remember_token", "");
        new DB("users").where("id", "=", "" + user.getId()).update(map);
        session.invalidate();
        response.sendRedirect("/bookstore");
    }
}
