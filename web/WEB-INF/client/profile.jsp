<%-- 
    Document   : account
    Created on : Oct 22, 2018, 8:47:16 PM
    Author     : nguye
--%>

<%@page import="models.Profile"%>
<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Account now</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="style/client_style.css">
        <link rel="stylesheet" type="text/css" href="style/client_sub.css">
        <link rel="stylesheet" type="text/css" href="style/client_reset.css">
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
            <div class="header">
                <div class="header_top">
                    <div class="ht_left">
                        <div class="search">
                            <input type="text" name="name" placeholder="Search here ...">
                        </div>
                    </div>
                    <div class="logo">
                        <a href="/bookstore"><img src="images/logo.jpg"></a>
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
            <div style="background-color:#F5F5F5;">
                <div class="body">
                    <div class="row">
                        <div class="sidebar">
                            <div class="title">
                                <p>Thông tin tài khoản</p>
                            </div>

                            <div class="list_items">
                                <ul>
                                    <li><a href="" class="fa fa-angle-right"> Thông tin tài khoản</a></li>
                                    <li><a href="" class="fa fa-angle-right"> Đổi mật khẩu</a></li>
                                    <li><a href="" class="fa fa-angle-right"> Quản lý đơn hàng</a></li>
                                    <li><a href="" class="fa fa-angle-right"> Sổ địa chỉ</a></li>
                                    <li><a href="" class="fa fa-angle-right"> Nhận xét của tôi</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="main">
                            <form action="profile?action=infor" method="post">

                                <div class="row">
                                    <label class="font-weight-bolder">Họ Tên</label>
                                    <input type="text" name="name" class="infor_name" placeholder="Họ tên người dùng" value="<%= user.getName()%>">
                                    <div class="clear"></div>
                                </div>

                                <div class="row">
                                    <label class="font-weight-bolder">Số điện thoại</label>
                                    <input type="text" name="phone" class="infor_name" placeholder="Số điện thoại người dùng" value="<%= profile.getPhone() == null ? "" : profile.getPhone()%>">
                                    <div class="clear"></div>
                                </div>

                                <div class="row">
                                    <label class="font-weight-bolder">Email</label>
                                    <input type="text" name="email" class="infor_name" placeholder="Email người dùng" value="<%= user.getEmail()%>">
                                    <div class="clear"></div>
                                </div>

                                <div class="row">
                                    <label class="font-weight-bolder">Giới tính</label>
                                    <div class="gener">
                                        <% // if(profile.getGender() == 1) {%>
                                        <span><input type="radio" name="gender" value="male" <%= profile.getGender() == 1 ? "Checked" : ""%>><span>Nam</span></span>
                                        <span><input type="radio" name="gender" value="female" <%= profile.getGender() == 0 ? "Checked" : ""%>><span>Nữ</span></span>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="row">
                                    <label class="font-weight-bolder">Ngày sinh</label>
                                    <div class="birthday-picker">
                                        <fieldset class="birthday-wrapper">
                                            <select class="birthday" name="day">
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

                                            <select class="birthday" name="month">
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

                                            <select class="birthday" name="year">
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
                                    <div class="clear"></div>
                                </div>
                                <button type="submit" style="background: #ff5722;border: none;padding: 10px 20px; border-radius: 3px;cursor: pointer;">Lưu</button>
                            </form>  
                        </div>                 
                    </div>

                    <div class="clear"></div>
                </div>
            </div>
            <!-- SOCIAL -->
            <!-- <div class="social">
                    <a href="#" class="fb"></a>
                    <a href="#" class="t"></a>
                    <a href="#" class="d"></a>
                    <a href="#" class="g"></a>
            </div> -->
            <!-- HẾT SOCIAL-->

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
    </body>
</html>