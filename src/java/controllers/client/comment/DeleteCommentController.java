/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client.comment;

import java.io.IOException;
import java.io.PrintWriter;
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
public class DeleteCommentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("email") != null){
            List<User> list = new DB("users", "User").where("email", "=", session.getAttribute("email") + "").get();
            if(!list.isEmpty()) {
                User user = list.get(0);
                String id_comment = request.getPathInfo().replace("/", "");
                PrintWriter out = response.getWriter();
                out.print(id_comment);
//                new DB("comments", "Comment").where("id", "=", id_comment).where("user_id", "=", user.getId() + "").delete().execute();
//                request.getRequestDispatcher(request.getHeader("Referer")).forward(request, response);
            }
            session.removeAttribute("email");
            session.removeAttribute("book_cart");
            response.sendRedirect("login");
        }
    }
}
