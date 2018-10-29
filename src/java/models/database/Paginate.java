/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.database;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
public class Paginate {

    public void setPaginate(HttpServletRequest request, int page_number, int limit, int current) {
        StringBuffer current_url = request.getRequestURL();
        String search = request.getParameter("search");
        String url = current_url + "?";
        
        String[] links = new String[5];
        for(int i = 0; i < 5; i++) {
            links[i] += url;
            if(search != null) {
                links[i] += "&";
            }
        }
        links[0] += "page=1";
        links[1] += "page=" + (current != 1 ? current - 1 : 1);
        links[2] += "page=" + current;
        links[3] += "page=" + (current != page_number ? current + 1 : page_number);
        links[4] += "page=" + page_number;

        request.setAttribute("page_number", page_number);
        request.setAttribute("links", links);
        request.setAttribute("current", current);
        request.setAttribute("perpage", limit);
        request.setAttribute("url", url + "page=");
    }
}
