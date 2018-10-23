/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import config.Database;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import models.RandomString;
import models.User;
import models.database.DB;

/**
 *
 * @author ASUS
 */
public class Controller extends HttpServlet {

    public static final String SAVE_DIRECTORY = "images";

    public void auth(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        String remember = "";
        if(cookies == null) {
            return;
        }
        
        for (Cookie cookie : cookies) {
            if (cookie.getName().compareTo("bookstore.remember") == 0) {
                remember = cookie.getValue();
                break;
            }
        }

        if (remember.length() > 0) {
            if (User.checkAuth(remember)) {
                User user = (User) new DB("users", "User").where("remember_token", "=", remember).get().get(0);
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
            }
        }
    }

    public void setPaginate(HttpServletRequest request, String table) {
        int current = 1;
        if (request.getParameter("page") != null) {
            current = Integer.parseInt(request.getParameter("page"));
        }
        int limit = Integer.parseInt(new Database().get("paginate"));
        int page_number = new DB(table).getPageNumber(limit, current);

        StringBuffer current_url = request.getRequestURL();
        String[] links = new String[5];
        links[0] = current_url + "?page=1";
        links[1] = current_url + "?page=" + (current != 1 ? current - 1 : 1);
        links[2] = current_url + "?page=" + current;
        links[3] = current_url + "?page=" + (current != page_number ? current + 1 : page_number);
        links[4] = current_url + "?page=" + page_number;

        request.setAttribute("page_number", page_number);
        request.setAttribute("links", links);
        request.setAttribute("current", current);
        request.setAttribute("perpage", limit);
        request.setAttribute("url", current_url + "?page=");
    }

    public boolean validate(HttpServletRequest request, HashMap<String, String[]> map) {
        map.entrySet().forEach((entry) -> {
            String key = entry.getKey();
            String[] values = entry.getValue();
        });

        return true;
    }

    public HashMap<String, String> getOnly(HttpServletRequest request, String[] keys) {
        HashMap<String, String> map = new HashMap();
        for (String key : keys) {
            String value = request.getParameter(key);
            if (value != null) {
                map.put(key, request.getParameter(key));
            }
        }

        return map;
    }
    
    protected String getFullSavePath(HttpServletRequest request) {
                // Đường dẫn tuyệt đối tới thư mục gốc của web app.
        String appPath = request.getServletContext().getRealPath("");
        appPath = appPath.replace('\\', '/');

        // Thư mục để save file tải lên.
        String fullSavePath = null;
        if (appPath.endsWith("/")) {
            fullSavePath = appPath + SAVE_DIRECTORY;
        } else {
            fullSavePath = appPath + "/" + SAVE_DIRECTORY;
        }

        // Tạo thư mục nếu nó không tồn tại.
        File fileSaveDir = new File(fullSavePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        
        return fullSavePath;
    }

    protected String uploadFile(HttpServletRequest request) throws IOException, ServletException {
        String fullSavePath = getFullSavePath(request);
        // Danh mục các phần đã upload lên (Có thể là nhiều file).
        String filePath = "";
        for (Part part : request.getParts()) {
            String fileName = extractFileName(part);
            if (fileName != null && fileName.length() > 0) {
                filePath = fullSavePath + File.separator + fileName;
                File file = new File(filePath);
                while (file.exists()) {
                    filePath = fullSavePath + File.separator + RandomString.randomString(10) + fileName;
                    file = new File(filePath);
                }
                // Ghi vào file.
                part.write(filePath);
                filePath = fileName;
            }
        }

        return filePath;
    }

    protected String extractFileName(Part part) {
        // form-data; name="file"; filename="C:\file1.zip"
        // form-data; name="file"; filename="C:\Note\file2.zip"
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                // C:\file1.zip
                // C:\Note\file2.zip
                String clientFileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
                clientFileName = clientFileName.replace("\\", "/");
                int i = clientFileName.lastIndexOf('/');
                // file1.zip
                // file2.zip
                return clientFileName.substring(i + 1);
            }
        }

        return null;
    }
    
    protected void deleteFile(HttpServletRequest request, String path) {
        String appPath = request.getServletContext().getRealPath("");
        String fullPath = appPath + "\\" + SAVE_DIRECTORY + "\\" + path;
        System.out.println("");
        System.out.println(fullPath);
        System.out.println("");
        File file = new File(fullPath);
        file.delete();
    }
}
