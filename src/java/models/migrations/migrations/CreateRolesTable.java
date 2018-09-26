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
public class CreateRolesTable extends Migration {

    public void up() {
        if (this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());

        Table tb = new Table("roles");
        tb.addID();
        tb.add("name", "VARCHAR(191)");
        tb.createWithTimestamps();
        
        tb = new Table("users");
        tb.alter();
        tb.addColumn().addNullable("role_id", "INT");
        tb.addColumn().addForeign("role_id", "roles", "id");
        tb.execute();
    }

    public void down() {
        if (!this.exists()) {
            return;
        }
        
        Table table = new Table("users");
        table.alter();
        table.dropForeign("FK_usersroles");
        table.dropColumn("role_id");
        table.execute();
        
        table = new Table("roles");
        table.drop();
        
        this.removeMigration(this.getClass().getName());
    }
}
