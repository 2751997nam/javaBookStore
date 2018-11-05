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
            <%@include file="layout/header.jsp" %>
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
            <%@include file="layout/footer.jsp" %>
            <!-- HẾT FOOTER -->
        </div>
        <script src="js/slider.js" type="text/javascript"></script>			
    </body>
</html>