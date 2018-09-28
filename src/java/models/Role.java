/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.HashMap;

/**
 *
 * @author ASUS
 */
public class Role extends Model{
    protected String name;

    public Role() {
        this.name = "";
    }

    public Role(HashMap<String, String> cols) {
        super(cols);
        this.name = cols.get("name");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
