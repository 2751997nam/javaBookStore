/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.HashMap;
import models.database.DB;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class Rate extends Model {

    protected User user;
    protected Book book;
    protected int star;
    protected String comment;

    public Rate() {
        super();
        this.user = new User();
        this.book = new Book();
        this.star = 0;
        this.comment = "";
    }

    public Rate(HashMap<String, String> cols) {
        super(cols);
        this.user = (User) new DB("users", "User").find(Integer.parseInt(cols.get("user_id")));
        this.book = (Book) new DB("books", "Book").find(Integer.parseInt(cols.get("book_id")));
        this.star = Integer.parseInt(cols.get("star"));
        this.comment = cols.get("comment");
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    public JSONObject toJson() {
        JSONObject json = new JSONObject();
        json.put("id", this.getId());
        json.put("user_id", this.user.getId());
        json.put("book_id", this.book.getId());
        json.put("star", this.star);
        json.put("comment", this.comment);
        return json;
    }
}
