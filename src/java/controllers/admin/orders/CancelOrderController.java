/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin.orders;

import controllers.Controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.database.DB;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "CancelOrderController", urlPatterns = {"/admin/orders/cancel"})
public class CancelOrderController extends Controller {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            DB db = new DB("order_details");
            Connection conn = db.getConnection();
            conn.setAutoCommit(false);
            try {
                db.where("order_id", "=", id).delete().execute();
                db = db.newQuery("orders");
                db.where("id", "=", id).delete().execute();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                Logger.getLogger(CancelOrderController.class.getName()).log(Level.SEVERE, null, e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CancelOrderController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
