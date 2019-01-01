<%@page import="java.util.Calendar"%>
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
        <title><%= Lang.getKey(language, "Users Manager")%></title>
        <link rel="stylesheet" href="../style/books.css">
        <link rel="stylesheet" href="../style/dashboard.css">
        <link rel="stylesheet" href="../style/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="content">
            <%@include file="sidebar.jsp" %>
            <div class="content-right-data">
                <h3 class="text-center text-danger"><%= Lang.getKey(language, "Revenue Each Month In Year: ")%><%= Calendar.getInstance().get(Calendar.YEAR) %></h3>
                <table>
                    <tbody>
                        <tr style="height: 500px">
                            <% ArrayList<HashMap<String, String>> revenues
                                        = (ArrayList<HashMap<String, String>>) request.getAttribute("revenues");
                                int size = revenues.size();
                                long total = 0;
                                long first = 0;
                                if(size > 0) {
                                    total = Long.parseLong(revenues.get(size - 1).get("revenue"));
                                    first = Integer.parseInt(revenues.get(0).get("month"));
                                }
                            %>
                            
                            <% for (int i = 1; i < first; i++) {%>
                                <td></td>
                            <% } %>
                            
                            <% for (int i = 0; i < size - 2; i++) {%>
                                <% long revenue = Long.parseLong(revenues.get(i).get("revenue"));
                                    long height = (revenue * 100 / total) * 5;
                                %>
                                <td valign="bottom" style="text-align: center;">
                                    <div>
                                        <div><%= String.format("%,d", revenue) %></div>
                                        <div style="height: <%= height%>px;" class="column">
                                        </div>
                                    </div>
                                </td>
                            <% } %>
                        </tr>
                        <tr>
                            <% for (int i = 1; i <= 12; i++) {%>
                            <th class="col-min-2"><%= i%></th>
                            <% } %>
                        </tr>
                    </tbody>
                </table>
                <div class="total">
                    <label><strong><%= Lang.getKey(language, "Total") %></strong></label> 
                    <span><strong><%= String.format("%,d", total) %></strong></span>
                </div>
            </div>
        </div>
        <script src="/bookstore/js/admin/menu.js"></script>
        <script src="/bookstore/js/admin/book.js"></script>        
    </body>
</html>
