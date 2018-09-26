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
public class CreateProductUserPivotTable extends Migration{
    public void up() {
        if(this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        Table tb = new Table("product_user");
        tb.addID();
        tb.integer("product_id");
        tb.integer("user_id");
        tb.integer("quantity");
        tb.addForeign("user_id", "users", "id");
        tb.addForeign("product_id", "products", "id");
        tb.createWithTimestamps();
    }
    
    public void down() {
        Table table = new Table("product_user");
        if (!this.exists()) {
            return;
        }
        table.drop();
        this.removeMigration(this.getClass().getName());
    }
}
