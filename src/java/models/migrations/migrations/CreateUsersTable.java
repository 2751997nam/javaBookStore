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
public class CreateUsersTable extends Migration {

    public void up() {
        if (this.exists()) { // neu da co trong bang migrations thi se ko chay nua
            return;
        }
        this.addMigration(this.getClass().getName()); // add ten file nay vao trong bang migrations
        Table table = new Table("users"); 
        table.addID(); // thêm id
        table.string("name");
        table.string("email");
        table.string("password");
        table.string("remember_token", 100);
        table.createWithTimestamps(); // thêm 2 cột created_at và updated_at đồng thời tạo bảng users trong db
    }

    public void down() {
        if (!this.exists()) { // neu khong co trong bang migrations thi se ko chay nua
            return;
        }
        Table table = new Table("users"); // gọi đến bảng users
        table.drop(); // xóa bảng user
        this.removeMigration(this.getClass().getName()); // xoa ten file nay trong bảng migration
    }
}
