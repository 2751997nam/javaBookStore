<%@page import="config.Lang"%>
<%@ page import="models.User"%>
<%@page import="models.Product"%>
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
            
        <% ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products"); %>
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
                <% for (Product product : products) {%>
                <tr>
                    <td><%= product.getId()%></td>
                    <td><%= product.getName()%></td>
                    <td><%= product.getPrice()%></td>
                    <td><%= product.getDescription()%></td>
                    <td><%= product.getCreated_at()%></td>
                    <td><%= product.getUpdated_at()%></td>
                </tr>
                <%}%>
            </tbody>
        </table>

        <div class="paginate">
            <%@include  file="paginate.jsp"%>
        </div>
        
    </body>
</html>