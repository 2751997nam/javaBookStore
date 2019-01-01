/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.client.rating;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Rate;
import models.User;
import models.database.DB;
import org.json.simple.JSONObject;

/**
 *
 * @author nguye
 */
@WebServlet(name = "RatingController", urlPatterns = {"/rating"})
public class RatingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();

        if (session.getAttribute("email") != null) {
            User user = (User) new DB("users", "User").where("email", "=", session.getAttribute("email") + "").get().get(0);
            //kiem tra xem da danh gia chua
            if (checkRating(user.getId(), Integer.parseInt(request.getParameter("book_id")))) {
                json.put("error", "Khach hang da danh gia san pham nay roi");
                out.print(json);
                return;
            }
            //kiem tra xem sach nay duoc khach hang nay mua chua
            if (!checkBuyBook(user.getId(), Integer.parseInt(request.getParameter("book_id")))) {
                json.put("error", "Khach hang chua mua san pham nay");
                out.print(json);
                return;
            }
            //danh gia thanh cong
            HashMap<String, String> map = new HashMap<>();
            map.put("star", request.getParameter("star"));
            map.put("comment", request.getParameter("comment"));
            map.put("book_id", request.getParameter("book_id"));
            map.put("user_id", user.getId() + "");
            new DB("rates", "Rate").insert(map);
            //gui lai danh gia de hien thi
            Rate rate = (Rate) new DB("rates", "Rate").where("book_id", "=", request.getParameter("book_id")).where("user_id", "=", user.getId() + "").get().get(0);
            json.put("rate", rate.toJson());
            out.print(json);
        } else {
            json.put("error", "Please login");
            out.print(json);
        }
    }

    public boolean checkBuyBook(int user_id, int book_id) {
        String query = "SELECT od.name  FROM `order_details` as od, "
                + "(SELECT id FROM `orders` WHERE `user_id` = " + user_id + ") as o WHERE `order_id` = o.id AND `book_id` =" + book_id;
        return new DB().checkQuery(query);
    }

    public boolean checkRating(int user_id, int book_id) {
        String query = "SELECT id FROM `rates` WHERE `user_id` =" + user_id + " AND `book_id` =" + book_id;
        return new DB().checkQuery(query);
    }
}
