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
import models.MD5;
import models.Profile;
import models.User;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class SignUpController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/client/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String email = request.getParameter("email");
        String password = MD5.md5(request.getParameter("password"));
        String name = request.getParameter("name");
        if (!User.checkExist(email)) {
            HashMap<String, String> mapUser = new HashMap<>();
            mapUser.put("name", name);
            mapUser.put("password", password);
            mapUser.put("email", email);
            mapUser.put("remember_token", "");
            mapUser.put("role_id", 2 + "");
            mapUser.put("status", 1 + "");
            new DB("users").insert(mapUser);

            User user = (User) new DB("users", "User").where("email", "=", email).get().get(0);
            DB profileQuery = new DB("profiles");
            HashMap<String, String> mapProfile = new HashMap<>();
            mapProfile.put("user_id", user.getId() + "");
            mapProfile.put("gender", 1 + "");
            mapProfile.put("avatar", "profile.png");
            profileQuery.insert(mapProfile);
            Profile profile = (Profile) new DB("profiles", "Profile").where("user_id", "=", user.getId() + "").get().get(0);
            request.setAttribute("user", user);
            request.setAttribute("profile", profile);
            session.setAttribute("email", user.getEmail());
            session.setAttribute("book_cart", "");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }
        request.setAttribute("error", "Account already exists.");
        request.getRequestDispatcher("/WEB-INF/client/signup.jsp").forward(request, response);
    }

}
