<%@page import="config.Database"%>
<%@page import="models.Book"%>
<%@page import="models.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="config.Lang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language %>">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= Lang.getKey(language, "Edit Book")%></title>
        <link rel="stylesheet" href="/bookstore/style/books.css">
        <link rel="stylesheet" href="/bookstore/style/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head>
    <body>
        <%@include file="../header.jsp" %>
        <div class="content">
            <%@include file="../sidebar.jsp" %>
            <div id="content-right-createbooks" >
                <div><h2 id="createbooks-header"><%= Lang.getKey(language, "Edit Book")%></h2></div>
                    <% Book book = (Book) request.getAttribute("book");%>
                <div class="createbooks">                
                    <form action="/bookstore/admin/books/edit" class="col-5" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="<%= book.getId()%>">
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Book Name")%></label>
                            <input type="text" name="name" value="<%= book.getName()%>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"></label>
                            <img class="thumbnail" id="thumbnail" src="<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>">
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Thumbnail")%></label>
                            <input type="file" onchange="readURL(this)" class="form-control" name="image">
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Category")%></label> 
                            <select class="form-control multiple" name="categories" multiple required>
                                <% ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");%>
                                <% ArrayList<Category> bookCates = (ArrayList<Category>) request.getAttribute("bookCates");%>
                                <% for (Category cate : categories) {%>
                                <option value="<%= cate.getId()%>" <%= bookCates.contains(cate) ? "selected = \"true\"" : ""%> ><%= cate.getName()%></option>
                                <% }%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Author")%></label>
                            <input type="text" name="author" value="<%= book.getAuthor()%>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Description")%></label>
                            <textarea class="form-text" name="description" rows="10" required><%= book.getDescription()%></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Publisher")%></label>
                            <input type="text" name="publisher" value="<%= book.getPublisher()%>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Price")%></label>
                            <input type="number" name="price" class="form-control" required value="<%= book.getPrice()%>"/>
                        </div>
                        <div class="form-group">
                            <label class="form-label"><%= Lang.getKey(language, "Quantity")%></label>
                            <input type="number" name="quantity" value="<%= book.getQuantity()%>" class="form-control" required>
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
        <script src="/bookstore/js/upload.js"></script>
    </body>
</html>
