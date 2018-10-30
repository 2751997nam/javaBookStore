<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@page import="config.Database"%>
<%@page import="models.Book"%>
<%@page import="config.Lang"%>
<%@ page import="models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title><%= Lang.getKey(language, "Books Manager")%></title>
        <link rel="stylesheet" href="../style/books.css">
        <link rel="stylesheet" href="../style/style.css">
        <link href="../style/font-awsome.css" rel="stylesheet" />
    </head>
    <body>
        <%@include file="../header.jsp" %>
        <div class="content">
            <%@include file="../sidebar.jsp" %>

            <% ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("books");%>

            <div class="content-right-data">
                <div class="book-content">
                    <a href="books/add" role="button" class="btn btn-success"><%= Lang.getKey(language, "Add New Book")%></a>
                    <table class="table-data">
                        <thead>
                            <tr>
                                <th class="col-min-1"><%= Lang.getKey(language, "ID")%></th>
                                <th class="col-min-6"><%= Lang.getKey(language, "Product Name")%></th>
                                <th class="col-min-4"><%= Lang.getKey(language, "Thumbnail")%></th>
                                <th class="col-min-3"><%= Lang.getKey(language, "Price")%></th>
                                <th class="col-min-4"><%= Lang.getKey(language, "Categories")%></th>
                                <th class="col-min-3"><%= Lang.getKey(language, "Quantity")%></th>
                                <th class="col-min-4"><%= Lang.getKey(language, "Author")%></th>
                                <th class="col-min-6"><%= Lang.getKey(language, "Description")%></th>
                                <th class="col-min-4"><%= Lang.getKey(language, "Publisher")%></th>
                                <th class="col-min-4"></th>                                                      
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <% int num = Integer.parseInt(request.getAttribute("perpage").toString()) * (Integer.parseInt(request.getAttribute("current").toString()) - 1); %>
                                <% for (Book book : books) {%>
                            <tr>
                                <td><%= ++num%></td>
                                <td><%= book.getName()%></td>
                                <td>
                                    <img class="thumbnail" src="<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>">
                                </td>
                                <td><%= book.showPrice()%></td>
                                <% List<Category> categories = book.categories(); %>
                                <td>
                                    <% for (Category cate : categories) {%>
                                    <a href="javascript:void(0)"><%= cate.getName()%></a>
                                    <% }%>
                                </td>
                                <td><%= book.getQuantity()%></td>
                                <td><%= book.getAuthor()%></td>
                                <td><%= book.getDescription()%></td>
                                <td><%= book.getPublisher()%></td>
                                <td>
                                    <a role="button" class="btn btn-primary" href="books/edit?id=<%= book.getId()%>"><%= Lang.getKey(language, "Edit")%></a>
                                    <a role="button" class="btn btn-danger" 
                                       href="javascript:setId(
                                       <%= book.getId()%>, 
                                       '<%= Lang.getKey(language, "Do you want to delete this book?")%>'
                                       )">
                                        <%= Lang.getKey(language, "Delete")%>
                                    </a>
                                </td>
                            </tr>
                            <% }
                            %>
                            </tr>
                        </tbody>
                    </table>
                    <div class="paginate">
                        <%@include  file="/WEB-INF/paginate.jsp"%>
                    </div>
                    <form action="books/delete" method="POST" id="delete_item">
                        <input type="hidden" name="id" value="" id="item_id">
                    </form>
                </div>
            </div>
        </div>
        <script src="/bookstore/js/admin/menu.js"></script>
        <script src="/bookstore/js/admin/book.js"></script>        
    </body>
</html>