/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package config;

/**
 *
 * @author ASUS
 */
public class Lang extends Config{
    public Lang(String language) {
        this.setPath("..\\lang\\" + language + ".json");
    }
    public static String getKey(String language, String key) {
        Lang lang = new Lang(language);
        String value = lang.get(key);
        if(value != null && !value.isEmpty()) {
            return value;
        }
        
        return key;
    }    
}
