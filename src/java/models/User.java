package models;

import config.Database;
import models.database.DB;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

public class User extends Model {

    protected String name;
    protected String email;
    protected String password;
    protected String remember_token;
    protected int role_id;

    public User() {
        super();
        this.name = "";
        this.email = "";
        this.password = "";
        this.remember_token = "";
        this.role_id = 0;
    }

    public User(HashMap<String, String> cols) {
        super(cols);
        this.name = cols.get("name");
        this.email = cols.get("email");
        this.password = cols.get("password");
        this.remember_token = cols.get("remember_token");
        this.role_id = Integer.parseInt(cols.get("role_id"));
    }

    public User(String email, String password) {
        super();
        this.email = email;
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRemember_token() {
        return remember_token;
    }

    public void setRemember_token(String remember_token) {
        this.remember_token = remember_token;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public static boolean checkAuth(String email, String password) {
        return new DB("users")
                .where("email", "=", email)
                .where("password", "=", password)
                .checkQuery();
    }
    
    public static boolean checkAuth(String remember) {
        return new DB("users")
                    .where("remember_token", "=", remember)
                    .checkQuery();
    }
    
    public static boolean checkExist(String email) {
        return new DB("users")
                    .where("email", "=", email)
                    .checkQuery();
    }
    
    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }
    
    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + ", password=" + password + "]";
    }

    public List getAllUser(HttpServletRequest request) {
        return new DB("users", "User")
                .orderBy("name")
                .paginate(request,
                        Integer.parseInt(new Database().get("paginate"))
                ).get();       
    }
    
    public Role role() {
        return (Role) this.hasOne("roles", "Role");
    }
}
