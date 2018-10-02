<%@page import="config.Lang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="language.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>Login</title>
    </head>
    <body>
        <%@include file="langForm.jsp" %>
        <% if(session.getAttribute("message") != null) {%>
        <p style="color: red"><%= session.getAttribute("message") %></p>
        <% } %>
        <form action="login" method="POST">
            <div>
            <label for="email"><%= Lang.getKey(language, "Email")%></label>
            <input type="text" name="email" placeholder="<%= Lang.getKey(language, "Input your email here")%>">
            </div>
            <div>
            <label for="password"><%= Lang.getKey(language, "Password")%></label>
            <input type="password" name="password" placeholder="<%= Lang.getKey(language, "Input your password here")%>">
            </div>
            <div>
                <input type="checkbox" name="remember">
                <label>Remember me</label>
            </div>
            <input type="submit" value="<%= Lang.getKey(language, "Submit") %>">
        </form>
    </body>
</html>
