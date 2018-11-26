/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import config.Database;
import java.util.HashMap;

/**
 *
 * @author ASUS
 */
public class Profile extends Model{
    protected String avatar;
    protected String address;
    protected String date_of_birth;
    protected String phone;
    protected int gender;

    public Profile() {
        this.avatar = this.address = this.date_of_birth = this.phone = "";
        this.gender = 0;
    }

    public Profile(HashMap<String, String> cols) {
        super(cols);
        this.avatar = cols.get("avatar");
        this.address = cols.get("address");
        this.date_of_birth = cols.get("date_of_birth");
        this.phone = cols.get("phone");
        this.gender = Integer.parseInt(cols.get("gender"));
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(String date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }
    
    public String showAvatar() {
        return  new Database().get("img_path") + this.avatar;
    }
}
