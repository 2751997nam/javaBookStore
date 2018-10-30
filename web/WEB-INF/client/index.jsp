<%@page import="config.Database"%>
<%@page import="java.util.List"%>
<%@page import="models.Book"%>
<%@page import="config.Lang"%>
<%@ page import="models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="language.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Shop Now Baby</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="style/client_reset.css">       
        <link rel="stylesheet" type="text/css" href="style/client_style.css">
        <!--<link rel="stylesheet" type="text/css" href="style/client_sub.css">-->
    </head>
    <body>
        <%            List<Book> top_sell = (List) request.getAttribute("top_sell");
//            List<Book> literary = (List) request.getAttribute("literary");
        %>
        <div class="container">
            <!-- HEADER -->
            <div class="header">
                <!-- HEADER TOP : HEADER -->
                <div class="header_top">
                    <div class="ht_left">
                        <div class="search">
                            <input type="text" name="name" placeholder="Search here ...">
                        </div>
                    </div>
                    <div class="logo">
                        <a href=""><img src="images/logo.jpg"></a>
                    </div>
                    <div class="ht_right">
                        <ul>
                            <% if (session.getAttribute("email") == null) {%>
                            <li><a href="login" class="fa fa-user">  Login</a></li>
                            <li><a href="sign-up" class="fa fa-user-plus"> Register</a></li>
                                <%} else {%>
                            <li style="display: flex;">
                                <div class="dropdown">
                                    <span>
                                        <a href="#">
                                            <img class="user-avatar" src="images/user.png"/>
                                            <span class="dropbtn">&nbsp;<%=session.getAttribute("email")%></span>
                                        </a>
                                    </span>
                                    <div class="dropdown-content">
                                        <a href="profile" class="fa fa-user">  Profile</a>
                                        <a href="login?action=logout" class="fa fa-logout">  Logout</a>
                                    </div>
                                </div>
                                <div class="cart">
                                    <a href="#"><img alt="cart" src="images/shopping-cart.png"/></a>
                                </div>
                            </li>
                            <%}%>
                        </ul>
                    </div>
                </div>
                <!-- SLIDESHOW : HEADER -->
                <div class="slideShow">
                    <div class="mySlides" style="background-image: url(images/slide01.jpg);">
                        <p class="slide_title"></p>
                    </div>

                    <div class="mySlides" style="background-image: url(images/billboard_img.jpg);">
                        <p class="slide_title"></p>
                    </div>

                    <div class="mySlides" style="background-image: url(images/slide01.jpg);">
                        <p class="slide_title"></p>
                    </div>

                    <div class="mySlides" style="background-image: url(images/billboard_img.jpg);">
                        <p class="slide_title"></p>
                    </div>
                </div>
                <!-- CATEGORIES : HEADER -->
                <div class="categories">
                    <ul>
                        <li><a href="categories.html">Sách Thiếu Nhi</a></li>
                        <li><a href="categories.html">Sách Giáo Khoa</a></li>
                        <li><a href="categories.html">Sách Văn Học</a></li>
                        <li><a href="categories.html">Sách Lịch Sử</a></li>
                        <li><a href="categories.html">Truyện Ngôn Tình</a></li>
                        <li><a href="categories.html">Kĩ Năng Mềm</a></li>
                    </ul>
                </div>	
            </div>
            <!-- BODY -->
            <div class="wrapper-color">
                <div class="body">
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

                    <!-- PRODUCT : BODY -->
                    <div class="products">
                        <!-- HÀNG 1 -->
                        <div class="main_row">
                            <div class="header">
                                <div class="line"><hr width="100%" align="content"></div>
                                <div class="title"><p>SÁCH BÁN CHẠY</p></div>
                                <div class="line"><hr width="100%" align="content"></div>
                            </div>
                            <div class="prod_row">
                                <% for (Book book : top_sell) {%>
                                <div class="pr_col">
                                    <a href="/bookstore/detail/<%= book.getId()%>">
                                        <div class="col_top">
                                            <div class="offer">-20%</div>
                                            <div class="image" style="background-image: url(<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>)"></div>
                                        </div>

                                        <div class="col_bottom">
                                            <div class="product_name"><%= book.getName()%></div>
                                            <div class="author"><%= book.getAuthor()%></div>
                                            <div class="price"><%= book.showPrice()%>$</div>
                                        </div>
                                    </a>
                                </div>
                                <%}%>
                            </div>
                        </div>
                        <!-- HẾT HÀNG 1 -->

                        <!-- HÀNG 2 -->
                        <div class="main_row">
                            <div class="header">
                                <div class="line"><hr width="100%" align="content"></div>
                                <div class="title"><p>BẢNG XẾP HẠNG </p></div>
                                <div class="line"><hr width="100%" align="content"></div>
                            </div>

                            <div class="prod_row">
                                <% for (Book book : top_sell) {%>
                                <div class="pr_col">
                                    <a href="/bookstore/detail/<%= book.getId()%>">
                                        <div class="col_top">
                                            <div class="offer">-20%</div>
                                            <div class="image" style="background-image: url(<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>)"></div>
                                        </div>

                                        <div class="col_bottom">
                                            <div class="product_name"><%= book.getName()%></div>
                                            <div class="author"><%= book.getAuthor()%></div>
                                            <div class="price"><%= book.showPrice()%>$</div>
                                        </div>
                                    </a>
                                </div>
                                <%}%>
                            </div>
                        </div>
                        <!-- HẾT HÀNG 2 -->

                        <!-- OTHER DETAIL -->
                        <div class="other_detail">
                            <!-- CỘT BÊN TRÁI -->
                            <div class="col_detail">
                                <div class="detail" style="background-image: url(images/goodread.jpg);"></div>
                            </div>

                            <!-- CỘT BÊN PHẢI -->
                            <div class="col_detail">
                                <div class="detail" style="background-image: url(images/goodread.jpg);"></div>
                            </div>
                        </div>

                        <!-- HÀNG 3 -->
                        <div style="display: flex;margin-top: 50px;">
                            <div class="main_col">
                                <div class="col_left">
                                    <div class="header">
                                        <div class="line"><hr width="100%" align="content"></div>
                                        <div class="title"><p>Sách Văn Học</p></div>
                                        <div class="line"><hr width="100%" align="content"></div>
                                    </div>
                                    <div class="prod_row">
                                        <!-- CỘT 1 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-20%</div>
                                                    <div class="image" style="background-image: url(images/sach1.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Xách Ba Lô Và Đi</div>
                                                    <div class="author">Huyền Chíp</div>
                                                    <div class="price">90000$</div>
                                                </div>
                                            </a>
                                        </div>

                                        <!-- CỘT 2 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-50%</div>
                                                    <div class="image" style="background-image: url(images/xx.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Đừng Đi</div>
                                                    <div class="author">Hoài Lan</div>
                                                    <div class="price">200000$</div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="prod_row">
                                        <!-- CỘT 1 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-50%</div>
                                                    <div class="image" style="background-image: url(images/xx.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Đừng Đi</div>
                                                    <div class="author">Hoài Lan</div>
                                                    <div class="price">200000$</div>
                                                </div>
                                            </a>
                                        </div>

                                        <!-- CỘT 2 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-20%</div>
                                                    <div class="image" style="background-image: url(images/sach1.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Xách Ba Lô Và Đi</div>
                                                    <div class="author">Huyền Chíp</div>
                                                    <div class="price">90000$</div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="prod_row">
                                        <!-- CỘT 1 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-50%</div>
                                                    <div class="image" style="background-image: url(images/xx1.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Đừng Đi</div>
                                                    <div class="author">Hoài Lan</div>
                                                    <div class="price">200000$</div>
                                                </div>
                                            </a>
                                        </div>

                                        <!-- CỘT 2 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-20%</div>
                                                    <div class="image" style="background-image: url(images/sach1.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Xách Ba Lô Và Đi</div>
                                                    <div class="author">Huyền Chíp</div>
                                                    <div class="price">90000$</div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                </div>

                                <!-- CỘT PHẢI -->
                                <div class="col_right">
                                    <div class="header">
                                        <div class="line"><hr width="100%" align="content"></div>
                                        <div class="title"><p>Sách Văn Học</p></div>
                                        <div class="line"><hr width="100%" align="content"></div>
                                    </div>
                                    <div class="prod_row">
                                        <!-- CỘT 1 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-20%</div>
                                                    <div class="image" style="background-image: url(images/sach1.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Xách Ba Lô Và Đi</div>
                                                    <div class="author">Huyền Chíp</div>
                                                    <div class="price">90000$</div>
                                                </div>
                                            </a>
                                        </div>

                                        <!-- CỘT 2 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-50%</div>
                                                    <div class="image" style="background-image: url(images/xx.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Đừng Đi</div>
                                                    <div class="author">Hoài Lan</div>
                                                    <div class="price">200000$</div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="prod_row">
                                        <!-- CỘT 1 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-50%</div>
                                                    <div class="image" style="background-image: url(images/xx.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Đừng Đi</div>
                                                    <div class="author">Hoài Lan</div>
                                                    <div class="price">200000$</div>
                                                </div>
                                            </a>
                                        </div>

                                        <!-- CỘT 2 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-20%</div>
                                                    <div class="image" style="background-image: url(images/sach1.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Xách Ba Lô Và Đi</div>
                                                    <div class="author">Huyền Chíp</div>
                                                    <div class="price">90000$</div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="prod_row">
                                        <!-- CỘT 1 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-50%</div>
                                                    <div class="image" style="background-image: url(images/xx1.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Đừng Đi</div>
                                                    <div class="author">Hoài Lan</div>
                                                    <div class="price">200000$</div>
                                                </div>
                                            </a>
                                        </div>

                                        <!-- CỘT 2 -->
                                        <div class="pr_col">
                                            <a href="/bookstore/detail/6">
                                                <div class="col_top">
                                                    <div class="offer">-20%</div>
                                                    <div class="image" style="background-image: url(images/sach1.jpg);"></div>
                                                </div>
                                                <div class="col_bottom">
                                                    <div class="product_name">Xách Ba Lô Và Đi</div>
                                                    <div class="author">Huyền Chíp</div>
                                                    <div class="price">90000$</div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <!-- OTHER PRODUCT -->
                            <div class="other_products">
                                <!-- EXTEND 1 -->
                                <div class="extend">
                                    <div class="header">
                                        <div class="line"><hr width="100%" align="content"></div>
                                        <div class="title"><p>Nhật Ký</p></div>
                                        <div class="line"><hr width="100%" align="content"></div>
                                    </div>

                                    <!-- ROW 1 -->
                                    <div class="ex_col">
                                        <div class="ex_row">
                                            <a href="detail.html">
                                                <div class="exr_left">
                                                    <div class="image" style="background-image: url(images/xx3.jpg);"></div>
                                                </div>
                                                <div class="exr_right">
                                                    <div class="col_bottom">
                                                        <div class="product_name">Siêu phẩm Yasuo</div>
                                                        <div class="author">Shigeo Tokuda</div>
                                                        <div class="price">Price: 9$</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <!-- ROW 2 -->
                                    <div class="ex_col">
                                        <div class="ex_row">
                                            <a href="detail.html">
                                                <div class="exr_left">
                                                    <div class="image" style="background-image: url(images/xx3.jpg);"></div>
                                                </div>
                                                <div class="exr_right">
                                                    <div class="col_bottom">
                                                        <div class="product_name">Siêu phẩm Yasuo</div>
                                                        <div class="author">Shigeo Tokuda</div>
                                                        <div class="price">Price: 9$</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <!-- ROW 3 -->
                                    <div class="ex_col">
                                        <div class="ex_row">
                                            <a href="detail.html">
                                                <div class="exr_left">
                                                    <div class="image" style="background-image: url(images/xx3.jpg);"></div>
                                                </div>
                                                <div class="exr_right">
                                                    <div class="col_bottom">
                                                        <div class="product_name">Siêu phẩm Yasuo</div>
                                                        <div class="author">Shigeo Tokuda</div>
                                                        <div class="price">Price: 9$</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <!-- ROW 4 -->
                                    <div class="ex_col">
                                        <div class="ex_row">
                                            <a href="detail.html">
                                                <div class="exr_left">
                                                    <div class="image" style="background-image: url(images/xx3.jpg);"></div>
                                                </div>
                                                <div class="exr_right">
                                                    <div class="col_bottom">
                                                        <div class="product_name">Siêu phẩm Yasuo</div>
                                                        <div class="author">Shigeo Tokuda</div>
                                                        <div class="price">Price: 9$</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <!-- ROW 5 -->
                                    <div class="ex_col">
                                        <div class="ex_row">
                                            <a href="detail.html">
                                                <div class="exr_left">
                                                    <div class="image" style="background-image: url(images/xx3.jpg);"></div>
                                                </div>
                                                <div class="exr_right">
                                                    <div class="col_bottom">
                                                        <div class="product_name">Siêu phẩm Yasuo</div>
                                                        <div class="author">Shigeo Tokuda</div>
                                                        <div class="price">Price: 9$</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div style="padding: 20px 0px 0px 20px;"><a href="#">Xem thêm >></a></div>
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

        <script >
            var slideIndex = 1;
            showSlide(slideIndex);
            carousel();

            function carousel() {
                var i;
                var x = document.getElementsByClassName("mySlides");
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = "none";
                }
                slideIndex++;
                if (slideIndex > x.length) {
                    slideIndex = 1
                }
                x[slideIndex - 1].style.display = "block";
                setTimeout(carousel, 2000);
            }

            function showSlide(n) {
                var i;
                var x = document.getElementsByClassName("mySlides");
                if (n > x.length) {
                    slideIndex = 1
                }
                if (n < 1) {
                    slideIndex = x.length
                }
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = "none";
                }
                x[slideIndex - 1].style.display = "block";
            }
        </script>			
    </body>
</html>