<%-- 
    Document   : account
    Created on : Oct 22, 2018, 8:47:16 PM
    Author     : nguye
--%>
<%@page import="models.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="config.Lang"%>
<%@page import="models.Profile"%>
<%@page import="models.User"%>
<%@include file="../../language.jsp" %>
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
        <link rel="stylesheet" type="text/css" href="style/modal.css">
    </head>
    <body>
        <%
            List<Order> orders = (List) request.getAttribute("orders");
            Profile profile = (Profile) request.getAttribute("profile");
        %>
        <div class="container">
            <!-- HEADER TOP : HEADER -->
            <%@include file="../layout/header.jsp" %>
            <!--body-->
            <div class="wrapper-color">
                <div class="container" id="product-content">
                    <div class="col-md-3">
                        <div class="sidebar-wrapper">
                            <div class="sb-top">
                                <div class="sb-logo">
                                    <% if (!" ".equals(profile.getAvatar())) {%>
                                        <img src="<%= profile.showAvatar()%>">
                                    <% } else { %>
                                        <img src="images/profile.png">
                                    <% } %>
                                </div>
                            </div>
                            <div class="sb-body">
                                <ul class="sb-list">
                                    <li class="sb-items"><a class="sb-items-link" href="/bookstore/profile"><%= Lang.getKey(language, "User Information")%></a></li>
                                    <li class="sb-items" id="dropdown"><a class="sb-items-link" href="/bookstore/change-password"><%= Lang.getKey(language, "Change Password")%></a></li>
                                    <li class="sb-items"><a class="sb-items-link color-blue" href="/bookstore/order"><%= Lang.getKey(language, "Manage Orders")%></a></li>
                                    <li class="sb-items"><a class="sb-items-link" href=""><%= Lang.getKey(language, "My Feedback")%></a></li>
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
                                        <div class="proid"><%= Lang.getKey(language, "Num.")%></div>
                                        <div class="prodate"><%= Lang.getKey(language, "Created")%></div>
                                        <div class="prostatus"><%= Lang.getKey(language, "Status")%></div>
                                        <div class="prostatus"><%= Lang.getKey(language, "Action")%></div>
                                    </div>
                                </div>
                                <div class="tbody">
                                    <% if (!orders.isEmpty()) {%>
                                    <% for (Order order : orders) {%>
                                    <div class="tr">
                                        <div class="proid"><%= order.getId()%></div>
                                        <div class="prodate"><%= order.getCreated_at()%></div>
                                        <% if (order.getStatus() == 1) {%>
                                        <div class="prostatus"><%= Lang.getKey(language, "processing")%></div>
                                        <div class="prostatus">
                                            <a class="color-blue" href="/bookstore/order_detail/<%= order.getId()%>"><%= Lang.getKey(language, "Edit")%></a>
                                            <a class="color-red" data-id="<%= order.getId()%>" onclick="showModal(this)"><%= Lang.getKey(language, "Delete")%></a>
                                        </div>
                                        <% } else {%>
                                        <div class="prostatus"><%= Lang.getKey(language, "delivered")%></div>
                                        <div class="prostatus">
                                            <a class="color-blue" href="/bookstore/order_detail/<%= order.getId()%>v"><%= Lang.getKey(language, "View")%></a>
                                            <a class="color-red" data-id="<%= order.getId()%>" onclick="showModal(this)"><%= Lang.getKey(language, "Delete")%></a>
                                        </div>
                                        <% } %>
                                    </div>
                                    <% } %>
                                    <% } else { %>
                                    <p class="color-red">Hiện tại bạn chưa mua gì</p>
                                    <% }%>
                                    <div class="tbottom">
                                        <div class="tr">
                                            <p><%= Lang.getKey(language, "Thank for your puchase at Our Website")%>!!</p>
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
                <%@include file="../layout/footer.jsp" %>
                <!-- HẾT FOOTER -->
            </div>
            <!--modal delete-->
            <div id="deleteModal" class="modal">
                <div class="modal-content">
                    <div class="model-head">
                        <span class="close" onClick="hideModal()">&times;</span>
                    </div>
                    <div class="modal-body">
                        <p><%= Lang.getKey(language, "Do you want to delete this orders?")%></p>
                        <div class="btn-bot">
                            <a class="btnc" id="link-delete" href="" class="color-red"><%= Lang.getKey(language, "Delete")%></a>
                            <a class="btnc" onclick="hideModal()"><%= Lang.getKey(language, "Cancel")%></a>
                        </div>
                    </div>
                    <div class="modal-footer">

                    </div>
                </div>
            </div>
            <script type="text/javascript">
                function showModal(item) {
                    document.getElementById("deleteModal").style.display = "block";
                    var id = item.getAttribute("data-id");
                    document.getElementById("link-delete").setAttribute("href", "/bookstore/order/delete/" + id);
                }
                function hideModal() {
                    document.getElementById("deleteModal").style.display = "none";
                }
            </script>
    </body>
</html>