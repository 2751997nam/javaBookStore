/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import config.Database;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.BookUser;
import models.User;
import models.database.DB;

/**
 *
 * @author ASUS
 */
public class IndexController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
//        List users =  new User().getAllUser(request);
        //select tất cả các user, sắp xếp theo tên, và phân trang
        //kết quả trả về là 1 List các model User
        List users = new DB("users", "User")
                .orderBy("name")
                .paginate(request,
                        // lấy số lượng bản ghi tối đa mỗi trang, đọc trong file config/database.json
                        Integer.parseInt(new Database().get("paginate"))
                )
                // để thực hiện câu select thì luôn phải có get ở cuối
                .get();  
        //slect name, email trong bảng users order theo name
        // kết quả trả về là 1 List các HashMap<String, String>
        List u = new DB("users").select("name, email")
                //where nhận tham số là 1 mảng String
                .where(new String[]{
                    "role_id > 1",
                    "name LIKE '%a%'"
                }) 
                .orderBy("name")
                .get();
        
        
        //insert
        HashMap<String, String> map = new HashMap();
        map.put("link", "facebook.com");
        map.put("alternative", "fb");
        map.put("book_id", "2");
        
        new DB("images").insert(map);
        
        //update
        HashMap<String, String> map2 = new HashMap();
        map2.put("book_id", "3");
        //update book_id = 3 khi id = 2
        new DB("images").update(map2)
                        .where(new String[]{"id = '2'"})
                        .execute();
        
        //delete
        // xoa tat ca ban ghi co book_id > 1
        new DB("images").delete()
                .where(new String[]{"book_id > 1"})
                .execute();
        
        request.setAttribute("users", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("indexView");
        dispatcher.forward(request, response);
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
    }
}
