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
        <title>Book Shop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="style/client_reset.css">       
        <link rel="stylesheet" type="text/css" href="style/client_style.css">
        <link rel="stylesheet" type="text/css" href="style/client_index.css">
    </head>
    <body>
        <%
            List<Book> top_sell = (List) request.getAttribute("top_sell");
            List<Book> new_books = (List) request.getAttribute("new_books");
            List<Book> recommend_books = (List) request.getAttribute("recommend_books");
        %>
        <div class="container">
            <!-- HEADER -->
            <%@include file="layout/header.jsp" %>
            <!-- BODY -->
            <div class="wrapper-color">
                <div class="body">
                    <!-- PRODUCT : BODY -->
                    <div class="slider-nav">
                        <div class="row">
                            <div class="col-3 sn-left">
                                <div class="nav">
                                    <div class="nav-item">
                                        <a href="/bookstore/search?q=&filter=Sach+Kinh+Doanh" title="">
                                            <img src="images/book.png" alt="" class="nav-icon">
                                            <img src="images/books-hover.png" alt="" class="nav-icon-hide">
                                            <span><%= Lang.getKey(language, "Business & Investing")%></span>
                                            <span class="forward">❯</span>
                                        </a>
                                        <a href="/bookstore/search?q=&filter=Sach+Giao+Khoa" title="">
                                            <img src="images/book.png" alt="" class="nav-icon">
                                            <img src="images/books-hover.png" alt="" class="nav-icon-hide">
                                            <span><%= Lang.getKey(language, "Education & Textbooks")%></span>
                                            <span class="forward">❯</span>
                                        </a>												
                                        <a href="/bookstore/search?q=&filter=Sach+Thieu+Nhi" title="">
                                            <img src="images/book.png" alt="" class="nav-icon">
                                            <img src="images/books-hover.png" alt="" class="nav-icon-hide">
                                            <span><%= Lang.getKey(language, "Kids")%></span>
                                            <span class="forward">❯</span>
                                        </a>
                                        <a href="/bookstore/search?q=&filter=Sach+Tinh+Cam" title="">
                                            <img src="images/book.png" alt="" class="nav-icon">
                                            <img src="images/books-hover.png" alt="" class="nav-icon-hide">
                                            <span><%= Lang.getKey(language, "Romance")%></span>
                                            <span class="forward">❯</span>
                                        </a>
                                        <a href="/bookstore/search?q=&filter=Sach+Van+Hoc+%26+Vien+Tuong" title="">
                                            <img src="images/book.png" alt="" class="nav-icon">
                                            <img src="images/books-hover.png" alt="" class="nav-icon-hide">
                                            <span><%= Lang.getKey(language, "Literature & Fiction")%></span>
                                            <span class="forward">❯</span>
                                        </a>
                                        <a href="/bookstore/search?q=&filter=Truyen+Tranh" title="">
                                            <img src="images/book.png" alt="" class="nav-icon">
                                            <img src="images/books-hover.png" alt="" class="nav-icon-hide">
                                            <span><%= Lang.getKey(language, "Comics")%></span>
                                            <span class="forward">❯</span>
                                        </a>
                                        <a href="/bookstore/search?q=&filter=Sach+Khoa+Hoc" title="">
                                            <img src="images/book.png" alt="" class="nav-icon">
                                            <img src="images/books-hover.png" alt="" class="nav-icon-hide">
                                            <span><%= Lang.getKey(language, "Science Fiction")%></span>
                                            <span class="forward">❯</span>
                                        </a>
                                        <a href="/bookstore/search?q=&filter=Thanh+Thieu+Nien" title="">
                                            <img src="images/book.png" alt="" class="nav-icon">
                                            <img src="images/books-hover.png" alt="" class="nav-icon-hide">
                                            <span><%= Lang.getKey(language, "Teens & Young")%></span>
                                            <span class="forward">❯</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-9 sn-right">
                                <div class="slider">
                                    <div class="prev" onClick="plusSlide(-1)"><p>❮</p></div> 
                                    <div class="slide-item">
                                        <img src="images/slide1.png" alt="">
                                    </div>
                                    <div class="slide-item">
                                        <img src="images/slide2.jpg" alt="">
                                    </div>
                                    <div class="slide-item">
                                        <img src="images/slide3.png" alt="">
                                    </div>
                                     <div class="next" onClick="plusSlide(1)"><p>❯</button></p> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="products">
                        <!-- HÀNG 1 -->
                        <div class="main_row">
                            <div class="header">
                                <div class="line"><hr width="100%" align="content"></div>
                                <div class="title"><p><%= Lang.getKey(language, "TOP SELL")%></p></div>
                                <div class="line"><hr width="100%" align="content"></div>
                            </div>
                            <div class="list-item row">
                                <% for (Book book : top_sell) {%>
                                <div class="col-20">
                                    <a href="/bookstore/detail/<%= book.getId()%>" >
                                        <div class="items">
                                            <div class="item-img">
                                                <img src="<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>" alt="item" />
                                            </div>
                                            <div class="item-text">
                                                <p class="item-name"><%= book.getName()%></p>
                                                <p class="item-author"><%= book.getAuthor()%></p>
                                                <p class="item-price"><%= book.showPrice()%> ₫</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <%}%>
                                <div class="see-more">
                                    <a href="/bookstore/search?q=&filter=top+sell"><%= Lang.getKey(language, "see more")%></a>
                                </div>
                            </div>
                        </div>
                        <!-- HẾT HÀNG 1 -->
                        <!-- HÀNG 2 -->
                        <div class="main_row">
                            <div class="list-item row">
                                <div class="header">
                                    <div class="title">
                                        <div>
                                            <img src="images/update.png" >
                                        </div>
                                        <div>
                                            <p><%= Lang.getKey(language, "NEW UPDATE")%></p>
                                            <span><%= Lang.getKey(language, "Update every hour new books on our Website")%></span>
                                        </div>
                                    </div>
                                </div>
                                <% for (Book book : new_books) {%>
                                <div class="col-20">
                                    <a href="/bookstore/detail/<%= book.getId()%>" >
                                        <div class="items">
                                            <img src="<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>" alt="item" />
                                            <div class="item-text">
                                                <p class="item-name"><%= book.getName()%></p>
                                                <p class="item-author"><%= book.getAuthor()%></p>
                                                <p class="item-price"><%= book.showPrice()%> ₫</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <%}%>
                                <div class="see-more">
                                    <a href="/bookstore/search?q=&filter=new+update"><%= Lang.getKey(language, "see more")%></a>
                                </div>
                            </div>
                        </div>
                        <!-- HẾT HÀNG 2 -->
                        <!-- PROMINENT : BODY -->
                        <div class="prominent">
                            <a href="#">
                                <div class="my_prom" style="background-image: url(images/nature-grass-leaf-green.jpg);">
                                    <p class="prom_title"></p>
                                </div>
                            </a>

                            <a href="#">
                                <div class="my_prom" style="background-image: url(images/prominent02.jpeg);">
                                    <p class="prom_title"></p>
                                </div>
                            </a>

                            <a href="#">
                                <div class="my_prom" style="background-image: url(images/prominent03.jpeg);">
                                    <p class="prom_title"></p>
                                </div>
                            </a>
                        </div>
                        <div class="main_row">
                            <div class="row recommend">
                                <div class="header">
                                    <div class="title">
                                        <div>
                                            <img src="images/quality.png" >
                                        </div>
                                        <div>
                                            <p><%= Lang.getKey(language, "RECOMMEND")%></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-9 row list-item">
                                    <% for (int i = 0; i < 4; i++) {%>
                                    <div class="col-3 items">
                                        <a href="/bookstore/detail/<%= recommend_books.get(i).getId()%>" >
                                            <img src="<%= recommend_books.get(i).images().size() > 0 ? recommend_books.get(i).images().get(0).link() : new Database().get("thumbnail")%>" alt="item" />
                                            <div class="item-text">
                                                <p class="item-name"><%= recommend_books.get(i).getName()%></p>
                                                <p class="item-author"><%= recommend_books.get(i).getAuthor()%></p>
                                                <p class="item-price"><%= recommend_books.get(i).showPrice()%> ₫</p>
                                            </div>
                                        </a>
                                    </div>
                                    <% }%>
                                </div>
                                <div class="col-3">
                                    <div class="item-left">
                                        <% for (int i = 4; i < 7; i++) {%>
                                        <a href="/bookstore/detail/<%= recommend_books.get(i).getId()%>" >
                                            <div class="items">
                                                <div class="item-img">
                                                    <img src="<%= recommend_books.get(i).images().size() > 0 ? recommend_books.get(i).images().get(0).link() : new Database().get("thumbnail")%>" alt="item" />
                                                </div>
                                                <div class="item-text">
                                                    <p class="item-name"><%= recommend_books.get(i).getName()%></p>
                                                    <p class="item-author"><%= recommend_books.get(i).getAuthor()%></p>
                                                    <p class="item-price"><%= recommend_books.get(i).showPrice()%> ₫</p>
                                                </div>
                                            </div>
                                        </a>                                        
                                        <% }%>
                                        <div class="see-more">
                                            <a href="/bookstore/search?q=&filter=recommend"><%= Lang.getKey(language, "see more")%></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- HẾT HÀNG 3 -->
                    </div>
                    <div class="clear"></div>
                    <!-- HẾT CONTAINER -->
                    <!-- SOCIAL -->
                    <div class="social">
                        <a href="#" class="fb"></a>
                        <a href="#" class="t"></a>
                        <a href="#" class="d"></a>
                        <a href="#" class="g"></a>
                    </div>
                    <!-- HẾT SOCIAL-->
                </div>   
                <!-- HẾT BODY -->
            </div>
            <!-- FOOTER -->
            <%@include file="layout/footer.jsp" %>
            <!-- HẾT FOOTER -->
        </div>
        <script src="js/slider.js" type="text/javascript"></script>			
    </body>
</html>