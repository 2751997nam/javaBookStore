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
public class OrderDetail extends Model {

    protected String name;
    protected long price;
    protected int quantity;
    protected int order_id;
    protected int book_id;
    protected Book book;

    public OrderDetail(HashMap<String, String> cols) {
        super(cols);
        this.name = cols.get("name");
        this.price = Long.parseLong(cols.get("price"));
        this.quantity = Integer.parseInt(cols.get("quantity"));
        this.order_id = Integer.parseInt(cols.get("order_id"));
        this.book_id = Integer.parseInt(cols.get("book_id"));
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public Book book() {
        if (this.book != null) {
            return this.book;
        }

        return this.book = (Book) this.belongsTo("books", "Book", this.book_id);
    }

    public String showPrice() {
        return String.format("%,d", this.getPrice());
    }
}
