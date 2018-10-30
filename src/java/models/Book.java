/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import config.Database;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import models.database.DB;

/**
 *
 * @author ASUS
 */
public class Book extends Model{
    protected String name;
    protected long price;
    protected String description;
    protected String publisher;
    protected String author;
    protected int quantity;
    protected List images;

    public Book() {
        super();
        this.name = "";
        this.price = 0;
        this.description = "";
        this.publisher = "";
        this.author = "";
        this.quantity = 0;
    }

    public Book(HashMap<String, String> cols) {
        super(cols);
        this.name = cols.get("name");
        this.price = Long.parseLong(cols.get("price"));
        this.description = cols.get("description");
        this.publisher = cols.get("publisher");
        this.author = cols.get("author");
        this.quantity = Integer.parseInt(cols.get("quantity"));
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
    
    public List getAllBook(HttpServletRequest request) {
        return new DB("books", "Book")
                .orderBy("updated_at DESC")
                .paginate(request,
                        Integer.parseInt(new Database().get("paginate"))
                ).get();           
    }
    
    public String showPrice(){
        return String.format("%,d", this.getPrice());
    }
    
    public List<Image> images() {
        if (this.images == null) {
            this.images = this.hasMany("images", "Image");
        }
        
        return this.images;
    }
    
    public List<Category> categories()
    {
        return this.belongsToMany("categories", "Category", "book_category", "book_id", "category_id");
    }
    public List<Book> topSell() {
        return new DB("books", "Book")
                .orderBy("updated_at DESC").limit(5).get();
    }
}
