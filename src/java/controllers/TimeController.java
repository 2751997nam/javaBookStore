/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nguye
 */
public class TimeController {

    private static final int SECOND = 1000;
    private static final int MINUTE = 60 * SECOND;
    private static final int HOUR = 60 * MINUTE;
    private static final int DAY = 24 * HOUR;

    public static String showTime(String time) {
        try {
            SimpleDateFormat dt = new SimpleDateFormat("yyyyy-mm-dd hh:mm:ss");
            Date date = dt.parse(time);
            Date now = new Date();
            long sub = now.getTime() - date.getTime();
            if (sub < MINUTE) {
                return "moments ago";
            } else if (sub < 2 * MINUTE) {
                return "a minute ago";
            } else if (sub < 60 * MINUTE) {
                return sub / MINUTE + " minutes ago";
            } else if (sub < 2 * HOUR) {
                return "an hour ago";
            } else if (sub < 24 * HOUR) {
                return sub / HOUR + " hours ago";
            } else if (sub < 48 * HOUR) {
                return "yesterday";
            } else {
                return sub / DAY + " days ago";
            }
        } catch (ParseException ex) {
            return time;
        }
    }
}
