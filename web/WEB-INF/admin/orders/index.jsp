<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
        <title><%= Lang.getKey(language, "Orders Manager")%></title>
        <link rel="stylesheet" href="../style/books.css">
        <link rel="stylesheet" href="../style/style.css">
        <link href="../style/font-awsome.css" rel="stylesheet" />
    </head>
    <body>
        <%@include file="../header.jsp" %>
        <div class="content">
            <%@include file="../sidebar.jsp" %>
            <%  ArrayList<HashMap<String, String>> orders = (ArrayList<HashMap<String, String>>) request.getAttribute("orders");%>
            <div class="content-right-data">
                <table class="table-data">
                    <tr>
                        <th class="col-min-1"><%= Lang.getKey(language, "Num.")%></th>
                        <th class="col-min-3"><%= Lang.getKey(language, "Name")%></th>
                        <th class="col-min-5"><%= Lang.getKey(language, "Address")%></th>
                        <th class="col-min-3"><%= Lang.getKey(language, "Phone")%></th>
                        <th class="col-min-4"><%= Lang.getKey(language, "Created")%></th>
                        <th class="col-min-5"></th>
                    </tr>
                    <tbody>
                        <% int num = Integer.parseInt(request.getAttribute("perpage").toString()) * (Integer.parseInt(request.getAttribute("current").toString()) - 1); %>
                        <% for (HashMap<String, String> order : orders) {%>
                        <tr>  
                            <td><%= num++%></td>
                            <td><%= order.get("name")%></td>
                            <td><%= order.get("address")%></td>
                            <td><%= order.get("phone")%></td>
                            <td><%= order.get("created_at")%></td>
                            <td>
                                <a role="button" href="javascript:void(0)" onclick="showPreview(<%= order.get("id")%>, this)" class="btn btn-primary"><%= Lang.getKey(language, "Preview")%></a>
                                <a role="button" class="btn btn-success"><%= Lang.getKey(language, "Accept")%></a>
                                <a role="button" class="btn btn-danger" 
                                   href="javascript:setId(
                                   <%= order.get("id")%>, 
                                   '<%= Lang.getKey(language, "Do you want to delete this orders?")%>'
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
        <script src="/bookstore/js/app.js"></script>
        <script src="/bookstore/js/admin/menu.js"></script> 
        <script src="/bookstore/js/admin/orders.js"></script>  
    </body>
</html>