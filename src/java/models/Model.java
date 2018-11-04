package models;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.database.DB;

public class Model extends Object{

    protected int id;
    protected String created_at;
    protected String updated_at;

    public Model() {
        this.id = 0;
        this.created_at = null;
        this.updated_at = null;
    }

    public Model(int id, String created_at, String updated_at) {
        this.id = id;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Model(HashMap<String, String> cols) {
        this.id = Integer.parseInt(cols.get("id"));
        this.created_at = cols.get("created_at");
        this.updated_at = cols.get("updated_at");
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(String updated_at) {
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getColumnId(String model) {
        return model.toLowerCase().charAt(0) + model.substring(1) + "_id";
    }

    public Object hasOne(String table, String model) {
        try {
            Field field = this.getClass().getDeclaredField(getColumnId(model));
            field.setAccessible(true);
            int column = (int) field.get(this);
            return new DB(table, model)
                    .whereNotString(
                        "id",
                        "=",
                        "" + column
                    ).get()
                    .get(0);
        } catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
        }

        return new Model();
    }

    public List hasMany(String table, String model) {
        return new DB(table, model).whereNotString(getColumnId(this.getClass().getSimpleName()), "=", "" + this.id).get();
    }
    
    public List belongsToMany(String table, String model, String pivot, String id, String key) {
        return new DB(table, model)
            .join(pivot, table + ".id", key)
            .select(table + ".*, " + pivot + "." + key + ", " + pivot + "." + id)
            .whereNotString(pivot + "." + id, "=",  "" + this.getId())
            .whereNotString(table + ".id", "=", pivot + "." + key)
            .get();
    }
    
    public Object belongsTo(String table, String model, int id) {
        return new DB(table, model).find(id);
    }
}
