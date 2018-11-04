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
public class AddColumnsInBooksTable extends Migration{
    public void up() {
        if(this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        
        Table tb = new Table("books");
        tb.alter();
        tb.addColumn().string("publisher");
        tb.addColumn().string("author");
        tb.execute();
    }
    
    public void down() {
        if(!this.exists()) {
            return;
        }
        
        Table tb = new Table("books");
        tb.dropColumn("author");
        tb.dropColumn("publisher");
        tb.execute();
        
        this.removeMigration(this.getClass().getName());
    }
}
