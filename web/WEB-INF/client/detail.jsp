<%-- 
    Document   : detail
    Created on : Oct 29, 2018, 9:13:45 AM
    Author     : nguye
--%>

<%@page import="config.Lang"%>
<%@page import="java.util.List"%>
<%@page import="config.Database"%>
<%@page import="models.Book"%>
<%@include file="../language.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <title>Detail Now</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="../style/client_style.css">
        <link rel="stylesheet" type="text/css" href="../style/client_sub.css">
        <link rel="stylesheet" type="text/css" href="../style/client_reset.css">
        <link rel="stylesheet" type="text/css" href="../style/client_index.css">
        <link rel="stylesheet" type="text/css" href="../style/client_account.css">

    </head>
    <body>
        <%
            Book book = (Book) request.getAttribute("book");
            List<Book> top_sell = (List) request.getAttribute("top_sell");
        %>
        <div class="container">
            <!-- HEADER TOP : HEADER -->
            <%@include file="layout/header.jsp" %>
            <!--body-->
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
                                    <p><%= Lang.getKey(language, "Author")%>: <a class="author" href="#"><%= book.getAuthor()%></a></p>
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
                                    <form action="/bookstore/add-cart" method="post">
                                        <div class="quantity">
                                            <input name="book_id" type="hidden" value="<%= book.getId()%>"/>
                                            <div class="button-group">
                                                <p><%= Lang.getKey(language, "Quantity")%></p>
                                                <select class="number" name="quantity">
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
                                            </div>
                                        </div>
                                        <div class="addCart form-c">
                                            <button style="submit"><%= Lang.getKey(language, "Add To Cart")%></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="description">
                            <h3 class="section-name"><%= Lang.getKey(language, "Introduction")%></h3>
                            <div class="des">
                                <strong><span><%= book.getName()%>&nbsp;</span></strong>
                                <p><%= book.getDescription()%></p>
                                <div>&nbsp;</div>
                            </div>
                        </div>


                        <div id="comment">
                            <p class="card-head"><%= Lang.getKey(language, "Comments")%></p>
                            <div class="card-body">
                                <form>
                                    <div class="form-group">
                                        <textarea class="form-control" rows="3"></textarea>
                                    </div>
                                    <button type="submit" class="btn-submit"><%= Lang.getKey(language, "Submit")%></button>
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
                            <h3 class="section-name"><%= Lang.getKey(language, "RECOMMEND RELATED PRODUCTS")%></h3>
                            <div class="row">
                                <% for (Book b : top_sell) {%>
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
            <%@include file="layout/footer.jsp" %>
    </body>
</html>