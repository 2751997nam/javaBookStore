/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import config.Database;
import java.util.HashMap;
import models.database.DB;

/**
 *
 * @author ASUS
 */
public class Image extends Model{
    protected String link;
    protected Book book;

    public Image(HashMap<String, String> cols) {
        super(cols);
        this.link = cols.get("link");
        this.book = new Book();
        this.book.setId(Integer.parseInt(cols.get("book_id")));
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public Book getBook() {
        if(this.book.getName().length() <= 0) {
            this.book = (Book) new DB("books", "Book").find(this.book.getId());
        }
        
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
    
    public String link() {
        return new Database().get("img_path") + this.link;
    }
}
