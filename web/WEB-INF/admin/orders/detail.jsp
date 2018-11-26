<%@page import="models.OrderDetail"%>
<%@page import="models.Order"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="config.Database"%>
<%@page import="config.Lang"%>
<%@ page import="models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/language.jsp" %>

<td colspan="6">
    <% Order order = (Order) request.getAttribute("order"); %>
    <% ArrayList<OrderDetail> details = (ArrayList<OrderDetail>) request.getAttribute("details");%>
    <table class="table-none-border">
        <tr>
            <td>
            <th class="col-min-2"><%= Lang.getKey(language, "Address")%></th>
            <td class="col-min-10"><%= order.getAddress()%></td>
            </td>
            <td>
            <th class="col-min-2 text-danger"><%= Lang.getKey(language, "Total")%></th>
            <td class="col-min-2 text-danger"><%= details.get(0).showPrice(Long.parseLong(request.getAttribute("total").toString()))%></td>
            </td>
        </tr>
    </table>
    <table class="table">
        <thead>
            <tr>
                <th class="col-min-1"><%= Lang.getKey(language, "Num.")%></th>
                <th class="col-min-3"><%= Lang.getKey(language, "Order Id")%></th>
                <th class="col-min-3"><%= Lang.getKey(language, "Name")%></th>
                <th class="col-min-3"><%= Lang.getKey(language, "Thumbnail")%></th>
                <th class="col-min-5"><%= Lang.getKey(language, "Price")%></th>
                <th class="col-min-3"><%= Lang.getKey(language, "Quantity")%></th>
                <th class="col-min-3 text-danger"><%= Lang.getKey(language, "Amount")%></th>
            </tr>
        </thead>
        <tbody>
            <% int num = 1; %>
            <% for (OrderDetail detail : details) {%>
            <tr>
                <td><%= num++%></td>
                <td><%= detail.getOrder_id()%></td>
                <td><%= detail.getName()%></td>
                <% String link = detail.book().images().size() > 0 ? detail.book().images().get(0).link() : new Database().get("thumbnail");%>
                <td>
                    <img class="thumbnail preview" src="<%= link%>">
                </td>
                <td><%= detail.showPrice()%></td>
                <td><%= detail.getQuantity()%></td>
                <td class="text-danger"><%= detail.showPrice(detail.getPrice() * detail.getQuantity())%></td>
            </tr>
            <% }%>
        </tbody>
    </table>
</td>        
