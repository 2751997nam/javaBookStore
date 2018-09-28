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
 * @author ASUS
 */
public class BookUser extends Model{
    protected int quantity;
    protected User user;
    protected Book book;

    public BookUser() {
        super();
        this.quantity = 0;
        this.user = new User();
        this.book = new Book();
    }

    public BookUser(HashMap<String, String> cols) {
        super(cols);
        this.quantity = Integer.parseInt(cols.get("quantity"));
        this.user = (User) new DB("users", "User").find(Integer.parseInt(cols.get("user_id")));
        this.book = (Book) new DB("books", "Book").find(Integer.parseInt(cols.get("book_id")));
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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
}
