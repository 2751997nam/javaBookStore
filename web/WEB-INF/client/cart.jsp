<%-- 
    Document   : cart
    Created on : Nov 3, 2018, 12:28:10 PM
    Author     : nguye
--%>
<%@page import="models.Profile"%>
<%@page import="config.Database"%>
<%@page import="java.util.List"%>
<%@page import="models.Book"%>
<%@page import="config.Lang"%>
<%@ page import="models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../language.jsp" %>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <title>My Cart</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="style/client_reset.css">       
        <link rel="stylesheet" type="text/css" href="style/client_style.css">
        <link rel="stylesheet" type="text/css" href="style/client_index.css">
        <link rel="stylesheet" type="text/css" href="style/client_sub.css">
        <link rel="stylesheet" type="text/css" href="style/modal.css">
        <link rel="stylesheet" type="text/css" href="style/client_account.css">
    </head>
    <body>
        <%
            List<Book> books = (List) request.getAttribute("books");
            long total = 0;
            User user = (User) request.getAttribute("user");
            Profile profile = (Profile) request.getAttribute("profile");
        %>
        <div class="container">
            <!-- HEADER -->
            <%@include file="layout/header.jsp" %>
            <!--body-->
            <div class="wrapper-color">
                <div class="bread-crumb">
                    <a href="#">Home</a>
                    <span>❯ <%= Lang.getKey(language, "My Cart")%></span>
                </div>
                <div class="body">
                    <div class="row">
                        <div class="cart-title">
                            <h5 class="cart-header"><%= Lang.getKey(language, "My Cart")%> <span>( <%= books.size()%> <%= Lang.getKey(language, "items")%> )</span></h5>
                        </div>
                    </div>
                    <div class="row" >
                        <% if (!books.isEmpty()) { %>
                        <div class="col-left" id="purchase-left">
                            <% for (Book book : books) {%>
                            <% total += book.getPrice() * book.getQuantity();%>
                            <div class="shopping-cart-item">
                                <div class="thumnail">
                                    <img src="<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>">
                                </div>
                                <div class="info-item">
                                    <div class="box-info-product">
                                        <a href="/bookstore/detail/<%= book.getId()%>"><p class="name"><%= book.getName()%></p></a>
                                        <p class="note"> - <%= Lang.getKey(language, "Author")%>: <a href="" target=""><%= book.getAuthor()%></a></p>
                                    </div>
                                    <div class="box-price">
                                        <p class="price"><%= book.showPrice()%> ₫</p>
                                    </div>
                                    <div class="quantity">
                                        <div class="button-group">
                                            <form action="/bookstore/add-cart" method="post" id="<%= book.getId()%>">
                                                <input type="hidden" value="change" name="action"/>
                                                <input type="hidden" value="<%= book.getId()%>" name="book_id"/>
                                                <select class="number" name="quantity" onchange="document.getElementById('<%= book.getId()%>').submit()">
                                                    <option value="default"><%= book.getQuantity()%></option>
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
                                        <p><a href="/bookstore/cart/delete/<%= book.getId()%>" class="color-red"><%= Lang.getKey(language, "Delete")%></a></p>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"> </div>
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
                                <div class="sub-row">
                                    <button class="sent-gift" onclick="showModal()" >
                                        <%= Lang.getKey(language, "Check Out")%>
                                    </button>
                                </div>

                            </div>
                        </div>
                        <% } else {%>
                        <p class="color-red" style="width: 100%;text-align: center;"><%= Lang.getKey(language, "Your cart is empty.")%></p>
                        <% }%>
                        <div class="clear"> </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>

            <!-- FOOTER -->
            <%@include file="layout/footer.jsp" %>
            <!-- HẾT FOOTER -->
        </div>
        <!--modal-->
        <div id="myModal" class="modal">
            <div class="modal-content">
                <div class="model-head">
                    <span class="close" onClick="hideModal()">&times;</span>
                    <p><%= Lang.getKey(language, "Confirm Information")%></p>
                </div>
                <div class="modal-body">
                    <form method="post" action="/bookstore/order">
                        <input type="hidden" name="email" value="<%= user.getEmail()%>">
                        <div class="form-c">
                            <lable class="lb"><%= Lang.getKey(language, "Name")%> <span class="color-red">(*)</span></lable>
                            <input class="ai" type="text" name="name" value="<%= user.getName()%>" required disabled placeholder=""/>
                        </div>
                        <div class="form-c">
                            <lable class="lb"><%= Lang.getKey(language, "Address")%> <span class="color-red">(*)</span></lable>
                            <input class="ai" type="text" name="address" value="<%= profile.getAddress()%>" required  placeholder=""/>
                        </div>
                        <div class="form-c">
                            <lable class="lb"><%= Lang.getKey(language, "Phone")%> <span class="color-red">(*)</span></lable>
                            <input class="ai" type="text" name="phone" value="<%= profile.getPhone()%>" required />
                        </div>
                        <div class="form-c">
                            <lable class="lb"><%= Lang.getKey(language, "Note")%></lable>
                            <textarea class="ai" rows="5" name="note"></textarea>
                        </div>
                        <div class="btn-bot">
                            <button class="btnc" type="submit"><%= Lang.getKey(language, "Confirm")%></button>
                            <a class="btnc" onclick="hideModal()"><%= Lang.getKey(language, "Cancel")%></a>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">

                </div>
            </div>
        </div>
        <script type="text/javascript">
            function showModal() {
                document.getElementById("myModal").style.display = "block";
            }
            function hideModal() {
                document.getElementById("myModal").style.display = "none";
            }
        </script>
    </body>
</html>