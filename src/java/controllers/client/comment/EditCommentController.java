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
import javax.servlet.annotation.WebServlet;
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
@WebServlet(name = "EditCommentController", urlPatterns = {"/comment/edit"})
public class EditCommentController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            List<User> userList = new DB("users", "User").where("email", "=", session.getAttribute("email") + "").get();
            if (userList.isEmpty()) {
                response.sendRedirect("login");
                return;
            }
            User user = userList.get(0);
            HashMap<String, String> comment = new HashMap();
            comment.put("content", request.getParameter("content"));
            new DB("comments", "Comment").where("id", "=", request.getParameter("id")).update(comment);
            System.out.println();
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }
        response.sendRedirect("login");
    }

}
