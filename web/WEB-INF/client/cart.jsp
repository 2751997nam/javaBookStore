<%-- 
    Document   : cart
    Created on : Nov 3, 2018, 12:28:10 PM
    Author     : nguye
--%>
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
    </head>
    <body>
        <%
            List<Book> books = (List) request.getAttribute("books");
            long total = 0;
        %>
        <div class="container">
            <!-- HEADER -->
            <div class="head">
                <div class="head-top">
                    <div class="row">
                        <div class="col-4">
                            <span><%= Lang.getKey(language, "Language")%></span>
                            <%@include file="../langForm.jsp" %>
                        </div>
                        <div class="col-4">
                            <% if (session.getAttribute("email") != null) {%>
                            <div class="head-user">
                                <a href="#" title="">
                                    <img src="images/ring.png" alt="">
                                    <span><%= Lang.getKey(language, "Notifications")%></span>
                                </a>
                            </div>
                            <div class="head-user dropdown">
                                <a href="#">
                                    <img src="images/user.jpg" alt="" class="login">
                                    <span><%=session.getAttribute("email")%></span>
                                </a>
                                <div class="dropdown-content">
                                    <a href="profile" class="fa fa-user">  <%= Lang.getKey(language, "Profile")%></a>
                                    <a href="login?action=logout" class="fa fa-logout">  <%= Lang.getKey(language, "Logout")%></a>
                                </div>
                            </div>
                            <%} else {%>
                            <div class="head-user">
                                <a href="login" title="">
                                    <img src="images/login.png" alt="">
                                    <span><%= Lang.getKey(language, "Login")%></span>
                                </a>
                            </div>
                            <div class="head-user">
                                <a href="sign-up" title="">
                                    <img src="images/link.png" alt="">
                                    <span><%= Lang.getKey(language, "Signup")%></span>
                                </a>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="head-bot row">
                    <div class="logo col-3">
                        <a href="/bookstore" title="">
                            <svg viewBox="-5.5 0 473.5 246"><g><path d="M437.4,57.8c8.1-4.7,13.6-13.5,13.6-23.6c0-15-12.2-27.3-27.3-27.3c-13.5,0-24.7,9.8-26.9,22.7 C412.4,35.9,426.2,45.6,437.4,57.8z"></path><path d="M275.4,57.4c11.4-12.3,25.4-22,41.2-28.1C314.2,16.6,303.1,7,289.8,7c-15,0-27.3,12.2-27.3,27.3 C262.5,44,267.6,52.6,275.4,57.4z"></path><path d="M459,115.7c-8.6-48.9-51.3-86.1-102.7-86.1c-51.4,0-94.1,37.2-102.7,86.1c-1,5.9-1.6,12-1.6,18.2c0,0.2,0,0.5,0,0.7 c21.1,2.8,39.4,14.3,51.3,30.7l20.3-38.3c2.4-4.5,3.6-8.2,3.6-11c0-0.1,0-0.2,0-0.3c-0.1-3.9-1.3-5.9-3.8-5.9c-2,0-3.2,2-3.7,5.9 c-0.2,1.5-0.3,3.4-0.3,5.5h-20.7V120c0-1.5,0-2.9,0.1-4.3c0.5-10.5,2.6-18.9,6.6-25.1C309.8,83.5,316,80,324,80 c7.2,0,13.1,3.1,17.7,9.2c4.9,6.5,7.4,15.3,7.4,26.4l0,0c0,10.4-3.5,20.2-10.5,29.5l-5.2,6.9H349v27h-37.7 c4.1,9.3,6.4,19.7,6.4,30.5c0,7-1,13.7-2.7,20.1c12.7,5.5,26.7,8.5,41.4,8.5c57.6,0,104.3-46.7,104.3-104.3C460.6,127.7,460.1,121.6,459,115.7z M411.3,159.1h-6.7v19.5h-21.2v-19.5h-26.6v-25.6l7.9-17.8l15.5-35.1h24.4v35.1v17.8h6.7V159.1 L411.3,159.1z"></path><path d="M381.2,121.8l-5,12.1h8.8v-13.3c0-1.8,0-3.5,0.1-4.9c0.1-2.6,0.2-4.6,0.4-6c-0.4,1.7-1.1,3.8-1.9,6 C382.9,117.5,382.1,119.6,381.2,121.8z"></path></g><polygon points="107.1,209.8 92.5,144.4 107.4,79.1 85,79.1 81.7,94.2 78.1,79.1 55.7,79.1 55.7,79.7 70.2,144.5 55.7,208 55.7,210 78.2,210 81.7,195.3 85.3,210 107.7,210 107.7,209.9 "></polygon><path d="M154.4,79.1H128l-14.3,131h55.4L154.4,79.1z M141.3,193.8c-4.9,0-8.9-7.4-8.9-16.5s4-16.5,8.9-16.5c4.9,0,8.9,7.4,8.9,16.5 S146.2,193.8,141.3,193.8z"></path><path d="M231.8,79.2h-52.9V210h17.8v-96.4c0-2.4,1.9-4.3,4.3-4.3c2.4,0,4.3,1.9,4.3,4.3V210h17.4v-96.4c0-2.4,1.9-4.3,4.3-4.3 s4.3,1.9,4.3,4.3V210h17.9V103.2C249.2,89.9,241.4,79.2,231.8,79.2z"></path><path d="M28.4,111.1h22.2V79.1h-44v131h44v-31.4H28.4c-3.2,0-5.8-4-5.8-8.9s2.6-8.9,5.8-8.9h22.2V129H28.4c-3.2,0-5.8-4-5.8-8.9 S25.2,111.1,28.4,111.1z"></path></svg>
                        </a>
                    </div>
                    <div class="col-9 row">
                        <div class="col-10 search">
                            <div class="form-search">
                                <form action="search" method="get">
                                    <input type="text" name="q" placeholder="<%= Lang.getKey(language, "Search books, categories")%>">
                                    <button type="submit"><img src="images/search.png" alt=""></button>
                                </form>
                            </div>
                        </div>
                        <div class="cart-icon col-2">
                            <a href="/bookstore/cart" title="">
                                <img src="images/shopping-cart.png" alt="">
                                <% if (session.getAttribute("book_cart") != null) {%>
                                <div class="noti"><%= session.getAttribute("book_cart")%></div>
                                <%}%>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
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
                            <% total += book.getPrice()*book.getQuantity();%>
                            <div class="shopping-cart-item">
                                <div class="thumnail">
                                    <img src="<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>">
                                </div>
                                <div class="info-item">
                                    <div class="box-info-product">
                                        <p class="name"><%= book.getName()%></p>
                                        <p class="note"> - <%= Lang.getKey(language, "Author")%>: <a href="" target=""><%= book.getAuthor()%></a></p>
                                    </div>
                                    <div class="box-price">
                                        <p class="price"><%= book.showPrice()%> ₫</p>
                                        <!--                                        <p class="price2">119.000&nbsp;₫</p>
                                                                                <p class="sale">-40%</p>-->
                                    </div>
                                    <div class="quantity">
                                        <div class="button-group">
                                            <p><%= Lang.getKey(language, "Quantity")%></p>
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
                                        <small>(Đã bao gồm VAT)</small>
                                    </p>
                                </div>
                                <button class="checkout">
                                    Tiến hành đặt hàng
                                </button>
                                <button class="sent-gift">
                                    Gửi quà tặng
                                </button>
                            </div>
                        </div>
                        <% } else {%>
                        <p class="color-red" style="width: 100%;text-align: center;">Giỏ hàng còn trống</p>
                        <% }%>
                        <div class="clear"> </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>

            <!-- FOOTER -->
            <div class="footer">
                <div class="wrapper">
                    <div class="f_cols">
                        <h3>Location</h3>
                        <p>Học viện Công nghệ Bưu chính Viễn thông - Nguyễn Trãi - Hà Đông - Hà Nội <span class="phone"> 01662228469 </span></p>
                        <a class="map" href="https://www.google.com/maps/place/H%E1%BB%8Dc+Vi%E1%BB%87n+C%C3%B4ng+ngh%E1%BB%87+B%C6%B0u+Ch%C3%ADnh+Vi%E1%BB%85n+Th%C3%B4ng/@20.9833077,105.7909336,15z/data=!4m5!3m4!1s0x3135accdcf7b0bd1:0xc1cf5dd00247628a!8m2!3d20.9813256!4d105.7874823">see it in the map <span class="arrow">&nbsp;&rarr;</span></a>
                    </div>

                    <div class="f_cols">
                        <h3>Company</h3>
                        <ul>
                            <li><a href="#">Our Story</a></li>
                            <li><a href="#">Mission</a></li>
                            <li><a href="#">Journal</a></li>
                            <li><a href="#">Careers</a></li>
                        </ul>
                    </div>
                    <div class="f_cols">
                        <h3>Support</h3>
                        <ul>
                            <li><a href="#">FAQ</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">Policies</a></li>

                        </ul>
                    </div>
                    <div class="f_cols">
                        <h3>Minima</h3>
                        <p>Sách là kho tri thức của nhân loại. Việc đọc sách mỗi ngày sẽ giúp bạn phát triển vượt bậc</p>
                        <p>Template made by Team 09</p>
                    </div>
                </div>
            </div>
            <!-- HẾT FOOTER -->
        </div>
    </body>
</html>