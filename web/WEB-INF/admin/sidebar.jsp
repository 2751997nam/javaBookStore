<div class="sidebar">
    <ul>
        <li class="accordion"><img src="/bookstore/images/dashboard.png"><a class="panel" href="/bookstore/admin/dashboard"><%= Lang.getKey(language, "Dashboard")%></li>
        <li class="accordion"><img src="/bookstore/images/books.png"><a  href="javascipt:void(0)"><%= Lang.getKey(language, "Books")%></a></li>
        <div class="item">
            <ul>               
                <li><a class="panel" href="/bookstore/admin/books"><%= Lang.getKey(language, "List")%></a></li>
                <li><a class="panel" href="/bookstore/admin/books/add"><%= Lang.getKey(language, "Create")%></a></li>
            </ul>
        </div>
        <li class="accordion"><img src="/bookstore/images/categorys.png"><a href="javascipt:void(0)"><%= Lang.getKey(language, "Categories")%></a></li>
        <div class="item">
            <ul>               
                <li><a class="panel" href="/bookstore/admin/categories"><%= Lang.getKey(language, "List")%></a></li>
                <li><a class="panel" href="/bookstore/admin/categories/add"><%= Lang.getKey(language, "Create")%></a></li>
            </ul>
        </div>
        <li class="accordion"><img src="/bookstore/images/orders.png"><a href="/bookstore/admin/orders"><%= Lang.getKey(language, "Orders")%></a></li>
        <li class="accordion"><img src="/bookstore/images/user.png"><a href="javascipt:void(0)"><%= Lang.getKey(language, "Users")%></a></li>
        <div class="item">
            <ul>               
                <li><a class="panel" href="/bookstore/admin/users"><%= Lang.getKey(language, "Customers")%></a></li>
                <% if(user.getRole_id() == 1) { %>
                    <li><a class="panel" href="/bookstore/admin/managers"><%= Lang.getKey(language, "Managers")%></a></li>
                <% } %>
            </ul>
        </div>
        <li class="accordion"><img src="/bookstore/images/logout.png"><a href="javascript:document.querySelector('#logout').submit()"><%= Lang.getKey(language, "Logout")%></a></li>
    </ul>           
</div>
