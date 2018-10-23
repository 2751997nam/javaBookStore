<div class="header">
    <a href="/bookstore/admin/books"><h4>Admin Page</h4></a>
    <div class="navbar">
        <div class="dropdown">
            <button class="dropbtn" onclick="myFunction()">Welcome User
                <i class="fa fa-caret-down"></i>
            </button>
            <div class="dropdown-content" id="myDropdown">
                <a href="inforadmin.html">Account</a>
                <a href="changepassadmin.html">Change Password</a>
                <form action="/bookstore/logout" method="Post" id="logout">
                    <a href="javascript:document.querySelector('#logout').submit()" role="button">Log out</a>
                </form>
            </div>
        </div> 
    </div>
    <div class="lang-form">
        <%@include file="/WEB-INF/langForm.jsp" %>
    </div>
    <div class="search-container">
        <form action="/action_page.php">
            <input type="text" placeholder="Search.." name="search">
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
    </div>

</div>
