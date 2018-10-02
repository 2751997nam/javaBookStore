<%@page import="config.Lang"%>
<%@ page import="models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>index</title>
        <link rel="stylesheet" href="style/style.css"/>
    </head>
    <body>

        <%@include file="langForm.jsp" %>

        <% if (session.getAttribute("user") == null) {%>
        <a href="login">Login</a>
        <% } else {%>
        <% User user = (User) session.getAttribute("user");%>
        <a href="javascript:void(0)"><%= user.getName()%></a>
        <form action="logout" method="Post" id="logout">
            <a href="javascript:document.querySelector('#logout').submit()" role="button">Log out</a>
        </form>
        <% } %>

        <% ArrayList<User> users = (ArrayList<User>) request.getAttribute("users");%>
        <table>
            <thead>
                <tr>
                    <th><%= Lang.getKey(language, "Num.")%></th>
                    <th><%= Lang.getKey(language, "Fullname")%></th>
                    <th>Email</th>
                    <th>Role</th>
                    <th><%= Lang.getKey(language, "Created")%></th>
                    <th><%= Lang.getKey(language, "Updated")%></th>
                </tr>
            </thead>
            <tbody>
                <% int num = Integer.parseInt(request.getAttribute("perpage").toString()) * (Integer.parseInt(request.getAttribute("current").toString()) - 1); %>
                <% for (User user : users) {%>
                <tr>
                    <td><%= ++num%></td>
                    <td><%= user.getName()%></td>
                    <td><%= user.getEmail()%></td>
                    <td><%= user.role().getName()%></td>
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