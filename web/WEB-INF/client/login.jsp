<%-- 
    Document   : login
    Created on : Oct 21, 2018, 10:31:36 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style/client_reset.css">
        <link rel="stylesheet" type="text/css" href="style/client_login.css">
        <title>Login</title>
    </head>
    <body>
        <div class="content">
            <div class="form">
                <div class="top row">
                    <div class="col-2">
                        <a href="/bookstore"><img src="images/back-arrow.png"/></a>
                    </div>
                    <div class="col-8">
                        <p>Login</p>
                    </div>
                    <div class="col-2"></div>
                </div>
                <div class="mid">
                    <form class="form-input" action="login" method="post">
                        <% if (request.getAttribute("error") != null) {%>
                        <div class="error">
                            <span class="text-error">
                                <%= (String) request.getAttribute("error")%>
                            </span>
                        </div>
                        <%}%>
                        <div>
                            <input type="email" name="email" class="input-round" placeholder="Email" required/>
                        </div>
                        <div>
                            <input type="password" name="password" class="input-round" placeholder="Password" required/>
                        </div>
                        <div style="display: flex;">
                            <p style="margin-right: auto;">
                                <input type="checkbox" name="remember"/>
                                <span>  Remember me?</span>
                            </p>
                            <p><span>Forgot</span> <a href="#">Username/Password?</a></p>
                        </div>
                        <div>
                            <button type="submit" class="input-round">LOGIN</button>
                        </div>
                        <div style="margin-top: 100px;">
                            <span>Don't have an account?</span>
                            <br/>
                            <br/>
                            <a href="sign-up">SIGN UP NOW</a>
                        </div>
                    </form>
                </div>
                <div class="bot">

                </div>
            </div>
        </div>
    </body>
</html>
