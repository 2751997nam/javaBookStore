/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.MD5;
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
        String email = request.getParameter("email");
        String password = MD5.md5(request.getParameter("password"));
        String name = request.getParameter("name");
        if (!User.checkExist(email)) {
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            Map<String, String> map = new HashMap<>();
            map.put("name", name);
            map.put("password", password);
            map.put("email", email);
            map.put("remember_token", "");
            map.put("role_id", "1");
            DB user = new DB("users");
            user.insert(map);
            session.setAttribute("email", email);
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }
        request.setAttribute("error", "Account already exists.");
        request.getRequestDispatcher("/WEB-INF/client/signup.jsp").forward(request, response);
    }

}
