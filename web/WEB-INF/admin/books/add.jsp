<%@page import="models.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="config.Lang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= Lang.getKey(language, "Add New Book")%></title>
        <link rel="stylesheet" href="/bookstore/style/books.css">
        <link rel="stylesheet" href="/bookstore/style/style.css">
    </head>
    <body>
        <%@include file="../header.jsp" %>
        <div class="content">
            <%@include file="../sidebar.jsp" %>
            <div id="content-right-createbooks" >
                <div><h2 id="createbooks-header"><%= Lang.getKey(language, "Add New Book")%></h2></div>
                <div class="createbooks">                
                    <form action="/bookstore/admin/books/add" class="col-5" method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Book Name")%></label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Thumbnail")%></label>
                            <input type="file" class="form-control" name="image" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Category")%></label> 
                            <select class="form-control multiple" name="categories" multiple required>
                                <% ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");%>
                                <% for (Category cate : categories) {%>
                                <option value="<%= cate.getId()%>"><%= cate.getName()%></option>
                                <% }%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Author")%></label>
                            <input type="text" name="author" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Description")%></label>
                            <textarea class="form-text" name="description" rows="10" required></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Publisher")%></label>
                            <input type="text" name="publisher" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Price")%></label>
                            <input type="number" name="price" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Quantity")%></label>
                            <input type="number" name="quantity" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <button id="back">Back</button>
                            <input id="save" type="submit" value="Save">
                        </div>                       
                    </form>
                </div>
            </div>
        </div>
        <script src="/bookstore/js/admin/menu.js"></script>
    </body>
</html>
