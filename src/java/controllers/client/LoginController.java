/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.MD5;
import models.User;

/**
 *
 * @author nguye
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        User user = checkCookie(request);
        if (action == null) {
            if (user == null) {
                request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);
            } else {
                if (!User.checkAuth(user.getEmail(), user.getPassword())) {
                    response.sendRedirect(request.getContextPath() + "/login");
                } else {
                    session.setAttribute("email", user.getEmail());
                    request.getRequestDispatcher("/WEB-INF/client/index.jsp").forward(request, response);
                }
            }
        } else {
            session.removeAttribute("email");
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie : cookies) {
                if (cookie.getName().equalsIgnoreCase("email")) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
                if (cookie.getName().equalsIgnoreCase("password")) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
           response.sendRedirect(request.getContextPath() + "/home"); 
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = MD5.md5(request.getParameter("password"));
        if (!User.checkAuth(email, password)) {
        request.setAttribute("error", "Email or password is incorrect.");
        request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);
        } else {
            if (request.getParameter("remember") != null) {
                Cookie cKEmail = new Cookie("email", email);
                cKEmail.setMaxAge(36000);
                response.addCookie(cKEmail);
                Cookie cKPass = new Cookie("password", password);
                cKPass.setMaxAge(36000);
                response.addCookie(cKPass);
            }
            session.setAttribute("email", email);
            response.sendRedirect(request.getContextPath() + "/home");

        }
    }

    private User checkCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        String email = "";
        String password = "";
        for (Cookie cookie : cookies) {
            if (cookie.getName().equalsIgnoreCase("email")) {
                email = cookie.getValue();
            }
            if (cookie.getName().equalsIgnoreCase("password")) {
                password = cookie.getValue();
            }
        }
        if (!email.isEmpty() && !password.isEmpty()) {
            return new User(email, password);
        }
        return null;
    }
}