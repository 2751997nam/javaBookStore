<%@page import="config.Lang"%>
<%@page import="java.util.Locale"%>
<%@ page import="models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language %>">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>index</title>
        <link rel="stylesheet" href="style/style.css"/>
    </head>
    <body>
        
        <%@include file="langForm.jsp" %>
        
        <% ArrayList<User> users = (ArrayList<User>) request.getAttribute("users"); %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th> <%= Lang.getKey("en", "Username") %></th>
                    <th>Email</th>
                    <th><%= Lang.getKey(language, "Created") %></th>
                    <th><%= Lang.getKey(language, "Updated") %></th>
                </tr>
            </thead>
            <tbody>
                <% for (User user : users) {%>
                <tr>
                    <td><%= user.getId()%></td>
                    <td><%= user.getName()%></td>
                    <td><%= user.getEmail()%></td>
                    <td><%= user.getCreated_at()%></td>
                    <td><%= user.getUpdated_at()%></td>
                </tr>
                <%}%>
            </tbody>
        </table>
            
        <div class="paginate">
            <%@include  file="paginate.jsp"%>
        </div> 
        
    </body>
</html>