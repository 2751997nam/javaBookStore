/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.migrations.migrations;

import models.migrations.Migration;
import models.migrations.Table;

/**
 *
 * @author ASUS
 */
public class CreateRatesTable extends Migration{
    public void up() {
        if(this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        Table tb = new Table("rates");
        tb.addID();
        tb.integer("star");
        tb.text("comment");
        tb.integer("user_id");
        tb.integer("book_id");
        tb.addForeign("user_id", "users");
        tb.addForeign("book_id", "books");
        tb.createWithTimestamps();
    }
    
    public void down() {
        if(!this.exists()) {
            return;
        }
        Table tb = new Table("rates");
        tb.drop();
        this.removeMigration(this.getClass().getName());
    }
}
