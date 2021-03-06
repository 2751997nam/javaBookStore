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
import models.User;
import models.Profile;
import models.database.DB;
import controllers.Controller;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 *
 * @author nguye
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 5) // 5MB

public class ProfileController extends Controller {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            User user = (User) new DB("users", "User").where("email", "=", (String) session.getAttribute("email")).get().get(0);
            if (user == null) {
                session.removeAttribute("email");
                session.removeAttribute("book_cart");
                response.sendRedirect(request.getContextPath() + "");
            }
            Profile profile = (Profile) new DB("profiles", "Profile").where("user_id", "=", user.getId() + "").get().get(0);
            request.setAttribute("profile", profile);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/client/profile.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        if (session.getAttribute("email") != null) {
            User user = (User) new DB("users", "User").where("email", "=", (String) session.getAttribute("email")).get().get(0);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "");
            }
            if (user.getName().compareToIgnoreCase(request.getParameter("name") + "") != 0) {
                HashMap<String, String> userMap = new HashMap();
                userMap.put("name", request.getParameter("name"));
                new DB("users").where("id", "=", user.getId() + "").update(userMap);
            }

            HashMap<String, String> map = new HashMap();
            Part part = request.getPart("avatar");
            if (part.getSize() != 0) {
                String image = uploadFile(request);
                map.put("avatar", image);
            }
            map.put("phone", request.getParameter("phone"));
            map.put("address", request.getParameter("address"));
            map.put("gender", (request.getParameter("gender").equals("male") ? "1" : "0"));
            map.put("date_of_birth", request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day"));
            new DB("profiles", "Profile").where("user_id", "=", user.getId() + "").update(map);
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
}
