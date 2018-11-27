<%-- 
    Document   : admin_login
    Created on : Jun 16, 2018, 2:48:11 PM
    Author     : Sheha
--%>

<%@page import="pojos.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>dydox.lk</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="//fonts.googleapis.com/css?family=Work+Sans:100,200,300,400,500,600,700,800,900" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/font-awesome.css" rel="stylesheet" type="text/css" media="all" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

    </head>
    <body>
        <%
            Admin a = (Admin) request.getSession().getAttribute("admin");
            if (a == null) {
        %>


        <div class="banner-layer">
            <div class="logo text-center">
                <h1>
                    <a href="index.jsp" style="text-decoration: none;">

                        <span aria-hidden="true">  <img src="images/head_4.png"></span>DYDOX.LK</a>
                </h1>
            </div>
            <div class="w3ls-container   text-center">

                <div class="w3l-content">
                    <div class="left-grid">
                        <h2 class="text-w3layouts">Best Softwares</h2>
                        <span class="text-w3layouts">under one web application</span>
                    </div>
                    <div class="right-grid">
                        <p>start analyzing and managing the worlds most famous software shop</p>

                        <!--------------------------------LOGIN----------------------------------------->
                        <div class="sub-form" id="login" >
                            <form name="signIn_form" onsubmit="return false">
                                <span class="heading_form">Take me in</span>
                                <br>
                                <br>
                                <input type="email" name="email" size="30" required="" placeholder="Email" id="login_email">
                                <br>
                                <br>
                                <input type="password" name="password" size="30" required="" placeholder="Password" id="login_password">
                                <br>
                                <br>
                                <a href="#" style="margin-left: -38%;color: blue;font-size: 14px;"><u>Forgot Password?</u></a>
                                <br>
                                <br>
                                <br>
                                <h4 id="msg_signIn" style="color: red;"></h4><br>
                                <img id="img_load_2">
                                <button class="btn1" onclick="admin_login();">
                                    <span class="fa fa-paper-plane" aria-hidden="true"></span>
                                </button>
                            </form>

                        </div>
                        <!--------------------------------LOGIN----------------------------------------->



                    </div>
                </div>
                <div class="agile-social-icons">
                    <p style="color: #12B776;">Get inspired and Follow our Team! To stay up to date</p>
                    <ul class="social_list">
                        <li>
                            <a href="#">
                                <img src="images/a1.png" alt="" />
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <img src="images/b1.png" alt="" />
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <img src="images/d1.png" alt="" />
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <img src="images/e1.png" alt="" />
                            </a>
                        </li>
                    </ul>
                </div>

            </div>



            <div class="footer">

            </div>
        </div>

        <script type="text/javascript">

            function admin_login() {

                var c = document.forms["signIn_form"]["email"].value;
                var d = document.forms["signIn_form"]["password"].value;

                var msg2 = document.getElementById("msg_signIn");

                if (c == null || c == "", d == null, d = "") {
                    msg2.innerHTML = "Fill the details!";
                } else {
                    var email = document.getElementById("login_email").value;
                    var password = document.getElementById("login_password").value;

                    var atpos = email.indexOf("@");
                    var dotpos = email.lastIndexOf(".");

                    if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                        msg2.innerHTML = "Not a valid e-mail address";
                        return false;
                    }

                    else {
                        //right email


                        var json = {"email": email, "password": password};
                        var json_str = JSON.stringify(json);

                        var req = new XMLHttpRequest();

                        req.onreadystatechange = function() {
                            document.getElementById("img_load_2").src = "images/loading_3.gif";
                            if (req.readyState === 4 && req.status === 200) {
                                document.getElementById("img_load_2").src = "";
                                var txt = req.responseText;


                                if (txt == 1) {
                                    window.location = "admin_index.jsp";
                                } else if (txt == 2) {

                                    msg2.innerHTML = "Fill the details!";

                                } else if (txt == 0) {
                                    msg2.innerHTML = "Wrong details!";

                                }
                            }
                        };

                        req.open("post", "admin_log", true)
                        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        req.send("json_str=" + json_str);
                    }
                }

            }
        </script>
        <%
            } else {
                response.sendRedirect("admin_index.jsp");
            }
        %>
    </body>
</html>
