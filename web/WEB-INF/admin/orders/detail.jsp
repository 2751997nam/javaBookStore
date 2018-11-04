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
<%@include file="/WEB-INF/language.jsp" %>

<div>
    <% Order order = (Order) request.getAttribute("order"); %>
    <% ArrayList<OrderDetail> details = (ArrayList<OrderDetail>) request.getAttribute("details");%>
    <table>
        <tbody>
        <td>
        <th><%= Lang.getKey(language, "Email:")%></th>
        <td><%= order.getNote()%></td>
        </td>
        <td>
        <th><%= Lang.getKey(language, "Total:")%></th>
        <td><%= request.getAttribute("total")%></td>
        </td>
        </tbody>
    </table>
    <table>
        <thead>
            <tr>
                <th class="col-min-1"><%= Lang.getKey(language, "Num.")%></th>
                <th class="col-min-3"><%= Lang.getKey(language, "Name")%></th>
                <th class="col-min-5"><%= Lang.getKey(language, "Price")%></th>
                <th class="col-min-3"><%= Lang.getKey(language, "Quantity")%></th>
                <th class="col-min-3"><%= Lang.getKey(language, "Order Id")%></th>
            </tr>
        </thead>
        <tbody>
            <% int num = 1; %>
            <% for (OrderDetail detail : details) {%>
            <tr>
                <td><%= num++%></td>
                <td><%= detail.getName()%></td>
                <td><%= detail.showPrice()%></td>
                <td><%= detail.getQuantity()%></td>
                <td><%= detail.getOrder_id()%></td>
            </tr>
            <% }%>
        </tbody>
    </table>
</div>