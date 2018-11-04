<%@page import="models.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="config.Lang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= Lang.getKey(language, "Add New Category")%></title>
        <link rel="stylesheet" href="/bookstore/style/books.css">
        <link rel="stylesheet" href="/bookstore/style/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head>
    <body>
        <%@include file="../header.jsp" %>
        <div class="content">
            <%@include file="../sidebar.jsp" %>
            <div id="content-right-createbooks" >
                <div><h2 id="createbooks-header"><%= Lang.getKey(language, "Add New Category")%></h2></div>
                <div class="createbooks">                
                    <form action="/bookstore/admin/categories/add" class="col-5" method="POST">
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Name")%></label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <input id="save" type="submit" value="Save">
                        </div>                       
                    </form>
                </div>
            </div>
        </div>
        <script src="/bookstore/js/admin/menu.js"></script>
    </body>
</html>
