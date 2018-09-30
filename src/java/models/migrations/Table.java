/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.migrations;

import config.MySql;
import java.util.List;
import models.database.DB;
import models.database.Query;

/**
 *
 * @author ASUS
 */
public class Table {
    protected Query query;

    public Table(String name) {
        this.query = new Query();
        this.query.setFrom(name);
        this.query.setColumns("(");
    }
    
    public Table alter() {
        this.query.setColumns("");
        this.query.setCommand("ALTER TABLE ");
        
        return this;
    }
    
    public Table addColumn() {
        this.query.setColumns(this.query.getColumns() + "ADD ");
        
        return this;
    }
    
    public Table modifyColumn() {
        this.query.setColumns(this.query.getColumns() + "MODIFY ");
        
        return this;        
    }
    
    public Table dropColumn(String name) {
        this.query.setColumns(this.query.getColumns() + "Drop " + name + ", ");
        
        return this;
    }
    
    public Table addNullable(String key, String value) {
        this.query.setColumns(this.query.getColumns() + key + " " + value + ", ");
        
        return this;
    }
    
    public Table addNullable(String key, String value, String type) {
        this.query.setColumns(this.query.getColumns() + key + " " + value + " " + type + ", ");
        
        return this;
    }
    
    public Table add(String key, String value, String type) {
        this.addNullable(key, value, "NOT NULL " + type);
        
        return this;
    }
    
    public Table add(String key, String value) {
        this.addNullable(key, value, "NOT NULL");
        
        return this;
    }
    
    public Table string(String key, int length) {
        this.add(key, "VARCHAR(" + length + ")");
        
        return this;
    }
    
    public Table string(String key) {
        this.add(key, "VARCHAR(191)");
        
        return this;
    }
    
    public Table text(String key) {
        this.add(key, "TEXT");
        
        return this;
    }
    
    public Table integer(String key) {
        this.add(key, "INT");
        
        return this;
    }
    
    public Table bigInteger(String key) {
        this.add(key, "BIGINT");        
        
        return this;
    }
    
    public Table decimal(String key) {
        this.add(key, "DOUBLE");
        
        return this;
    }
    
    public Table addID() {
        this.query.setColumns(this.query.getColumns() + "`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY");
        this.query.setColumns(this.query.getColumns() + ", INDEX(`id`), ");
        
        return this;
    }
    
    public Table addForeign(String column, String table, String references) {
        this.query.setColumns(this.query.getColumns() + "CONSTRAINT FK_" + this.query.getFrom() + table + " FOREIGN KEY (" + column + ")\n" +
                                                            "REFERENCES " + table + "(" + references + ")" + " ON DELETE CASCADE, " );
        
        return this;
    }
    
    public Table addForeign(String column, String table) {
        this.addForeign(column, table, "id");
        
        return this;
    }
    
    public Table addTimestamps() {
        this.add("created_at", "TIMESTAMP", "DEFAULT CURRENT_TIMESTAMP");
        this.query.setColumns(this.query.getColumns() + "updated_at" + " " + "TIMESTAMP" + " " + "DEFAULT CURRENT_TIMESTAMP");
        
        return this;
    }
    
    public Table create() {
        this.query.setCommand("CREATE TABLE");
        this.query.setColumns(this.query.getColumns() + ")");
        new DB().executeQuery(this.query.toString());
        
        return this;
    }
    
    public Table execute() {
        String sql = this.query.toString().trim();
        if(sql.charAt(sql.length() - 1) == 44) {
            sql = sql.substring(0, sql.length() - 1);
        }
        
        new DB().executeQuery(sql);
        
        return this;
    }
    
    public Table createWithTimestamps() {
        this.addTimestamps();
        this.create();
        
        return this;
    }
    
    public Table drop() {
        new DB().executeQuery("Drop Table " +  this.query.getFrom());
        
        return this;
    }
    
    public Table dropForeign(String name) {
        this.query.setColumns(this.query.getColumns() + "Drop FOREIGN KEY " + name + ", ");
        
        return this;
    }
    
    public boolean exists(String name) {
        return new DB("migrations")
                .select("*")
                .where(new String[]{"name = '" + name + "'"})
                .checkQuery();
    }
    
    public Table unique(String name) {
        this.query.setColumns(this.query.getColumns() + "CONSTRAINT UNI_" + name + " UNIQUE (" + name + "), ");
        
        return this;
    }
    
    public Table dropUnique(String name) {
        this.query.setColumns(this.query.getColumns() + "Drop INDEX UNI_" + name + ", ");
        
        return this;
    }
}
