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
        <title><%= Lang.getKey(language, "Users Manager")%></title>
        <link rel="stylesheet" href="../style/books.css">
        <link rel="stylesheet" href="../style/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="../header.jsp" %>
        <div class="content">
            <%@include file="../sidebar.jsp" %>
            <div class="content-right-data">
                <div>
                    <table class="table-data">
                        <thead>
                            <tr>
                                <th class="col-min-1"><%= Lang.getKey(language, "Num.")%></th>
                                <th class="col-min-6"><%= Lang.getKey(language, "Name")%></th>
                                <th class="col-min-4"><%= Lang.getKey(language, "Email")%></th>
                                <th class="col-min-4"></th>                                                      
                            </tr>
                        </thead>
                        <tbody>
                            <% int num = Integer.parseInt(request.getAttribute("perpage").toString())
                                        * (Integer.parseInt(request.getAttribute("current").toString()) - 1); %>
                            <% ArrayList<User> users = (ArrayList<User>) request.getAttribute("users"); %>
                            <% for (User customer : users) {%>
                            <tr>
                                <td><%= num++%></td>
                                <td><%= customer.getName()%></td>
                                <td><%= customer.getEmail()%></td>
                                <td>
                                    <% if (!customer.blocked()) {%>
                                    <a role="button" class="btn btn-danger" 
                                       href="javascript:setId(
                                       <%= customer.getId()%>, 
                                       '<%= Lang.getKey(language, "Do you want to block this user?")%>'
                                       )">
                                        <%= Lang.getKey(language, "Block")%>
                                    </a>
                                    <% } else {%>
                                    <a role="button" class="btn btn-success" 
                                       href="javascript:setId(
                                       <%= customer.getId()%>, 
                                       '<%= Lang.getKey(language, "Do you want to unblock this user?")%>'
                                       )">
                                        <%= Lang.getKey(language, "Unblock")%>
                                    </a>
                                    <% } %>
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
                    <form action="" method="POST" id="delete_item">
                        <input type="hidden" name="id" value="" id="item_id">
                    </form>
                </div>
            </div>
        </div>
        <script src="/bookstore/js/admin/menu.js"></script>
        <script src="/bookstore/js/admin/book.js"></script>        
    </body>
</html>