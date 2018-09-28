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
public class CreateCategoriesTable extends Migration{
    public void up() {
        if(this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        Table tb = new Table("categories");
        tb.addID();
        tb.string("name");
        tb.createWithTimestamps();
    }
    
    public void down() {
        if(!this.exists()) {
            return;
        }
        Table tb = new Table("categories");
        tb.drop();
        this.removeMigration(this.getClass().getName());
    }
}
