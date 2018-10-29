<%@page import="models.User"%>
<div class="header">
    <a href="/bookstore/admin/books"><h4>BookStore</h4></a>
    <div class="navbar">
        <div class="dropdown">
            <% User user = (User) session.getAttribute("user"); %>
            <% String welcome =  Lang.getKey(language, "Welcome") + " " + user.getName(); %>
            <button class="dropbtn" onclick="myFunction()"><%= welcome %>
                <i class="fa fa-caret-down"></i>
            </button>
            <div class="dropdown-content" id="myDropdown">
                <a href="inforadmin.html">Account</a>
                <a href="changepassadmin.html">Change Password</a>
                <form action="/bookstore/admin/logout" method="Post" id="logout">
                    <a href="javascript:document.querySelector('#logout').submit()" role="button">Log out</a>
                </form>
            </div>
        </div> 
    </div>
    <div class="lang-form">
        <%@include file="/WEB-INF/langForm.jsp" %>
    </div>
    <div class="search-container">
        <form action="">
            <input type="text" placeholder="Search.." name="search">
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
    </div>

</div>
