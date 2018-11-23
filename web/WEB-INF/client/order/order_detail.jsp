<%@page import="models.OrderDetail"%>
<%@page import="models.Profile"%>
<%@page import="config.Database"%>
<%@page import="java.util.List"%>
<%@page import="models.Book"%>
<%@page import="config.Lang"%>
<%@ page import="models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <title>Detail Order</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="../style/client_reset.css">       
        <link rel="stylesheet" type="text/css" href="../style/client_style.css">
        <link rel="stylesheet" type="text/css" href="../style/client_index.css">
        <link rel="stylesheet" type="text/css" href="../style/client_sub.css">
        <link rel="stylesheet" type="text/css" href="../style/modal.css">
        <link rel="stylesheet" type="text/css" href="../style/client_account.css">
    </head>
    <body>
        <%
            List<OrderDetail> items = (List) request.getAttribute("items");
            long total = 0;
//            Profile profile = (Profile) request.getAttribute("profile");
           %>
        <div class="container">
            <!-- HEADER -->
            <%@include file="../layout/header.jsp" %>
            <!--body-->
            <div class="wrapper-color">
                <div class="bread-crumb">
                    <a href="#">Home</a>
                    <span>❯ <%= Lang.getKey(language, "Orders")%></span>
                </div>
                <div class="body">
                    <div class="row">
                        <div class="cart-title">
                            <h5 class="cart-header"><%= Lang.getKey(language, "Order detail")%> <span>( <%= items.size()%> <%= Lang.getKey(language, "items")%> )</span></h5>
                        </div>
                    </div>
                    <div class="row" >
                        <% if (!items.isEmpty()) {%>
                        <div class="col-left" id="purchase-left">
                            <div class="shopping-cart-item">
                                <div class="info-item full-width">
                                    <div class="box-info-product bold"><%= Lang.getKey(language, "Book Name")%></div>
                                    <div class="box-price">
                                        <p class="price text-center "><%= Lang.getKey(language, "Price")%></p>
                                    </div>
                                    <% if (request.getAttribute("action") != "view") {%>
                                    <div class="box-price">
                                        <p class="price text-center"><%= Lang.getKey(language, "Action")%></p>
                                    </div>
                                    <%} else {%>
                                    <div class="box-price">
                                        <p class="price text-center"><%= Lang.getKey(language, "Quantity")%></p>
                                    </div>
                                    <%}%>

                                </div>
                            </div>
                            <% for (OrderDetail item : items) {%>
                            <% total += item.getPrice() * item.getQuantity();%>
                            <div class="shopping-cart-item">
                                <div class="info-item full-width">
                                    <div class="box-info-product">
                                        <p class="name bold-none"><%= item.getName()%></p>
                                    </div>
                                    <div class="box-price">
                                        <p class="price color-red bold-none text-center "><%= item.showPrice()%> ₫</p>
                                    </div>
                                    <% if (request.getAttribute("action") != "view") {%>
                                    <div class="quantity text-center">
                                        <div class="button-group ">
                                            <form action="/bookstore/order_detail" method="post" id="<%= item.getId()%>">
                                                <input type="hidden" value="change" name="action"/>
                                                <input type="hidden" value="<%= item.getId()%>" name="order_detail_id"/>
                                                <select class="number" name="quantity" onchange="document.getElementById('<%= item.getId()%>').submit()">
                                                    <option value="default"><%= item.getQuantity()%></option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                    <option value="6">6</option>
                                                    <option value="7">7</option>
                                                    <option value="8">8</option>
                                                    <option value="9">9</option>
                                                    <option value="10">10</option>
                                                    <option value="11">11</option>
                                                    <option value="12">12</option>
                                                    <option value="13">13</option>
                                                    <option value="14">14</option>
                                                    <option value="15">15</option>
                                                    <option value="16">16</option>
                                                    <option value="17">17</option>
                                                    <option value="18">18</option>
                                                    <option value="19">19</option>
                                                    <option value="20">20</option>
                                                </select>
                                            </form>
                                        </div>
                                        <p><a href="/bookstore/order/item/delete/<%= item.getId()%>" class="color-red"><%= Lang.getKey(language, "Delete")%></a></p>
                                    </div>
                                    <%} else {%>
                                    <div class="box-price">
                                        <p class="price bold-none text-center "><%= item.getQuantity()%></p>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                            <% }%>
                        </div>
                        <div class="col-right" id="purchase-right">
                            <div class="row">
                                <div class="sub-row">
                                    <span class="text-label"><%= Lang.getKey(language, "Cash")%>: </span>
                                    <div class="amount">
                                        <p><strong><%= String.format("%,d", total)%>&nbsp;₫ </strong></p>
                                    </div>
                                    <p></p>
                                </div>

                                <div class="sub-row">
                                    <span class="text-label"><%= Lang.getKey(language, "Merchandise Subtotal")%>: </span>
                                    <div class="amount">
                                        <p><strong class="color-red"><%= String.format("%,d", total + total * 10 / 100)%>&nbsp;₫ </strong></p>
                                    </div>
                                    <p class="text-right">
                                        <small>(<%= Lang.getKey(language, "Included VAT")%>)</small>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <% } else {%>
                        <p class="color-red" style="width: 100%;text-align: center;"><%= Lang.getKey(language, "Your order is empty.")%></p>
                        <% }%>
                        <div class="clear"> </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>

            <!-- FOOTER -->
            <%@include file="../layout/footer.jsp" %>
            <!-- HẾT FOOTER -->
        </div>
    </body>
</html>