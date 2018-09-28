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
                    <th><%= Lang.getKey(language, "Num.") %></th>
                    <th><%= Lang.getKey(language, "Fullname") %></th>
                    <th>Email</th>
                    <th>Role ID</th>
                    <th><%= Lang.getKey(language, "Created") %></th>
                    <th><%= Lang.getKey(language, "Updated") %></th>
                </tr>
            </thead>
            <tbody>
                <% int num = Integer.parseInt(request.getAttribute("perpage").toString()) * (Integer.parseInt(request.getAttribute("current").toString()) - 1); %>
                <% for (User user : users) {%>
                <tr>
                    <td><%= ++num %></td>
                    <td><%= user.getName()%></td>
                    <td><%= user.getEmail()%></td>
                    <td><%= user.getRole_id() %></td>
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