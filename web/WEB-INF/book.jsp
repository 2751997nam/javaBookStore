<%@page import="models.Book"%>
<%@page import="config.Lang"%>
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
            
        <% ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("books"); %>
        <table>
            <thead>
                <tr>
                    <th><%= Lang.getKey(language, "ID") %></th>
                    <th><%= Lang.getKey(language, "Product Name") %></th>
                    <th><%= Lang.getKey(language, "Price") %></th>
                    <th><%= Lang.getKey(language, "Description") %></th>
                    <th><%= Lang.getKey(language, "Created") %></th>
                    <th><%= Lang.getKey(language, "Updated") %></th>
                </tr>
            </thead>
            <tbody>
                <% for (Book book : books) {%>
                <tr>
                    <td><%= book.getId()%></td>
                    <td><%= book.getName()%></td>
                    <td><%= book.showPrice()%></td>
                    <td><%= book.getDescription()%></td>
                    <td><%= book.getCreated_at()%></td>
                    <td><%= book.getUpdated_at()%></td>
                </tr>
                <%}%>
            </tbody>
        </table>

        <div class="paginate">
            <%@include  file="paginate.jsp"%>
        </div>
        
    </body>
</html>