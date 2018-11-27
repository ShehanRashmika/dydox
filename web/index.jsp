<%-- 
    Document   : index
    Created on : Apr 10, 2018, 3:29:31 PM
    Author     : Sheha
--%>

<%@page import="pojos.User"%>
<%@page import="servelet.stopServer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
             <title>dydox.lk</title>
        <style>

        </style>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="//fonts.googleapis.com/css?family=Work+Sans:100,200,300,400,500,600,700,800,900" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/font-awesome.css" rel="stylesheet" type="text/css" media="all" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
        <script>
            addEventListener("load", function() {
                setTimeout(hideURLbar, 0);
            }, false);

            function hideURLbar() {
                window.scrollTo(0, 1);
            }
        </script>
    <body>
        <%
            User u = (User) request.getSession().getAttribute("user");
            if (u == null) {

                if (stopServer.serverState) {
                    if (request.getParameter("email") != null) {

                        if (request.getParameter("email").equals("success")) {
        %>
        <!--success msg-->
        <div class="alert alert-success">
            <strong>Success!</strong> Email verification success!
        </div>
        <%
        } else if (request.getParameter("email").equals("Unsuccess")) {
        %>

        <!--Unsuccess msg-->
        <div class="alert alert-danger">
            <strong>Failed!</strong> Email verification failed!
        </div>

        <%
                }
            }

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
                        <p>start browsing worlds biggest custom made softwares and selling your amazing projects with dydox.lk</p>

                        <!--------------------------------LOGIN----------------------------------------->
                        <div class="sub-form" id="login" >
                            <form name="signIn_form" onsubmit="return false">
                                <span class="heading_form">Sign in</span>
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
                                <button class="btn1" onclick="login();">
                                    <span class="fa fa-paper-plane" aria-hidden="true"></span>
                                </button>
                            </form>
                            <br>
                            <a href="#" onClick="$('#login').hide();
                                    $('#sign_up').show()" style="color: blue;font-size: 18px;">Sign Up Here</a>
                        </div>
                        <!--------------------------------LOGIN----------------------------------------->


                        <!--------------------------------SIGN UP----------------------------------------->

                        <div class="sub-form" data-toggle="collapse" id="sign_up" style="display: none;" onsubmit="return false" >
                            <form name="signUp_form">
                                <span class="heading_form">Sign up</span>
                                <br>
                                <br>
                                <input type="email" name="fname" size="30" required="" placeholder="First Name" id="sign_fname" >
                                <br>
                                <br>
                                <input type="email" name="lname" size="30" required="" placeholder="Last Name" id="sign_lname" >
                                <br>
                                <br>
                                <input type="email" name="email" size="30" required="" placeholder="Email" id="sign_email" >
                                <br>
                                <br>
                                <input type="password" name="password" size="30" required="" placeholder="Password" id="sign_password">
                                <br>
                                <br>
                                <input type="password" name="re_password" size="30" required="" placeholder="Re-enter Password" id="sign_re_password" onkeyup="checkPassword();">
                                <br>
                                <br>
                                <br>
                                <h4 id="msg_signUp" style="color: red;"></h4><br>
                                <img id="img_load_1">


                                <button class="btn1" onclick="signUp();">
                                    <span class="fa fa-paper-plane" aria-hidden="true"></span>
                                </button>

                            </form>
                            <br>
                            <a href="#" onClick="$('#sign_up').hide();
                                    $('#login').show()" style="color: blue;font-size: 18px;"> Sign In Here</a>

                        </div>
                        <!--------------------------------SIGN UP----------------------------------------->


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

            function checkPassword() {
                var pass1 = document.getElementById("sign_password").value;
                var pass2 = document.getElementById("sign_re_password").value;

                var msg = document.getElementById("msg_signUp");

                if (pass1 != pass2) {

                    msg.innerHTML = "Password doesn't match!";
                    msg.setAttribute("style", "color:red;");
                    return false;

                } else {
                    msg.innerHTML = "";
                    return true;

                }

            }
            function login() {

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
                                var res = req.responseText.split(",");
                                var txt = res[0];
                                var txt2 = res[1];

                                if (txt == 1) {
                                    window.location = "home.jsp";
                                } else if (txt == 2) {

                                    window.location = "member_area.jsp";
                                } else if (txt == 3) {

                                    window.location = "view_more.jsp?pid=" + txt2;
                                }
                                else if (txt == 0) {
                                    msg2.innerHTML = "Wrong details";


                                } else if (txt == 4) {
                                    window.location = "cart.jsp";
                                } else if (txt == 5) {
                                    window.location = "product_view.jsp";
                                } else if (txt == 6) {
                                    msg2.innerHTML = "Your account is inactive!";
                                } else if (txt == 7) {
                                    window.location = "req_projects.jsp";
                                }
                            }
                        };

                        req.open("post", "log", true)
                        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        req.send("json_str=" + json_str);
                    }
                }
            }

            function signUp() {
                var a = document.forms["signUp_form"]["fname"].value;
                var b = document.forms["signUp_form"]["lname"].value;
                var c = document.forms["signUp_form"]["email"].value;
                var d = document.forms["signUp_form"]["re_password"].value;
                var msg = document.getElementById("msg_signUp");
                if (a == null || a == "", b == null || b == "", c == null || c == "", d == null || d == "") {
                    msg.innerHTML = "Fill the details!";
                } else {

                    var email = document.getElementById("sign_email").value;
                    var atpos = email.indexOf("@");
                    var dotpos = email.lastIndexOf(".");
                    if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                        msg.innerHTML = "Not a valid e-mail address";
                        return false;
                    } else {
                        //right email
                        var fname = document.getElementById("sign_fname").value;
                        var lname = document.getElementById("sign_lname").value;
                        var password = document.getElementById("sign_password").value;


                        if (checkPassword()) {


                            msg.innerHTML = "";


                            var json = {"sendEmail": "true", "email": email, "password": password, "fname": fname, "lname": lname};
                            var json_str = JSON.stringify(json);
                            var req = new XMLHttpRequest();

                            req.onreadystatechange = function() {
                                document.getElementById("img_load_1").src = "images/loading_3.gif";
                                if (req.readyState == 4 && req.status == 200) {
                                    document.getElementById("img_load_1").src = "";

                                    var resp = req.responseText;

                                    if (resp == 1) {

                                        msg.innerHTML = "confirmation email send success!";
                                        msg.setAttribute("style", "color:green;");
                                    }
                                    else {

                                        msg.innerHTML = "confirmation email sending failed!";
                                        msg.setAttribute("style", "color:red;");
                                    }
                                }
                            };

                            req.open("get", "addUser?json_str=" + json_str, true);
                            req.send();

                        }
                    }

                }
            }



        </script>

        <%            } else {
                    response.sendRedirect("server_underC.jsp");
                }
            } else {
                response.sendRedirect("home.jsp");
            }
        %>


    </body>
</html>
