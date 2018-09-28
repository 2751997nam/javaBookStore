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
public class CreateOrderDetailsTable extends Migration{
    public void up() {
        if(this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        Table tb = new Table("order_details");
        tb.addID();
        tb.string("name");
        tb.bigInteger("price");
        tb.integer("quantity");
        tb.unique("name");
        tb.integer("order_id");
        tb.addForeign("order_id", "orders");
        tb.createWithTimestamps();
    }
    
    public void down() {
        if(!this.exists()) {
            return;
        }
        Table tb = new Table("order_details");
        tb.drop();
        this.removeMigration(this.getClass().getName());
    }
}
