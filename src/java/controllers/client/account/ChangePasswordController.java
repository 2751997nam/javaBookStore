/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client.account;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.MD5;
import models.Profile;
import models.User;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            User user = (User) new DB("users", "User").where("email", "=", session.getAttribute("email") + "").get().get(0);
            Profile profile = (Profile) new DB("profiles", "Profile").where("user_id", "=", user.getId() + "").get().get(0);
            request.setAttribute("profile", profile);
            request.getRequestDispatcher("/WEB-INF/client/change_password.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "");
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
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            User user = (User) new DB("users", "User").where("email", "=", (String) session.getAttribute("email")).get().get(0);
            if (user == null) {
                session.removeAttribute("email");
                session.removeAttribute("book_cart");
                response.sendRedirect(request.getContextPath() + "");
            }
            HashMap<String, String> map = new HashMap<>();
            String oldPW = MD5.md5(request.getParameter("opassword"));
            if (!oldPW.equals(user.getPassword() + "")) {
                session.setAttribute("message", "Your password is wrong!!!");
                response.sendRedirect(request.getHeader("Referer"));
                return;
            }
            map.put("password", MD5.md5(request.getParameter("password")));
            new DB("users").where("email", "=", user.getEmail()).update(map);
            session.setAttribute("message", "Success");
            request.setAttribute("user", user);
            response.sendRedirect(request.getHeader("Referer"));
            return;
        } else {
            response.sendRedirect(request.getContextPath() + "");
        }
    }

}
