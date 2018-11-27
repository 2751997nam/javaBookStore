/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class CommentController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
//        PrintWriter out = response.getWriter();
//        out.println(request.getParameter("content"));
        if (session.getAttribute("email") != null) {
            List<User> userList = new DB("users", "User").where("email", "=", session.getAttribute("email") + "").get();
            if (userList.isEmpty()) {
                response.sendRedirect("login");
                return;
            }
            User user = userList.get(0);
            HashMap<String, String> comment = new HashMap();
            comment.put("book_id", request.getParameter("book_id"));
            comment.put("user_id", user.getId() + "");
            comment.put("content", request.getParameter("content"));
            new DB("comments", "Comment").insert(comment);
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }
        response.sendRedirect("login");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
}
