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
        <title>Search</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="style/client_reset.css">       
        <link rel="stylesheet" type="text/css" href="style/client_style.css">
        <link rel="stylesheet" type="text/css" href="style/client_index.css">
        <link rel="stylesheet" type="text/css" href="style/client_category.css">
    </head>
    <body>
        <%
            List<Book> books = (List) request.getAttribute("books");
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
                                    <input type="text" name="q" placeholder="<%= Lang.getKey(language, "Search books, categories")%>" value="<%= request.getAttribute("key")%>">
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
            <!-- BODY -->
            <div class="wrapper-color">
                <div class="bread-crumb">
                    <a href="#">Home</a>
                    <span>❯ search</span>
                </div>
                <div class="container" id="product-content">
                    <div class="col-md-3">
                        <div class="sidebar-wrapper">
                            <div class="sb-top">
                                <div class="sb-logo">
                                    <img src="images/bookshelf.png">
                                </div>
                            </div>
                            <div class="sb-body">
                                <div class="filter" >
                                    <p>Bộ Lọc</p>

                                </div>
                                <form action="/bookstore/search" method="get" id="filter">
                                    <input type="hidden" name="q" value="<%= request.getAttribute("key")%>">
                                    <ul class="sb-list">
                                        <li class="sb-items">
                                            <input type="radio" name="filter" value="Sach Kinh Doanh" <%= "Sach Kinh Doanh".equals(request.getAttribute("filter")) ? "checked": "" %> onchange="document.getElementById('filter').submit()"><a class="sb-items-link"><%= Lang.getKey(language, "Business & Investing")%></a><br>
                                        </li>
                                        <li class="sb-items">
                                            <input type="radio" name="filter" value="Sach Giao Khoa" <%= "Sach Giao Khoa".equals(request.getAttribute("filter")) ? "checked": "" %> onchange="document.getElementById('filter').submit()"><a class="sb-items-link" href=""><%= Lang.getKey(language, "Education & Textbooks")%></a><br>
                                        </li>
                                        <li class="sb-items">
                                            <input type="radio" name="filter" value="Sach Thieu Nhi" <%= "Sach Thieu Nhi".equals(request.getAttribute("filter")) ? "checked": "" %> onchange="document.getElementById('filter').submit()"><a class="sb-items-link" href=""><%= Lang.getKey(language, "Kids")%></a><br>
                                        </li>
                                        <li class="sb-items">                 
                                            <input type="radio" name="filter" value="Sach Tinh Cam" <%= "Sach Tinh Cam".equals(request.getAttribute("filter")) ? "checked": "" %> onchange="document.getElementById('filter').submit()"><a class="sb-items-link" href=""><%= Lang.getKey(language, "Romance")%></a><br>
                                        </li>
                                        <li class="sb-items">           
                                            <input type="radio" name="filter" value="Sach Van Hoc & Vien Tuong" <%= "Sach Van Hoc & Vien Tuong".equals(request.getAttribute("filter")) ? "checked": "" %> onchange="document.getElementById('filter').submit()"><a class="sb-items-link" href=""><%= Lang.getKey(language, "Literature & Fiction")%></a><br>
                                        </li>
                                        <li class="sb-items">              
                                            <input type="radio" name="filter" value="Truyen Tranh" <%= "Truyen Tranh".equals(request.getAttribute("filter")) ? "checked": "" %> onchange="document.getElementById('filter').submit()"><a class="sb-items-link" href=""><%= Lang.getKey(language, "Comics")%></a><br>
                                        </li>
                                        <li class="sb-items">         
                                            <input type="radio" name="filter" value="Sach Khoa Hoc" <%= "Sach Khoa Hoc".equals(request.getAttribute("filter")) ? "checked": "" %> onchange="document.getElementById('filter').submit()"><a class="sb-items-link" href=""><%= Lang.getKey(language, "Science Fiction")%></a><br>
                                        </li>
                                        <li class="sb-items">
                                            <input type="radio" name="filter" value="Thanh Thieu Nien" <%= "Thanh Thieu Nien".equals(request.getAttribute("filter")) ? "checked": "" %> onchange="document.getElementById('filter').submit()"><a class="sb-items-link" href=""><%= Lang.getKey(language, "Teens & Young")%></a><br>
                                        </li>
                                    </ul>
                                </form>
                            </div>
                            <div class="sb-bottom">
                                <div class="sb-social">
                                    <nav class="social-list">
                                        <a class="fab fa-twitter" href=""></a>
                                        <a class="fab fa-facebook" href=""></a>
                                        <a class="fab fa-instagram" href=""></a>
                                        <a class="fab fa-youtube" href=""></a>
                                        <a class="fab fa-google-drive" href=""></a>
                                    </nav>
                                </div>

                                <div class="map">
                                    <div id="googleMap"><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d931.3275217963208!2d105.78725665106833!3d20.980203646042824!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135acce762c2bb9%3A0xbb64e14683ccd786!2zSOG7jWMgdmnhu4duIEPDtG5nIG5naOG7hyBCxrB1IGNow61uaCBWaeG7hW4gdGjDtG5nIC0gUFRJVA!5e0!3m2!1svi!2s!4v1541120645410" frameborder="0" style="border:0" allowfullscreen></iframe>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="product-wrapper">
                            <div class="category_title">
                                <% if (request.getAttribute("filter") == null) {%>
                                <p><img src="images/creative.png" /><span><%= Lang.getKey(language, "Search results for the keyword")%> '<span class="color-red"><%= request.getAttribute("key")%></span>'</span></p>
                                    <%} else {%>
                                <p><img src="images/creative.png" /><span><%= Lang.getKey(language, "Search results for the keyword")%> '<span class="color-red"><%= request.getAttribute("filter")%></span>'</span></p>

                                <% } %>    
                            </div>
                            <div class="row">
                                <% if (!books.isEmpty()) {%>
                                <% for (Book book : books) {%>
                                <div class="col-product">
                                    <div class="product-item">
                                        <a href="/bookstore/detail/<%= book.getId()%>">
                                            <span class="img-item">
                                                <img src="<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>" style="display: inline;">
                                            </span>
                                            <span class="title"><%= book.getName()%></span>
                                            <p class="author"><%= book.getAuthor()%></p>
                                            <p class="price-sale"><%= book.showPrice()%> ₫
                                                <span class="price-regular">99.000 ₫</span>
                                                <span class="sale-tag">-30%</span>
                                            </p>
                                        </a>
                                    </div>
                                </div>
                                <%}%>
                                <%} else {%>
                                <p class="not-found"><img src="images/not-found.png"/><span class="color-red"><%= Lang.getKey(language, "The product you are looking for is not available.")%></span></p>
                                    <%}%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- FOOTER -->
            <div class="footer">
                <div class="wrapper">
                    <div class="f_cols">
                        <h3>Location</h3>
                        <p>Học viện Công nghệ Bưu chính Viễn thông - Nguyễn Trãi - Hà Đông - Hà Nội <span class="phone">Phone: 19008197 </span></p>
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
        <script src="js/slider.js" type="text/javascript"></script>			
    </body>
</html>