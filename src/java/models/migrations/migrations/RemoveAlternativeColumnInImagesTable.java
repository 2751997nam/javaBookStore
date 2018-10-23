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
public class RemoveAlternativeColumnInImagesTable extends Migration {

    public void up() {
        if (this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        
        Table table = new Table("images");
        table.alter();
        table.dropColumn("alternative");
        table.execute();
    }

    public void down() {
        if (!this.exists()) {
            return;
        }
        Table table = new Table("images");
        table.alter();
        table.addColumn().string("alternative");
        table.execute();
        this.removeMigration(this.getClass().getName());
    }
}
