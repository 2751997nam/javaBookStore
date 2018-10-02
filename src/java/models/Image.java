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
public class Image extends Model{
    protected String link;
    protected String alternative;
    protected Book book;

    public Image(HashMap<String, String> cols) {
        super(cols);
        this.link = cols.get("link");
        this.alternative = cols.get("alternative");
        this.book = (Book) new DB("books", "Book").find(Integer.parseInt(cols.get("book_id")));
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getAlternative() {
        return alternative;
    }

    public void setAlternative(String alternative) {
        this.alternative = alternative;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}
