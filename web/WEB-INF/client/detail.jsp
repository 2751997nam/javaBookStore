<%-- 
    Document   : detail
    Created on : Oct 29, 2018, 9:13:45 AM
    Author     : nguye
--%>

<%@page import="java.util.List"%>
<%@page import="config.Database"%>
<%@page import="models.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Detail Now</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="../style/client_style.css">
        <link rel="stylesheet" type="text/css" href="../style/client_sub.css">
        <link rel="stylesheet" type="text/css" href="../style/client_reset.css">
    </head>
    <body>
        <% 
            Book book = (Book) request.getAttribute("book");
            List<Book> top_sell = (List) request.getAttribute("top_sell");
        %>
        <div class="container">
            <!-- HEADER TOP : HEADER -->
            <div class="header">
                <div class="header_top">
                    <div class="ht_left">
                        <div class="search">
                            <input type="text" name="name" placeholder="Search here ...">
                        </div>
                    </div>

                    <div class="logo">
                        <a href="/bookstore"><img src="../images/logo.jpg"></a>
                    </div>
                    <div class="ht_right">
                        <ul>
                            <% if (session.getAttribute("email") == null) {%>
                            <li><a href="/bookstore/login" class="fa fa-user">  Login</a></li>
                            <li><a href="/bookstore/sign-up" class="fa fa-user-plus"> Register</a></li>
                                <%} else {%>
                            <li style="display: flex;">
                                <div class="dropdown">
                                    <span>
                                        <a href="#">
                                            <img class="user-avatar" src="../images/user.png"/>
                                            <span class="dropbtn">&nbsp;<%=session.getAttribute("email")%></span>
                                        </a>
                                    </span>
                                    <div class="dropdown-content">
                                        <a href="/bookstore/profile" class="fa fa-user">  Profile</a>
                                        <a href="/bookstore/login?action=logout" class="fa fa-logout">  Logout</a>
                                    </div>
                                </div>
                                <div class="cart">
                                    <a href="#"><img alt="cart" src="../images/shopping-cart.png"/></a>
                                </div>
                            </li>
                            <%}%>
                        </ul>
                    </div>
                </div>
            </div>	

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
            <div class="wrapper-color">
                <div class="body">
                    <div class="detail_product">
                        <div class="row">
                            <div class="col-left">
                                <a href="#"><img src="<%= book.images().size() > 0 ? book.images().get(0).link() : new Database().get("thumbnail")%>"></a>
                            </div>
                            <div class="col-right">
                                <div class="row1">
                                    <div class="product_name"><%= book.getName()%></div>
                                    <div class="item-rating">
                                        <p class="rating">
                                            <span class="rating-box">
                                                <i><img src="../images/star.png"></i>
                                                <i><img src="../images/star.png"></i>
                                                <i><img src="../images/star.png"></i>
                                                <i><img src="../images/starwhite.png"></i>
                                                <i><img src="../images/starwhite.png"></i>
                                            </span>
                                        </p>
                                    </div>
                                    <p>Tác giả: <a class="author" href="#"><%= book.getAuthor()%></a></p>
                                </div>
                                <div class="row1">
                                    <div class="price">
                                        <span class="spiral"></span>
                                        <%= book.showPrice()%> ₫
                                    </div>
                                    <!--                                    <p class="original-price">Giá thị trường: <label>93.000 ₫</label></p>
                                                                        <p class="saving">Tiếp kiệm: <label>30.000 ₫</label></p>-->
                                </div>

                                <div class="row1">
                                    <div class="addCart">
                                        <li><a href="" class="fa fa-cart-plus"> Add to Cart</a></li>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="description">
                            <h3 class="section-name">Giới thiệu sách</h3>
                            <div class="des">
                                <strong><span><%= book.getName()%>&nbsp;</span></strong>
                                <p><%= book.getDescription()%></p>
                                <div>&nbsp;</div>
                            </div>
                        </div>


                        <div id="comment">
                            <p class="card-head">Để Lại Bình Luận Của Bạn:</p>
                            <div class="card-body">
                                <form>
                                    <div class="form-group">
                                        <textarea class="form-control" rows="3"></textarea>
                                    </div>
                                    <button type="submit" class="btn-submit">Submit</button>
                                </form>
                            </div>
                            <div class="row" id="media">
                                <img src="http://placehold.it/50x50" class="rounded-circle">
                                <div class="media-body">
                                    <p class="commenter">Nhật Minh Lê Phan</p>
                                    <p class="text-comment">Sách được bọc rất cẩn thận, giao hàng siêu nhanh. Mình mới nhận nên chưa review về nội dung của sách được. 5 sao cho dịch vụ của Team 09!
                                        <br/>Team 09 giao hàng nhanh, sách đóng gói cẩn thận, không bị móp méo hay tróc chữ, nhân viên giao hàng thân thiện!
                                    </p>
                                </div>
                            </div>
                            <div class="row" id="media">
                                <img src="http://placehold.it/50x50" class="rounded-circle">
                                <div class="media-body">
                                    <p class="commenter">Nguyễn Thúy Hà</p>
                                    <p class="text-comment">Sách đẹp và hay. Những chuyến đi luôn gắn kết con người lại với nhau</p>
                                </div>
                            </div>
                        </div>

                        <div class="other_products">
                            <h3 class="section-name">Sản phẩm có thể bạn quan tâm</h3>
                            <div class="row">
                                <% for(Book b : top_sell) {%>
                                <div class="col-product">
                                    <div class="product-item">
                                        <a href="/bookstore/detail/<%= b.getId()%>">
                                            <span class="img-item">
                                                <img src="<%= b.images().size() > 0 ? b.images().get(0).link() : new Database().get("thumbnail")%>" style="display: inline;">
                                            </span>
                                            <span class="title"><%= b.getName()%></span>
                                            <p class="price-sale"><%= b.showPrice()%> ₫
                                                <span class="price-regular">99.000 ₫</span>
                                                <span class="sale-tag">-30%</span>
                                            </p>
                                        </a>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </div>
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
                <!-- HẾT FOOTER -->
            </div>
    </body>
</html>