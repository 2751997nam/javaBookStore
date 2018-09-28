package models;

import java.util.HashMap;

public class Model {
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
}
