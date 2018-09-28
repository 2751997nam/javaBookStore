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
public class CreateImagesTable extends Migration {
    public void up() {
        if(this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        Table tb = new Table("images");
        tb.addID();
        tb.string("link");
        tb.string("alternative");
        tb.integer("book_id");
        tb.addForeign("book_id", "books", "id");
        tb.createWithTimestamps();
    }
    
    public void down() {
        if(!this.exists()) {
            return;
        }
        Table tb = new Table("images");
        tb.drop();
        this.removeMigration(this.getClass().getName());
    }
}
