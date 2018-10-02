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
public class ChangeNullFieldOnSomeTables extends Migration{
    public void up() {
        if(this.exists()) {
            return;
        }
        this.addMigration(this.getClass().getName());
        
        Table tb = new Table("rates");
        tb.alter();
        tb.modifyColumn().addNullable("comment", "TEXT");
        tb.execute();
        
        tb = new Table("orders");
        tb.alter();
        tb.modifyColumn().addNullable("note", "TEXt");
        tb.execute();
   
    }
    
    public void down() {
        if(!this.exists()) {
            return;
        }
                
        Table tb = new Table("rates");
        tb.alter();
        tb.modifyColumn().add("comment", "TEXT");
        tb.execute();
        
        tb = new Table("orders");
        tb.alter();
        tb.modifyColumn().add("note", "TEXt");
        tb.execute();        
        
        this.removeMigration(this.getClass().getName());
    }
}
