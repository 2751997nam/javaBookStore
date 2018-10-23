/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package validatation;

/**
 *
 * @author ASUS
 */
public class Validation {

    public static boolean validate(String key, String value) {
        if(key.compareTo("interger") == 0) {
            return integer(value);
        }
        if(key.matches("\\:")) {
            String newkey = key.substring(0, key.indexOf("\\:"));
            int param = Integer.parseInt(key.substring(key.indexOf("\\:") + 1));
            if(newkey.compareTo("max") == 0) {
                return max(value, param);
            }
        }
        
        return true;
    }
    
    public static boolean integer(String value) {
        return value.matches("[0-9]+");
    }
    
    public static boolean max(String value, int max) {
        if(integer(value)) {
            return Integer.parseInt(value) <= max;
        } else {
            return value.length() <= max;
        }
    }
    
    public static boolean phone(String value) {
        return false;
    }
    
    public static boolean email(String value) {
        return false;
    }
}
