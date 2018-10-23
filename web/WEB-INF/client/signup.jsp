<%-- 
    Document   : register
    Created on : Oct 22, 2018, 5:08:18 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style/client_reset.css">
        <link rel="stylesheet" type="text/css" href="style/client_login.css">
        <title>Sign Up</title>
    </head>
    <body>
        <div class="content">
            <div class="form">
                <div class="top row">
                    <div class="col-2">
                        <a href="home"><img src="images/back-arrow.png"/></a>
                    </div>
                    <div class="col-8">
                        <p>Sign Up</p>
                    </div>
                    <div class="col-2"></div>
                </div>
                <div class="mid">
                    <br/>
                    <form class="form-input" action="sign-up" method="post">
                        <% if (request.getAttribute("error") != null) {%>
                        <div class="error">
                            <span class="text-error">
                                <%= (String) request.getAttribute("error")%>
                            </span>
                        </div>
                        <%}%>
                        <div>
                            <input type="text" name="name" class="input-round" placeholder="Name"/>
                        </div>
                        <div>
                            <input type="text" name="email" class="input-round" placeholder="Email"/>
                        </div>
                        <div>
                            <input type="password" name="password" class="input-round" placeholder="Password" id="password" required/>
                        </div>
                        <div>
                            <input type="password" name="cpassword" class="input-round" placeholder="Comfirm Password" id="cpassword" required/>
                        </div>
                        <div>
                            <button type="submit" class="input-round">SIGN UP</button>
                        </div>
                        <div style="margin-top: 40px;">
                            <span>Have an account?</span>
                            <br/>
                            <br/>
                            <a href="login">LOGIN NOW</a>
                        </div>
                    </form>
                </div>
                <div class="bot">

                </div>
            </div>
        </div>
        <script src="js/validate.js"></script>
    </body>
</html>
