<%@page import="config.Lang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title><%= Lang.getKey(language, "Login")%></title>
        <link rel="stylesheet" href="style/login-admin.css"/>
    </head>
    <body>
        <div class="loginBox">
            <%@include file="langForm.jsp" %>
            <img src="images/logoSach.png" alt="Logo">
            <div style="overflow: auto">
                <% if (session.getAttribute("message") != null) {%>
                <p style="color: red"><%= session.getAttribute("message")%></p>
                <% }%>
            </div>
            <form action="" method="POST">
                <div>
                    <label for="email"><%= Lang.getKey(language, "Email")%></label>
                    <input type="text" name="email" required placeholder="<%= Lang.getKey(language, "Input your email here")%>">
                </div>
                <div>
                    <label for="password"><%= Lang.getKey(language, "Password")%></label>
                    <input type="password" name="password" required placeholder="<%= Lang.getKey(language, "Input your password here")%>">
                </div>
                <div>
                    <input type="checkbox" name="remember">
                    <label><%= Lang.getKey(language, "Remember me")%></label>
                </div>
                <input type="submit" value="<%= Lang.getKey(language, "Submit")%>">
            </form>
        </div>
    </body>
</html>
