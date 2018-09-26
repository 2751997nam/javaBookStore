/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.ArrayList;
import models.database.DB;

/**
 *
 * @author ASUS
 */
public class ProductUser extends Model{
    int id;
    Product product;
    User user;
    int quantity;

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public ProductUser(ArrayList<String> cols) {
        super(cols);
        this.id = Integer.parseInt(cols.get(0));
        this.user = (User) new DB("users", "models.User").find(Integer.parseInt(cols.get(1)));
        this.product = (Product) new DB("products", "models.Product").find(Integer.parseInt(cols.get(2)));
        this.quantity = Integer.parseInt(cols.get(3));
    }

    @Override
    public String toString() {
        return "ProductUser{" + "id=" + id + ", product=" + product.toString() + ", user=" + user.toString() + ", quantity=" + quantity + '}';
    }
    
    
}
