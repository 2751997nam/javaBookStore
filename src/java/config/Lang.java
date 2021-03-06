/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package config;

import java.util.Locale;
import javax.servlet.http.HttpServletRequest;

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

    public static String getKey(HttpServletRequest request, String key) {
        Locale locale = new Locale((String) request.getParameter("locale"));
        return Lang.getKey(locale.toString(), key);
    }
}
