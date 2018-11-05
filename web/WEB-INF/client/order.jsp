<%-- 
    Document   : account
    Created on : Oct 22, 2018, 8:47:16 PM
    Author     : nguye
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="config.Lang"%>
<%@page import="models.Profile"%>
<%@page import="models.User"%>
<%@include file="../language.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <title>My Order</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="style/client_reset.css">       
        <link rel="stylesheet" type="text/css" href="style/client_style.css">
        <link rel="stylesheet" type="text/css" href="style/client_index.css">
        <link rel="stylesheet" type="text/css" href="style/client_category.css">
        <link rel="stylesheet" type="text/css" href="style/client_account.css">
    </head>
    <body>
        <%
            List<HashMap> orders = (List) request.getAttribute("orders");
        %>
        <div class="container">
            <!-- HEADER TOP : HEADER -->
            <%@include file="layout/header.jsp" %>
            <!--body-->
            <div class="wrapper-color">
                <div class="container" id="product-content">
                    <div class="col-md-3">
                        <div class="sidebar-wrapper">
                            <div class="sb-top">
                                <div class="sb-logo">
                                    <img src="images/profile.png">
                                </div>
                            </div>
                            <div class="sb-body">
                                <ul class="sb-list">
                                    <li class="sb-items"><a class="sb-items-link" href="/bookstore/profile">Thông Tin Tài Khoản</a></li>
                                    <li class="sb-items" id="dropdown"><a class="sb-items-link" href="">Đổi Mật Khẩu</a></li>
                                    <li class="sb-items"><a class="sb-items-link color-blue" href="/bookstore/order">Quản Lý Đơn Hàng</a></li>
                                    <li class="sb-items"><a class="sb-items-link" href="">Nhận Xét Của Tôi</a></li>
                                </ul>
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
                        <div class="myCart-wrapper">
                            <div class="cart-table">
                                <div class="thead">
                                    <div class="tr">
                                        <div class="proid">Mã đơn hàng</div>
                                        <div class="prodate">Ngày mua</div>
                                        <div class="proname">Sản phẩm</div>
                                        <div class="proprice">Số lượng</div>
                                        <div class="proprice">Tổng tiền</div>
                                        <div class="prostatus">Trạng thái</div>
                                    </div>
                                </div>

                                <div class="tbody">
                                    <% if (!orders.isEmpty()) {%>
                                        <% for (HashMap order : orders) {%>
                                            <div class="tr">
                                                <div class="proid"><%= order.get("id")%></div>
                                                <div class="prodate"><%= order.get("created_at")%></div>
                                                <div class="proname"><%= order.get("name")%></div>
                                                <div class="proprice"><%= order.get("quantity")%></div>
                                                <div class="proprice"><%= order.get("price")%> ₫</div>
                                                <div class="prostatus">Giao hàng thành công</div>
                                            </div>
                                         <% } %>
                                    <% }else { %>
                                        <p class="color-red">Hiện tại bạn chưa mua gì</p>
                                    <% } %>
                                <div class="tbottom">
                                    <div class="tr">
                                        <p>Cám ơn bạn đã mua hàng tại shop!!</p>
                                    </div>
                                    <div class="tr">
                                        <img src="images/thank-you.png">
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <!-- FOOTER -->
            <%@include file="layout/footer.jsp" %>
            <!-- HẾT FOOTER -->
        </div>
    </body>
</html>