<%@page import="models.User"%>
<div class="header">
    <a href="/bookstore/admin/books"><h4>BookStore</h4></a>
    <div class="navbar">
        <div class="dropdown">
            <% User user = (User) session.getAttribute("user"); %>
            <% String welcome = Lang.getKey(language, "Welcome") + " " + user.getName();%>
            <button class="dropbtn"><%= welcome%>
            </button>
            <form action="/bookstore/admin/logout" method="Post" id="logout">
            </form>
        </div> 
    </div>
    <div class="lang-form">
        <%@include file="/WEB-INF/langForm.jsp" %>
    </div>
    <div class="search-container">
        <form action="">
            <input type="text" placeholder="Search.." name="search" value="<%= request.getParameter("search") != null ? request.getParameter("search") : ""%>">
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
    </div>

</div>
