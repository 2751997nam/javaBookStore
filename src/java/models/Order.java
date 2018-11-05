/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.HashMap;

/**
 *
 * @author ASUS
 */
public class Order extends Model{
    protected String address;
    protected String phone;
    protected String note;
    protected int user_id;
    protected User user;
    protected int status;

    public Order(HashMap<String, String> cols) {
        super(cols);
        this.address = cols.get("address");
        this.phone = cols.get("phone");
        this.note = cols.get("note");
        this.user_id = Integer.parseInt(cols.get("user_id"));
        this.status = Integer.parseInt(cols.get("status"));
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
    
    public User user()
    {
        if(this.user != null) return this.user;
        
        return this.user = (User) this.hasOne("users", "User");
    }
    
}
