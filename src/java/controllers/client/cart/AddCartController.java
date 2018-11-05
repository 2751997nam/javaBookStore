/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class AddCartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("email") != null) {
            User user = (User) new DB("users", "User").where("email", "=", (String) session.getAttribute("email")).get().get(0);
            String book_id = request.getParameter("book_id");
            String quantity = request.getParameter("quantity");
            String action = request.getParameter("action");
            HashMap<String, String> map = new HashMap();
            List book_users = (List) new DB("book_user").where("book_id", "=", book_id).where("user_id", "=", user.getId() + "").get();
            if (!book_users.isEmpty()) {
                HashMap<String, String> book_user = (HashMap) book_users.get(0);
                if (action == null) {
                    map.put("quantity", (Integer.parseInt(quantity) + Integer.parseInt(book_user.get("quantity"))) + "");
                } else {
                    map.put("quantity", Integer.parseInt(quantity) + "");
                }
                new DB("book_user").update(map).where("book_id", "=", book_id).where("user_id", "=", user.getId() + "").execute();

            } else {
//                xet so hang trong cart
//                int number = Integer.parseInt(session.getAttribute("book_cart") + "");
//                if( number == 1){
//                    request.setAttribute("error", "Cart is full");
//                    PrintWriter out = response.getWriter();
//                    out.println("Full r");
//                    return;
////                    request.getRequestDispatcher(request.getHeader("Referer")).forward(request, response);
//                }
                map.put("book_id", book_id);
                map.put("user_id", "" + user.getId());
                map.put("quantity", quantity);
                new DB("book_user").insert(map);
//                kiem tra t/h chua mua hang
                String book_cart = (String) session.getAttribute("book_cart");
                if(book_cart.isEmpty()){
                    book_cart = "1";
                }else{
                     book_cart = (Integer.parseInt(book_cart) + 1) + "";
                }
                session.setAttribute("book_cart", book_cart);
            }
            response.sendRedirect(request.getHeader("Referer"));
        } else {
            request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);
        }
    }
}
