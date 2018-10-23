/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import models.Profile;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("email") != null){
            User user = (User) new DB("users", "User").where("email", "=", (String)session.getAttribute("email")).get().get(0);
            if(user == null){
                response.sendRedirect(request.getContextPath() + "");
            }
            request.setAttribute("name", user.getName());
            request.setAttribute("email", user.getEmail());
            request.setAttribute("profile", user.hasOne("profiles", "Profile"));
            request.getRequestDispatcher("/WEB-INF/client/profile.jsp").forward(request, response);
        }
        else{
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
        if(session.getAttribute("email") != null){
            User user = (User)new DB("users", "User").where("email","=",(String)session.getAttribute("email")).get().get(0);
            if(user == null){
                response.sendRedirect(request.getContextPath() + "");
            }
            DB db = new DB("profiles");
            HashMap<String, String> map = new HashMap();
            map.put("user_id", "" + user.getId());
            map.put("phone", request.getParameter("phone"));
            map.put("gender", (request.getParameter("gender") == "male" ? "0":"1"));
            map.put("date_of_birth",request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day"));
            db.insert(map);
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
}
