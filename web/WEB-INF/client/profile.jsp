<%-- 
    Document   : account
    Created on : Oct 22, 2018, 8:47:16 PM
    Author     : nguye
--%>
<%@page import="config.Lang"%>
<%@page import="models.Profile"%>
<%@page import="models.User"%>
<%@include file="../language.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="<%= language%>">
    <head>
        <title>Account now</title>
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
        <% User user = (User) request.getAttribute("user");
            Profile profile = (Profile) request.getAttribute("profile");
            String day = "Ngày", month = "Tháng", year = "Năm";
            if (profile.getDate_of_birth() != null) {
                year = profile.getDate_of_birth().substring(0, 4);
                month = profile.getDate_of_birth().substring(5, 7);
                day = profile.getDate_of_birth().substring(8, 10);
            }
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
                                    <li class="sb-items"><a class="sb-items-link color-blue" href="/bookstore/profile">Thông Tin Tài Khoản</a></li>
                                    <li class="sb-items" id="dropdown"><a class="sb-items-link" href="/bookstore/change-password">Đổi Mật Khẩu</a></li>
                                    <li class="sb-items"><a class="sb-items-link" href="/bookstore/order">Quản Lý Đơn Hàng</a></li>
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

                    <div class="col-md-9 accounts">
                        <div class="account-wrapper">
                            <h3>Thông tin tài khoản</h3>
                        </div>
                        <form action="profile?action=infor" method="post">
                            <div class="account-body">
                                <div class="form-c">
                                    <lable class="lb">Họ Tên</lable>
                                    <input class="ai" type="text" name="name" value="<%= user.getName()%>" placeholder="Họ tên"/>
                                </div>
                                <div class="form-c">
                                    <lable class="lb">Email</lable>
                                    <input class="ai" type="text" name="email" value="<%= user.getEmail()%>" placeholder="Email" disabled/>
                                </div>
                                <div class="form-c">
                                    <lable class="lb">Phone</lable>
                                    <input class="ai" type="text" name="phone" value="<%= profile.getPhone() == null ? "" : profile.getPhone()%>" placeholder="Số điện thoại"/>
                                </div> 
                                <div class="form-c">
                                    <lable class="lb">Address</lable>
                                    <input class="ai" type="text" name="address" value="<%= profile.getAddress() == null ? "" : profile.getAddress()%>" placeholder="Địa chỉ"/>
                                </div>  
                                <div class="form-c">
                                    <lable class="lb">Gender</lable>
                                    <div class="row">
                                        <div class="col-4"><input type="radio" name="gender" value="male" class="gender" <%= profile.getGender() == 1 ? "Checked" : ""%> ><span>Nam</span></div>
                                        <div class="col-4"><input type="radio" name="gender" value="female" class="gender" <%= profile.getGender() == 0 ? "Checked" : ""%> ><span>Nữ</span></div>
                                    </div>
                                </div>
                                <div class="form-c">
                                    <lable class="lb">Ngay Sinh</lable>
                                    <div class="input-wrap">
                                        <div id="birthday-picker" class="birthday-picker">
                                            <fieldset class="birthday-picker">
                                                <select class="birth-day form-control" name="day">
                                                    <option><%= day%></option>
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
                                                    <option value="20">21</option>
                                                    <option value="20">22</option>
                                                    <option value="20">23</option>
                                                    <option value="20">24</option>
                                                    <option value="20">25</option>
                                                    <option value="20">26</option>
                                                    <option value="20">27</option>
                                                    <option value="20">28</option>
                                                    <option value="20">29</option>
                                                    <option value="20">30</option>
                                                    <option value="20">31</option>
                                                </select>
                                                <select class="birthday form-control" name="month">
                                                    <option><%= month%></option>
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
                                                </select>
                                                <select class="birthday form-control" name="year">
                                                    <option><%= year%></option>
                                                    <option value="2018">2018</option>
                                                    <option value="2017">2017</option>
                                                    <option value="2016">2016</option>
                                                    <option value="2015">2015</option>
                                                    <option value="2014">2014</option>
                                                    <option value="2013">2013</option>
                                                    <option value="2012">2012</option>
                                                    <option value="2011">2011</option>
                                                    <option value="2010">2010</option>
                                                    <option value="2009">2009</option>
                                                    <option value="2008">2008</option>
                                                    <option value="2007">2007</option>
                                                    <option value="2006">2006</option>
                                                    <option value="2005">2005</option>
                                                    <option value="2004">2004</option>
                                                    <option value="2003">2003</option>
                                                    <option value="2002">2002</option>
                                                    <option value="2001">2001</option>
                                                    <option value="2000">2000</option>
                                                    <option value="1999">1999</option>
                                                    <option value="1998">1998</option>
                                                    <option value="1997">1997</option>
                                                    <option value="1996">1996</option>
                                                    <option value="1995">1995</option>
                                                    <option value="1994">1994</option>
                                                    <option value="1993">1993</option>
                                                    <option value="1992">1992</option>
                                                    <option value="1991">1991</option>
                                                    <option value="1990">1990</option>

                                                </select>
                                            </fieldset>
                                        </div>
                                        <span class="help-block"></span>
                                    </div>
                                </div>  
                                <div class="form-c">
                                    <button type="submit" >Save</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- FOOTER -->
            <%@include file="layout/footer.jsp" %>
            <!-- HẾT FOOTER -->
        </div>
    </body>
</html>