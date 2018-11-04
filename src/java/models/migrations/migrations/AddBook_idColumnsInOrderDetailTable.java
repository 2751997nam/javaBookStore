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
public class AddBook_idColumnsInOrderDetailTable extends Migration {

    @Override
    public void up() {
        if (this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());

        Table tb = new Table("order_details");
        tb.alter();
        tb.addColumn().string("book_id");
        tb.dropUnique("name");
        tb.addColumn().unique("name_id", "name,id");
        tb.execute();
    }

    @Override
    public void down() {
        if (!this.exists()) {
            return;
        }

        Table tb = new Table("order_details");
        tb.alter();
        tb.dropColumn("book_id");
        tb.dropUnique("name_id");
        tb.addColumn().unique("name");
        tb.execute();

        this.removeMigration(this.getClass().getName());
    }
}
