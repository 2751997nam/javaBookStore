/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.HashMap;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class Category extends Model {

    protected String name;

    public Category() {
        this.name = "";
    }

    public Category(HashMap<String, String> cols) {
        super(cols);
        this.name = cols.get("name");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public List<Book> books()
    {
        return this.belongsToMany("books", "Book", "book_category", "category_id", "book_id");
    }
    @Override
    public String toString() {
        return "Category{ " + id + " " + name + " " + created_at + " " + updated_at + " }";
    }

    @Override
    public boolean equals(Object category) {
        Category cate = (Category) category;
        return this.id == cate.getId() && 
                this.name.compareTo(cate.getName()) == 0 &&
                this.getUpdated_at().compareTo(cate.getUpdated_at()) == 0 &&
                this.getCreated_at().compareTo(cate.getCreated_at()) == 0;
    }
}
