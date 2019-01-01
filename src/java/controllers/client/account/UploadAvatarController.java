/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client.account;

import controllers.Controller;
import java.io.IOException;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import models.database.DB;

/**
 *
 * @author nguye
 */
@WebServlet(name = "UploadAvatarController", urlPatterns = {"/profile/upload"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 5) // 5MB

public class UploadAvatarController extends Controller {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            User user = (User) new DB("users", "User").where("email", "=", (String) session.getAttribute("email")).get().get(0);
            String image = uploadFile(request);
            
            HashMap<String, String> data = new HashMap<>();
            data.put("avatar", image);
            new DB("profiles", "Profile").where("user_id", "=", user.getId() + "").update(data);
            response.sendRedirect("/bookstore/profile");
            return;
        }
        response.sendRedirect("/login");
    }
}
