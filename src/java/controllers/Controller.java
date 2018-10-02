/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import config.Database;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import models.database.DB;

/**
 *
 * @author ASUS
 */
public class Controller extends HttpServlet {

    public void auth(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        String remember = "";
        for (Cookie cookie : cookies) {
            if (cookie.getName().compareTo("remember") == 0) {
                remember = cookie.getValue();
                break;
            }
        }
        
        if (remember.length() > 0) {
            if (User.checkAuth(remember)) {
                User user = (User) new DB("users", "User").where("remember_token", "=", remember).get().get(0);
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
            }
        }
    }

    public void setPaginate(HttpServletRequest request, String table) {
        int current = 1;
        if (request.getParameter("page") != null) {
            current = Integer.parseInt(request.getParameter("page"));
        }
        int limit = Integer.parseInt(new Database().get("paginate"));
        int page_number = new DB(table).getPageNumber(limit, current);

        StringBuffer current_url = request.getRequestURL();
        String[] links = new String[5];
        links[0] = current_url + "?page=1";
        links[1] = current_url + "?page=" + (current != 1 ? current - 1 : 1);
        links[2] = current_url + "?page=" + current;
        links[3] = current_url + "?page=" + (current != page_number ? current + 1 : page_number);
        links[4] = current_url + "?page=" + page_number;

        request.setAttribute("page_number", page_number);
        request.setAttribute("links", links);
        request.setAttribute("current", current);
        request.setAttribute("perpage", limit);
        request.setAttribute("url", current_url + "?page=");
    }
}
