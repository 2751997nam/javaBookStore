<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@page import="config.Database"%>
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
        <title><%= Lang.getKey(language, "Categories Manager")%></title>
        <link rel="stylesheet" href="../style/books.css">
        <link rel="stylesheet" href="../style/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head>
    <body>
        <%@include file="../header.jsp" %>
        <div class="content">
            <%@include file="../sidebar.jsp" %>
            <% ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");%>
            <div class="content-right-data">
                <a href="categories/add" role="button" class="btn btn-success"><%= Lang.getKey(language, "Add New Category")%></a>
                <table class="table-data">
                    <tr>
                        <th class="col-min-1"><%= Lang.getKey(language, "Num.")%></th>
                        <th class="col-min-4"><%= Lang.getKey(language, "Name")%></th>
                        <th class="col-min-2"><%= Lang.getKey(language, "Created")%></th>
                        <th class="col-min-2"><%= Lang.getKey(language, "Updated")%></th>
                        <th></th>
                    </tr>
                    <tbody>
                        <% int num = Integer.parseInt(request.getAttribute("perpage").toString()) * (Integer.parseInt(request.getAttribute("current").toString()) - 1); %>
                        <% for (Category cate : categories) {%>
                        <tr>  
                            <td><%= num++%></td>
                            <td><%= cate.getName()%></td>
                            <td><%= cate.getCreated_at()%></td>
                            <td><%= cate.getUpdated_at()%></td>
                            <td>
                                <a role="button" class="btn btn-primary" href="categories/edit?id=<%= cate.getId()%>"><%= Lang.getKey(language, "Edit")%></a>
                                <a role="button" class="btn btn-danger" 
                                   href="javascript:setId(
                                   <%= cate.getId()%>, 
                                   '<%= Lang.getKey(language, "Do you want to delete this book?")%>'
                                   )">
                                    <%= Lang.getKey(language, "Delete")%>
                            </td>
                        </tr>
                        <% }
                        %>
                    </tbody>
                </table>
                <div class="paginate">
                    <%@include  file="/WEB-INF/paginate.jsp"%>
                </div>
                <form action="categories/delete" method="POST" id="delete_item">
                    <input type="hidden" name="id" value="" id="item_id">
                </form>
            </div>
        </div>
        <script src="/bookstore/js/admin/menu.js"></script>
        <script src="/bookstore/js/admin/book.js"></script>        
    </body>
</html>