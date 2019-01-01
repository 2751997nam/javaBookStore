<%-- 
    Document   : detail
    Created on : Oct 29, 2018, 9:13:45 AM
    Author     : nguye
--%>

<%@page import="models.Rate"%>
<%@page import="models.Comment"%>
<%@page import="config.Lang"%>
<%@page import="controllers.TimeController"%>
<%@page import="java.util.List"%>
<%@page import="config.Database"%>
<%@page import="models.Book"%>
<%@include file="../language.jsp" %>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <title>Detail Now</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="../style/client_style.css">
        <link rel="stylesheet" type="text/css" href="../style/client_sub.css">
        <link rel="stylesheet" type="text/css" href="../style/client_reset.css">
        <link rel="stylesheet" type="text/css" href="../style/client_index.css">
        <link rel="stylesheet" type="text/css" href="../style/client_account.css">
        <link rel="stylesheet" type="text/css" href="style/modal.css">
    </head>
    <body>
        <%
            Book book = (Book) request.getAttribute("book");
            List<Book> top_sell = (List) request.getAttribute("top_sell");
            List<Comment> comments = (List) request.getAttribute("comments");
            List<Rate> rates = (List) request.getAttribute("rates");
        %>
        <div class="container">
            <!-- HEADER TOP : HEADER -->
            <%@include file="layout/header.jsp" %>
            <!--body-->
            <div class="wrapper-color">
                <div class="bread-crumb">
                    <a href="#">Home</a>
                    <span>❯ <%= Lang.getKey(language, "Detail")%></span>
                </div>
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
                                </div>
                                <div class="row1">
                                    <form action="/bookstore/add-cart" method="post">
                                        <div class="quantity">
                                            <input id="book_id" name="book_id" type="hidden" value="<%= book.getId()%>"/>
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
                            <p class="card-head"><%= Lang.getKey(language, "Comments")%> ( <%= Lang.getKey(language, "Your questions,...")%> )</p>
                            <div class="card-body">
                                <form action="/bookstore/comment" method="post">
                                    <div class="form-group">
                                        <input type="hidden" name="book_id" value="<%= book.getId()%>"/>
                                        <textarea class="form-control textareaC" rows="3" name="content" required></textarea>
                                    </div>
                                    <button type="submit" class="btn-submit"><%= Lang.getKey(language, "Submit")%></button>
                                </form>
                            </div>
                            <% if (!comments.isEmpty()) {%>
                            <% for (Comment comment : comments) {%>
                            <div class="row" id="media">
                                <img src="http://placehold.it/50x50" class="rounded-circle">
                                <div class="media-body">
                                    <p class="commenter"><span class="text-time"><%= comment.getUser().getName()%></span><span class="margin-auto"></span><span class="text-time"><%= TimeController.showTime(comment.getCreated_at())%></span></p>
                                    <p class="text-comment content-edit"><%= comment.getContent()%></p>
                                    <% if ((session.getAttribute("email") == null ? "" : session.getAttribute("email")).equals(comment.getUser().getEmail())) {%>
                                    <div id="change">
                                        <p class="show-edit"><a onclick="showEdit()"><%= Lang.getKey(language, "Edit")%></a></p>
                                        <p class=""><a href="/bookstore/comment/delete?id=<%= comment.getId()%>"><%= Lang.getKey(language, "Delete")%></a></p>
                                    </div>
                                    <div id="edit-form">
                                        <form action="/bookstore/comment/edit" method="post">
                                            <div class="form-group">
                                                <input type="hidden" name="id" value="<%= comment.getId()%>"/>
                                                <textarea class="form-control textareaC" rows="3" name="content" required><%= comment.getContent()%></textarea>
                                            </div>
                                            <button type="submit" class="btn-submit"><%= Lang.getKey(language, "Submit")%></button>
                                        </form>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                            <%}%>
                            <% if (comments.size() == 3) {%>
                            <div>
                                <a href="#"><%= Lang.getKey(language, "see more")%></a>
                            </div>
                            <% } %>
                            <% }%>
                        </div>

                        <div id="rating">
                            <h3 class="section-name"><%= Lang.getKey(language, "CUSTOMER FEEDBACKS")%></h3>
                            <div class="rating-body">
                                <p><%= Lang.getKey(language, "Share your review")%></p>
                                <div class="btn-rating">
                                    <button id="show-rating" onclick="showRating(this)"><%= Lang.getKey(language, "Write your review")%></button>
                                    <button id="hide-rating" onclick="hideRating(this)"><%= Lang.getKey(language, "Close")%></button>
                                </div>
                                <div id="form-rating">
                                    <input type="hidden" id="countStar" name="star" value="5">
                                    <input type="hidden" name="id">
                                    <div class="rating-star">
                                        <p>1. <%= Lang.getKey(language, "Your rating of this product")%>:</p>
                                        <div class="rating">
                                            <div class="rating-box">
                                                <div class="stars" onclick="setStars(1)" onmousemove="moveoverStar(1)" onmouseout="clearMove()">
                                                    <span class="star"><img src="../images/star.png"></span>
                                                    <span class="white-star"><img src="../images/starwhite.png"></span>
                                                </div>
                                                <div class="stars" onclick="setStars(2)" onmousemove="moveoverStar(2)" onmouseout="clearMove()">
                                                    <span class="star"><img src="../images/star.png"></span>
                                                    <span class="white-star"><img src="../images/starwhite.png"></span>
                                                </div>
                                                <div class="stars" onclick="setStars(3)" onmousemove="moveoverStar(3)" onmouseout="clearMove()">
                                                    <span class="star"><img src="../images/star.png"></span>
                                                    <span class="white-star"><img src="../images/starwhite.png"></span>
                                                </div>
                                                <div class="stars" onclick="setStars(4)" onmousemove="moveoverStar(4)" onmouseout="clearMove()">
                                                    <span class="star"><img src="../images/star.png"></span>
                                                    <span class="white-star"><img src="../images/starwhite.png"></span>
                                                </div>
                                                <div class="stars" onclick="setStars(5)" onmousemove="moveoverStar(5)" onmouseout="clearMove()">
                                                    <span class="star"><img src="../images/star.png"></span>
                                                    <span class="white-star"><img src="../images/starwhite.png"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="rating-content">
                                        <p>2. <%= Lang.getKey(language, "Write your review below")%>:</p>
                                        <br>
                                        <div class="form-group">
                                            <textarea class="form-control" id="review-content" rows="3" name="review-content" required></textarea>
                                            <p class="color-red error"></p>
                                        </div>
                                    </div>
                                    <div>
                                        <button class="submit-rating" onclick="sendReview()"><%= Lang.getKey(language, "Send")%></button>   
                                    </div>
                                </div>
                                <div id="rates">
                                    <% if (!rates.isEmpty()) { %>
                                        <% for (Rate rate : rates) {%>
                                            <div class="rate-item">
                                                <div class="rate-l">
                                                    <div class="rate-img">
                                                        <img src="http://placehold.it/60x60" class="rounded-circle">
                                                    </div>
                                                    <p><%= rate.getUser().getName() %></p>
                                                </div>
                                                <div class="rate-r">
                                                    <div class="rate-rt">
                                                        <div class="item-rating">
                                                            <p class="rating">
                                                                <span class="rating-box">
                                                                    <% for (int i = 1; i <= 5; i++ ) {
                                                                        if (i <= rate.getStar()) {
                                                                    %>
                                                                            <i><img src="../images/star.png"></i>
                                                                        <% } else {%>
                                                                        <i><img src="../images/starwhite.png"></i>
                                                                        <% } %>
                                                                    <% } %>
                                                                </span>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="rate-rb">
                                                        <p class="comment"><%= rate.getComment() %></p>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    <% } %>
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
            <!--end footer-->

            <!--modal show message-->
            <div id="message" class="modal modal-msg" style="display: none;">
                <div class="modal-content">
                    <div class="model-head">
                        <span class="close" onClick="hideModal()">&times;</span>
                    </div>
                    <div class="modal-body">
                        <p class="color-red font-weight-bolder"

                    </p>
                </div>
            </div>
        </div>
        <!--js-->
        <script src="../js/app.js"></script>
        <script>
                        function hideModal() {
                            document.getElementById("message").style.display = "none";
                        }
                        function showEdit() {
                            document.getElementById("change").style.display = "none";
                            document.getElementById("edit-form").style.display = "block";
                        }
        </script>
        <script src="../js/star_rating.js"></script>
</body>
</html>