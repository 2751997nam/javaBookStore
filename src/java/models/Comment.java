/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.HashMap;
import models.database.DB;

/**
 *
 * @author nguye
 */
public class Comment extends Model{

    protected Book book;
    protected User user;
    private String content;

    public Comment() {
        super();
        this.book = new Book();
        this.user = new User();
        this.content = "";
    }

    public Comment(HashMap<String, String> data) {
        super(data);
        this.book = (Book) new DB("books", "Book").find(Integer.parseInt(data.get("book_id")));
        this.user = (User) new DB("users", "User").find(Integer.parseInt(data.get("user_id")));
        this.content = data.get("content");
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
