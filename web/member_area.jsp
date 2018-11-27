<%-- 
    Document   : member_area
    Created on : Apr 12, 2018, 11:25:45 PM
    Author     : Sheha
--%>
<%@page import="servelet.stopServer"%>
<%@page import="pojos.SellerPackage"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="pojos.Seller"%>
<%@page import="org.hibernate.Session"%>
<%@page import="pojos.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>dydox.lk</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>dydox.lk</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

        <link rel="stylesheet" href="css/pricing.css" >
        <link rel="stylesheet" href="css/home_style.css" >
        <link rel="stylesheet" href="css/notification.css" >
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script type="text/javascript">

        </script>

    </head>
    <body style="background-color: #F2F2F2;" onload="loadCartCount(), loadNoti()">
        <%
            if (stopServer.serverState) {
        %>
        <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark ">
            <div class="container">
                <a class="navbar-brand" href="index.html">DYDOX.LK</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
                    <ul class="navbar-nav m-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="home.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="product_view.jsp">Products</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="req_projects.jsp">Request Projects</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="member_area.jsp">Member Area</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="aboutUs.jsp">About Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contactUs.jsp">Contact Us</a>
                        </li>


                    </ul>



                    <form class="form-inline my-2 my-lg-0 ">

                        <!---------------------------------------------cart-------------------------------------->
                        <div id="cart">

                        </div>


                        <!---------------------------------------------cart-------------------------------------->

                        <%
                            if (request.getSession().getAttribute("user") != null) {
                                User u = (User) request.getSession().getAttribute("user");

                        %>

                        <!--------------------------------------------------noti------------------------------------->
                        <div id="noti">

                        </div>
                        <!--------------------------------------------------noti------------------------------------->


                        <div class="dropright">
                            <button class="btn btn btn-success btn-sm ml-3 btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="images/profile.png"><span style="text-transform: uppercase;"> <%=u.getFirstName()%></span> Profile
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenu2">
                                <button class="dropdown-item" type="button"><a href="userZone.jsp?tab=tab_a" style="text-decoration: none;">Edit Profile</a></button>
                                <button class="dropdown-item" type="button"><a href="userZone.jsp?tab=tab_b" style="text-decoration: none;">Purchase History</a></button>
                                <button class="dropdown-item" type="button"><a href="userZone.jsp?tab=tab_c" style="text-decoration: none;">Wish List</a></button>
                                <button class="dropdown-item" type="button"><a href="userZone.jsp?tab=tab_d" style="text-decoration: none;">Saved Seller</a></button>
                                <button class="dropdown-item" type="button"><a href="userZone.jsp?tab=tab_f" style="text-decoration: none;">My Request</a></button>

                                <%

                                    Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                                    Criteria c = s.createCriteria(Seller.class);
                                    c.add(Restrictions.eq("user", u));
                                    c.add(Restrictions.eq("status", "approved"));

                                    if (!c.list().isEmpty()) {
                                %>


                                <button class="dropdown-item" type="button"><a href="memberZone.jsp" style="text-decoration: none;">Visit Member Zone</a></button>


                                <%
                                    }
                                %>
                                <div class="dropdown-divider"></div>


                                <button class="dropdown-item" type="button"><a href="logOut?status=user" style="text-decoration: none;">Log Out</a></button>

                            </div>
                        </div>


                        <%   } else {
                        %> 


                        <a class="btn btn-danger btn-sm ml-3" href="index.jsp">Sign In Here</a>

                        <%
                            }
                        %>

                    </form>


                </div>
            </div>
        </nav>

        <section class="jumbotron text-left" >
            <div class="container" >
                <h1 class="jumbotron-heading">How to become a Member?</h1>
                <p class="lead text-muted mb-0">
                    Associate Members shall have all the privileges of full membership except for the right to vote or stand for election and they cannot enter an official team in the biennial Competition. However, Associate Members may be invited to enter up to three “guest” Competitors in the Competition for the purposes of learning about the Competition. The results of the guest Competitors will not be officially recognized nor will medals (Gold, Silver, Bronze, or Medallions for Excellence) be awarded. However, a Best of Nation medal will be awarded if there are at least two Competitors.
                </p>
            </div>
        </section>

        <%
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(SellerPackage.class);

            int f = 1;
            int si = 2;
            int g = 3;
            SellerPackage free = (SellerPackage) s.load(SellerPackage.class, f);
            SellerPackage silver = (SellerPackage) s.load(SellerPackage.class, si);
            SellerPackage gold = (SellerPackage) s.load(SellerPackage.class, g);


        %>

        <div class="demo">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 col-sm-6">
                        <div class="pricingTable">
                            <div class="pricingTable-header">
                                <h3 class="title"><%=free.getName()%></h3>
                                <span class="price-value">
                                    $<%=free.getPrice()%><span class="month">/ month</span>
                                </span>
                            </div>
                            <ul class="pricing-content">
                                <li><%=free.getMaxAddTime()%> Product Publish Times</li>
                                <li><%=free.getValidMonths()%> Month Validation For Each Product</li>
                                <li><%=free.getProfitPercentage()%>% For Dydox.lk</li>
                                <li></li>


                            </ul>
                            <a href="#" class="pricingTable-signup"  type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="Free">Sign Up</a>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="pricingTable orange">
                            <div class="pricingTable-header">
                                <h3 class="title"><%=silver.getName()%></h3>
                                <span class="price-value">
                                    $<%=silver.getPrice()%><span class="month">/ month</span>
                                </span>
                            </div>
                            <ul class="pricing-content">
                                <li><%=silver.getMaxAddTime()%> Product Publish Times</li>
                                <li><%=silver.getValidMonths()%> Month Validation For Each Product</li>
                                <li><%=silver.getProfitPercentage()%>% For Dydox.lk</li>
                                <li></li>
                            </ul>
                            <a href="#" class="pricingTable-signup"  type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="Silver">Sign Up</a>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="pricingTable pink">
                            <div class="pricingTable-header">
                                <h3 class="title"><%=gold.getName()%></h3>
                                <span class="price-value">
                                    $<%=gold.getPrice()%><span class="month">/ month</span>
                                </span>
                            </div>
                            <ul class="pricing-content">
                                <li><%=gold.getMaxAddTime()%> Product Publish Times</li>
                                <li><%=gold.getValidMonths()%> Month Validation For Each Product</li>
                                <li><%=gold.getProfitPercentage()%>% For Dydox.lk</li>
                                <li></li>
                            </ul>
                            <a href="#" class="pricingTable-signup"  type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="Gold">Sign Up</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Member Request Form</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form>
                            <div class="form-group">
                                <%
                                    User un = (User) request.getSession().getAttribute("user");
                                    if (un != null) {
                                        //log in
%>
                                <label for="recipient-name" class="col-form-label">Package</label>
                                <input type="text" class="form-control" id="recipient-package" disabled="">

                                <label for="message-text" class="col-form-label">Email</label>
                                <input type="text" class="form-control" id="recipient-email" value="<%=un.getEmail()%>" disabled="">
                                <hr class="hr">
                                <p class="label-warning">If you want to change email <a href="#">click here</a></p>
                                <div id="mem_req_msg">
                                    <span></span>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-primary" onclick="sendMemReq();">Send message</button>
                        <%
                        } else {
                            //not login

                        %>
                        <br>
                        <br>

                        <div class="alert alert-danger">
                            <span>Please Login First</span>

                        </div>
                    </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <a type="button" class="btn btn-danger" href="savePage?page=member_area.jsp">Login</a>

                    <%                                            }

                    %>


                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                </div>

            </div>
        </div>
    </div>               


    <br>
    <br>
    <br>
    <br>
    <br>
    <!-- Footer -->


    <footer class="text-light">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-lg-4 col-xl-3">
                    <h5>About</h5>
                    <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                    <p class="mb-0">
                        DYDOX.LK is your ultimate solution for selling software online. Our digital commerce platform makes it easy for you to sell online.
                    </p>
                </div>

                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto">
                    <h5>Go to</h5>
                    <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-50">
                    <ul class="list-unstyled">
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="product_view.jsp">Products</a></li>
                        <li><a href="req_projects.jsp">Request</a></li>
                        <li><a href="member_area.jsp">Member Area</a></li>
                        <li><a href="aboutUs.jsp">About Us</a></li>
                        <li><a href="contactUs.jsp">Contact Us</a></li>
                    </ul>
                </div>

                <div class="col-md-3 col-lg-2 col-xl-2 mx-auto">
                    <h5>Social Media</h5>
                    <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-50">
                    <ul class="list-unstyled">
                        <li><a href="">g+</a></li>
                        <li><a href="">Facebook</a></li>
                        <li><a href="">Linkedin</a></li>
                        <li><a href="">Youtube</a></li>
                    </ul>
                </div>

                <div class="col-md-4 col-lg-3 col-xl-3">
                    <h5>Contact</h5>
                    <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                    <ul class="list-unstyled">
                        <li><i class="fa fa-home mr-2"></i> DYDOX.LK</li>
                        <li><i class="fa fa-envelope mr-2"></i> dydox.lk@gmail.com</li>
                        <li><i class="fa fa-phone mr-2"></i>(+94)75 764 7290</li>
                        <li><i class="fa fa-print mr-2"></i>(+94)75 764 7290</li>
                    </ul>
                </div>
                <div class="col-12 copyright mt-3">
                    <p class="float-left">
                        <a href="#">Back to top</a>
                    </p>


                    <p class="text-right text-muted">created with <i class="fa fa-heart"></i> by <a href="https://technogensoftwares.com/"><i> TechnoGen Software</i></a> | <span>v. 1.0</span></p>

                </div>
            </div>
        </div>
    </footer>


    <script src="Bootstrap/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    <script type="text/javascript">
                            $('#exampleModal').on('show.bs.modal', function(event) {
                                var button = $(event.relatedTarget)
                                var recipient = button.data('whatever')
                                var modal = $(this)

                                modal.find('.modal-body  #recipient-package').val(recipient)

                            })
    </script>
    <script type="text/javascript">

        function sendMemReq() {
            var p = document.getElementById("recipient-package").value;
            var email = document.getElementById("recipient-email").value;

            var json = {"package": p, "email": email};
            var json_str = JSON.stringify(json);

            var req = new XMLHttpRequest();

            req.onreadystatechange = function() {

                if (req.readyState == 4 && req.status == 200) {

                    var msg = document.getElementById("mem_req_msg");
                    var resp = req.responseText;

                    if (resp == 1) {
                        //wrong email
                        msg.innerHTML = "wrong email address!";
                        msg.setAttribute("class", "alert alert-danger");
                    } else if (resp == 2) {
                        //wrong package name
                        msg.innerHTML = "wrong package name!";
                        msg.setAttribute("class", "alert alert-danger");
                    } else if (resp == 3) {
                        //alredy seller
                        msg.innerHTML = "you are already seller! use your all facilities";
                        msg.setAttribute("class", "alert alert-info");
                    } else if (resp == 4) {
                        //req sent
                        msg.innerHTML = "your request is still pending";
                        msg.setAttribute("class", "alert alert-danger");
                    } else if (resp == 5) {
                        //req sent
                        msg.innerHTML = "requset send successfully";
                        msg.setAttribute("class", "alert alert-success");
                    }
                    else if (resp == 6) {
                        //req sent
                        msg.innerHTML = "requset send successfully and process to payment";
                        msg.setAttribute("class", "alert alert-success");

                        window.location = "package_payments.jsp";
                    } else if (resp == 7) {
                        //req sent
                        msg.innerHTML = "requset send successfully and process to payment";
                        msg.setAttribute("class", "alert alert-success");

                        window.location = "package_payments.jsp";
                    } else if (resp == 8) {
                        //req sent
                        msg.innerHTML = "your alredy got this package!choose another";
                        msg.setAttribute("class", "alert alert-danger");
                    }

                }
            };

            req.open("get", "sendMemReq?json_str=" + json_str, true);
            req.send();



        }
    </script>
    <script type="text/javascript">

        function loadNoti() {
            var div_main = document.getElementById("noti");
//                div_main.innerHTML = "";

            var div_1 = document.createElement("div");
            div_1.className = "dropdown";

            var btn_1 = document.createElement("button");
            btn_1.className = "btn btn btn-success btn-sm ml-3";
            btn_1.setAttribute("type", "button");
            btn_1.setAttribute("id", "dropdownMenu2");
            btn_1.setAttribute("data-toggle", "dropdown");
            btn_1.setAttribute("aria-haspopup", "true");
            btn_1.setAttribute("aria-expanded", "false");

            var img_1 = document.createElement("img");
            img_1.src = "images/noti_2.png";






            var req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if (req.readyState == 4 && req.status == 200) {
                    var one = req.responseText.split("~-&-~")[0];
                    var two = req.responseText.split("~-&-~")[1];

                    var json_arr = JSON.parse(one);

                    if (one != 0) {

                        var span_1 = document.createElement("span");
                        span_1.className = "badgeAlert";
                        span_1.innerHTML = two;

                        btn_1.appendChild(img_1);
                        btn_1.appendChild(span_1);

                        var div_2 = document.createElement("div");
                        div_2.className = "list-notificacao dropdown-menu";

                        var div_3 = document.createElement("div");

                        var h_1 = document.createElement("h6");
                        h_1.className = "h6";
                        h_1.innerHTML = "&nbsp;Notifications";



                        var hr_1 = document.createElement("hr");
                        hr_1.className = "hr";

                        div_3.appendChild(h_1);
                        div_3.appendChild(hr_1);

                        div_2.appendChild(div_3);
                        div_1.appendChild(btn_1);
                        div_1.appendChild(div_2);

                        for (var i = 0; i < json_arr.length; i++) {
                            var json_obj = json_arr[i];
                            var li_1 = document.createElement("li");
                            li_1.className = "item_notification_" + json_obj.nid;

                            var div_4 = document.createElement("div");
                            div_4.className = "media";

                            var div_5 = document.createElement("div");
                            div_5.className = "media-left";

                            var img_2 = document.createElement("img");
                            img_2.className = "media-object";
//                            img_2.setAttribute("alt", "64x64");
//                            img_2.setAttribute("data-src", "holder.js/64x64");
//                            img_2.src = "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIHZpZXdCb3g9IjAgMCA2NCA2NCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvNjR4NjQKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+PCFbQ0RBVEFbI2hvbGRlcl8xNWZhMWJmZmI3MCB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEwcHQgfSBdXT48L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE1ZmExYmZmYjcwIj48cmVjdCB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIGZpbGw9IiNFRUVFRUUiLz48Zz48dGV4dCB4PSIxMy40Njg3NSIgeT0iMzYuNSI+NjR4NjQ8L3RleHQ+PC9nPjwvZz48L3N2Zz4=";
                            img_2.src = "images/About_64px_1.png";
                            img_2.setAttribute("data-holder-rendered", "true");


                            div_5.appendChild(img_2);

                            var div_6 = document.createElement("div");
                            div_6.className = "media-body";

                            var div_7 = document.createElement("div");
                            div_7.className = "exclusaoNotificacao";

                            var btn_2 = document.createElement("button");
                            btn_2.className = "btn btn-danger btn-xs button_exclusao";
                            btn_2.setAttribute("id", json_obj.nid);
                            btn_2.innerHTML = "X";
                            btn_2.setAttribute("onclick", "updateNotiStatus(" + json_obj.nid + ");");


                            div_7.appendChild(btn_2);

                            var h_2 = document.createElement("h6");
                            h_2.className = "media-heading";
                            h_2.innerHTML = json_obj.header;

                            var p_1 = document.createElement("p");
                            p_1.innerHTML = json_obj.msg;
                            p_1.setAttribute("onclick", "updateNotiStatus(" + json_obj.nid + ");");




                            div_6.appendChild(div_7);
                            div_6.appendChild(h_2);
                            div_6.appendChild(p_1);

                            div_4.appendChild(div_5);
                            div_4.appendChild(div_6);

                            li_1.appendChild(div_4);

                            div_2.appendChild(li_1);







                        }
                        var clear = document.createElement("button");
                        clear.className = "btn btn-info btn-block";
                        clear.innerHTML = "CLEAR ALL";
                        clear.setAttribute("onclick", "updateNotiStatus('all');");
                        div_2.appendChild(clear);

                        div_main.appendChild(div_1);
                    }

                }

            };
            req.open("get", "loadNoti", true);
            req.send();

        }
        function updateNotiStatus(nid) {



            var req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if (req.readyState == 4 && req.status == 200) {
                    if (req.responseText == 1) {

                        loadNoti();
                    }
                }

            };
            req.open("get", "updateNotiStatus?nid=" + nid, true);
            req.send();




        }
        function loadCartCount() {


            var div_main = document.getElementById("cart");

            var req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if (req.readyState == 4 && req.status == 200) {
                    var a = document.createElement("a");
                    a.className = "btn btn-success btn-sm ml-3";
                    a.setAttribute("href", "cart.jsp");
                    var img = document.createElement("img");
                    img.src = "images/cart.png";
                    var span_1 = document.createElement("span");
                    span_1.innerHTML = "&nbsp;Cart&nbsp;";
                    var span_2 = document.createElement("span");
                    span_2.className = "badgeAlert";
                    span_2.innerHTML = req.responseText;
                    a.appendChild(img);
                    a.appendChild(span_1);
                    a.appendChild(span_2);
                    div_main.appendChild(a);


                }

            };
            req.open("get", "loadCartCount", true);
            req.send();
        }
    </script>
    <%            } else {
            response.sendRedirect("server_underC.jsp");
        }

    %>







</body>
</html>
