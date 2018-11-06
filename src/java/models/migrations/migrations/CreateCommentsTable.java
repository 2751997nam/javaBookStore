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
 * @author nguye
 */
public class CreateCommentsTable extends Migration{
        public void up() {
        if(this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        Table tb = new Table("comments");
        tb.addID();
        tb.text("content");
        tb.integer("user_id");
        tb.integer("book_id");
        tb.addForeign("user_id", "users", "id");
        tb.addForeign("book_id", "books", "id");
        tb.createWithTimestamps();
    }
    
    public void down() {
        if(!this.exists()) {
            return;
        }
        Table tb = new Table("orders");
        tb.drop();
        this.removeMigration(this.getClass().getName());
    }
}
