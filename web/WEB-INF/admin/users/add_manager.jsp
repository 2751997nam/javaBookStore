<%@page import="java.util.List"%>
<%@page import="config.Database"%>
<%@page import="config.Lang"%>
<%@ page import="models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/language.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title><%= Lang.getKey(language, "Add Manager")%></title>
        <link rel="stylesheet" href="/bookstore/style/books.css">
        <link rel="stylesheet" href="/bookstore/style/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="../header.jsp" %>
        <div class="content">
            <%@include file="../sidebar.jsp" %>
            <div class="content-right-data">
                <div class="createbooks">
                    <% String message = (String) request.getAttribute("message"); %>
                    <% if (message != null && !message.equals("")) {%>
                    <span class="text-danger"><%= Lang.getKey(language, message)%></span>
                    <% }%>
                    <form action="" method="POST" class="col-5">
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Name")%><span class="text-danger">*</span></label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Email")%><span class="text-danger">*</span></label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Password")%><span class="text-danger">*</span></label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <input id="save" type="submit" value="Save">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="/bookstore/js/admin/menu.js"></script>
        <script src="/bookstore/js/admin/book.js"></script>      
    </body>
</html>
