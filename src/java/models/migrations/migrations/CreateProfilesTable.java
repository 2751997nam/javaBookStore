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
public class CreateProfilesTable extends Migration {

    public void up() {
        if (this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());

        Table tb = new Table("profiles");
        tb.addID();
        tb.addNullable("avatar", "VARCHAR(191)");
        tb.addNullable("address", "VARCHAR(191)");
        tb.addNullable("date_of_birth", "DATE");
        tb.addNullable("gender", "INT");
        tb.addNullable("phone", "VARCHAR(191)");
        tb.integer("user_id");
        tb.addForeign("user_id", "users", "id");
        tb.createWithTimestamps();
    }

    public void down() {
        if (!this.exists()) {
            return;
        }
        Table tb = new Table("profiles");
        tb.drop();
        this.removeMigration(this.getClass().getName());
    }
}
