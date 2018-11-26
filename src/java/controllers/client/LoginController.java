/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
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
                    response.sendRedirect("/bookstore");
                }
            }
        } else {
            session.removeAttribute("book_cart");
            session.removeAttribute("email");
            deleteCookie(request.getCookies(), response);
            response.sendRedirect(request.getContextPath() + "");
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
            User user = (User) new DB("users", "User").where("email", "=", email).get().get(0);
            if (user.getStatus() != 1) {
                request.setAttribute("error", "Your account has been locked");
                request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);
            } else {
                if (request.getParameter("remember") != null) {
                    addCookie(email, password, response);
                }
                int book_cart = new DB("book_user").where("user_id", "=", "" + user.getId()).get().size();
                session.setAttribute("email", email);
                session.setAttribute("book_cart", book_cart == 0 ? "" : book_cart);
                response.sendRedirect(request.getContextPath() + "");
            }

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

    private void addCookie(String email, String password, HttpServletResponse response) {
        Cookie cKEmail = new Cookie("email", email);
        cKEmail.setMaxAge(36000);
        response.addCookie(cKEmail);
        Cookie cKPass = new Cookie("password", password);
        cKPass.setMaxAge(36000);
        response.addCookie(cKPass);
    }

    private void deleteCookie(Cookie[] cookies, HttpServletResponse response) {
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
    }
}
