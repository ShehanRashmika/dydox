<%-- 
    Document   : userZone
    Created on : Jun 5, 2018, 2:47:18 PM
    Author     : Sheha
--%>

<%@page import="pojos.ReqProject"%>
<%@page import="servelet.stopServer"%>
<%@page import="pojos.Seller"%>
<%@page import="pojos.SRate"%>
<%@page import="pojos.SavedSeller"%>
<%@page import="pojos.Disandaddon"%>
<%@page import="pojos.InvoiceProductHasItem"%>
<%@page import="pojos.InvoiceProduct"%>
<%@page import="pojos.PRate"%>
<%@page import="pojos.WishList"%>
<%@page import="java.util.List"%>
<%@page import="pojos.WishListHasItem"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="pojos.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>dydox.lk</title>

        <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css"/>
        <link href="themes/explorer-fa/theme.css" media="all" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <!--<script src="js/plugins/sortable.js" type="text/javascript"></script>-->
        <script src="js/fileinput.js" type="text/javascript"></script>
        <!--<script src="js/locales/fr.js" type="text/javascript"></script>-->
        <!--<script src="js/locales/es.js" type="text/javascript"></script>-->
        <script src="themes/explorer-fa/theme.js" type="text/javascript"></script>
        <script src="themes/fa/theme.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" type="text/javascript"></script>
        <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" type="text/javascript"></script>-->




        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

        <link rel="stylesheet" href="css/tabs_1.css" >
        <link rel="stylesheet" href="css/tabs.css" >
        <link rel="stylesheet" href="css/home_style.css" >
        <link rel="stylesheet" href="css/notification.css" >
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">

        <script type="text/javascript">

            function excluirItemNotificacao(e) {
                $('#item_notification_' + e.id).remove()
            }

        </script>
        <style>


            .tabs_1 li a{
                text-decoration: none;

            }
            #tab_a  a{
                font-size:15px;
                font-family:OpenSans,sans-serif;
                font-weight:400;
                color:#fff;
                padding:20px;
                text-decoration:  none;



            }

            #tab_a li{
                background-color:#343A40;
                margin-right:2px;
                text-align:center;
                height:50px;
                width:100px;
                padding-top:25px;
                -webkit-border-radius:3px;
                border-radius:9px;
            }

            #tab_a li.active{
                background-color:#218838;
            }

            .tabs_1 li{
                background-color:#343A40;
                margin-top:2px;
                text-align:center;
                height:110px;
                width:200px;
                padding-top:45px;
                -webkit-border-radius:9px;
                border-radius:19px;
            }





            .upload-button {
                padding: 2px;
                border: 1px solid black;
                border-radius: 5px;
                /*display: block;*/
                margin: auto;

            }

            .profile-pic {
                max-width: 200px;
                max-height: 200px;
                display: block;
            }

            .file-upload {
                display: none;
            }

            .photo {
                padding-top: 0.425rem;
                display: table-cell;
                width: 3.5rem;
            }
            .photo .avatar {
                height: 4.25rem;
                width: 4.25rem;
                border-radius: 20%;
                background-size: cover;
            }
            .checked {
                color: orange;
            }
        </style>

    </head>
    <body onload="loadCartCount(), loadNoti()">
        <%
            if (stopServer.serverState) {
        %>

        <script type="text/javascript">
            window.onload = function() {
                loadCartCount();
                loadNoti();
                var url = document.location.toString();
                if (url.match('tab=')) {

                    $('#navMain a[href="#' + url.split('tab=')[1] + '"]').tab('show');
                    document.getElementById("tab_a_hover").className = "";
                    document.getElementById("tab_b_hover").className = "";
                    document.getElementById("tab_c_hover").className = "";
                    document.getElementById("tab_d_hover").className = "";
                    document.getElementById("tab_e_hover").className = "";
                    document.getElementById("tab_f_hover").className = "";
                    document.getElementById("tab_g_hover").className = "";
                    document.getElementById(url.split('tab=')[1] + "_hover").className = "active";

                }

                //Change hash for page-reload
                $('#navMain a[href="#' + url.split('#')[1] + '"]').on('shown', function(e) {
                    window.location.hash = e.target.hash;
                });
            }
        </script>
        <%
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            User u = (User) request.getSession().getAttribute("user");
            if (u != null) {


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



                    <form class="form-inline my-2 my-lg-0 " onsubmit="return false">


                        <!---------------------------------------------cart-------------------------------------->
                        <div id="cart">

                        </div>


                        <!---------------------------------------------cart-------------------------------------->
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

                                    Criteria mZone = s.createCriteria(Seller.class);
                                    mZone.add(Restrictions.eq("user", u));
                                    mZone.add(Restrictions.eq("status", "approved"));

                                    if (!mZone.list().isEmpty()) {
                                %>


                                <button class="dropdown-item" type="button"><a href="memberZone.jsp" style="text-decoration: none;">Visit Member Zone</a></button>

                                <%
                                    }
                                %>
                                <div class="dropdown-divider"></div>


                                <button class="dropdown-item" type="button"><a href="logOut?status=user" style="text-decoration: none;">Log Out</a></button>

                            </div>
                        </div>

                    </form>

                </div>
            </div>
        </nav>







        <div class="tabs_1">
            <div class="container">
                <div class="card">

                    <div class="card-header">User Area</div>
                    <div class="row">

                        <div class="col-sm-2">
                            <ul class="nav nav-pills nav-stacked flex-column" id="navMain">

                                <li  id="tab_a_hover" class="active"><a href="#tab_a" data-toggle="pill" >EDIT PROFILE</a></li>
                                <li id="tab_b_hover"><a href="#tab_b" data-toggle="pill" style="font-size: 11.6px;">PURCHASE HISTORY</a></li>
                                <li id="tab_c_hover"><a href="#tab_c" data-toggle="pill">WISH LIST</a></li>
                                <li id="tab_d_hover"><a href="#tab_d" data-toggle="pill">SAVED SELLERS</a></li>
                                <li id="tab_f_hover"><a href="#tab_f" data-toggle="pill">MY REQUESTS</a></li>
                                <li id="tab_e_hover"><a href="#tab_e" data-toggle="pill">MY INVOICES</a></li>
                                <li id="tab_g_hover"><a href="#tab_g" data-toggle="pill">EDIT</a></li>

                            </ul>
                        </div>

                        <div class="col-lg">
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab_a">



                                    <div class="col-md-12">

                                        <div class="tabbable-panel">

                                            <div class="tabbable-line">
                                                <ul class="nav nav-tabs ">
                                                    <li class="active">
                                                        <a href="#tab_default_1" data-toggle="tab">General</a>
                                                    </li>
                                                    <li>
                                                        <a href="#tab_default_2" data-toggle="tab">Security</a>
                                                    </li>

                                                </ul>
                                                <div class="tab-content">
                                                    <div class="tab-pane active" id="tab_default_1">

                                                        <div class="form-area" >  
                                                            <form name="userDetailsForm" onsubmit="return false">


                                                                <%
                                                                    Criteria c = s.createCriteria(User.class);
                                                                    c.add(Restrictions.eq("iduser", u.getIduser()));
                                                                    User user = (User) c.uniqueResult();

                                                                    String fname = "";
                                                                    String lname = "";
                                                                    String street = "";
                                                                    String zip = "";
                                                                    String city = "";
                                                                    String country = "";
                                                                    String mobile = "";
                                                                    String user_img = "images/avatar_pro.png";
                                                                    if (user.getFirstName() != null) {
                                                                        fname = u.getFirstName();
                                                                    }

                                                                    if (user.getLastName() != null) {
                                                                        lname = u.getLastName();
                                                                    }
                                                                    if (user.getStreet() != null) {
                                                                        street = u.getStreet();
                                                                    }
                                                                    if (user.getZip() != null) {
                                                                        zip = u.getZip();
                                                                    }
                                                                    if (user.getCity() != null) {
                                                                        city = u.getCity();
                                                                    }
                                                                    if (user.getCountry() != null) {
                                                                        country = u.getCountry();
                                                                    }
                                                                    if (user.getMobile() != null) {
                                                                        mobile = u.getMobile();
                                                                    }
                                                                    if (user.getImgUrl() != null) {

                                                                        user_img = u.getImgUrl().replace(request.getServletContext().getRealPath("/"), "");
                                                                        System.out.println(user_img);
                                                                    }

                                                                    Transaction t = s.beginTransaction();
                                                                    t.commit();

                                                                %>
                                                                <center>

                                                                    <img class="profile-pic" src="<%=user_img%>" />
                                                                    <br>
                                                                    <div class="btn btn-warning" id="upload-button">Upload Image</div>
                                                                    <input class="file-upload" id="u_img" type="file" accept="image/*"/>
                                                                </center>
                                                                <br>


                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="fname" name="f_name" placeholder="First Name" value="<%=fname%>" >
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="lname" name="l_name" placeholder="Last Name" value="<%=lname%>" >
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="street" name="s_treet" placeholder="Street" value="<%=street%>" >
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="zip" name="z_ip" placeholder="Zip Code" value="<%=zip%>" >
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="city" name="c_ity" placeholder="City" value="<%=city%>" >
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="country" name="c_ountry" placeholder="Country" value="<%=country%>" >
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="mobile" name="m_obile" placeholder="Mobile" value="<%=mobile%>" >
                                                                </div>

                                                                <button class="btn btn-info"  onclick="updateUserDetails(<%=u.getIduser()%>);">Update My Profile</button>
                                                                <br>
                                                                <br>
                                                                <div id="msgUForm" role="alert">

                                                                </div>
                                                            </form>
                                                        </div>

                                                    </div>




                                                    <div class="tab-pane" id="tab_default_2">

                                                        <form name="form_2">




                                                            <div class="form-group">
                                                                <input type="password" class="form-control" id="currentP" name="c_password" placeholder="Current Password" required>
                                                            </div>
                                                            <input type="button" class="btn btn-info " value="Change Password" onclick="changePassword();">

                                                            <hr>
                                                            <div id="msgPass" role="alert">

                                                            </div>
                                                            <div id="hiddenTxt">

                                                            </div>





                                                        </form>
                                                    </div>



                                                </div>



                                            </div>
                                        </div>
                                    </div>


                                </div>


                                <div class="tab-pane" id="tab_b">


                                    <h3>&nbsp;&nbsp;&nbsp;&nbsp;PURCHASE HISTORY</h3>
                                    <table class="table table-striped table-responsive table-hover table-condensed">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">INV</th>
                                                <th scope="col">DATE</th>
                                                <th scope="col">ADDITIONAL</th>
                                                <th scope="col">DISCOUNT</th>
                                                <th scope="col">PRODUCT</th>
                                                <th scope="col">GRAND TOTAL</th>
                                                <th scope="col">DOWNLOAD</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%

                                                Criteria c6 = s.createCriteria(InvoiceProduct.class);
                                                c6.add(Restrictions.eq("user", u));
                                                c6.add(Restrictions.eq("status", "done"));
                                                if (!c6.list().isEmpty()) {
                                                    //user has invoice

                                                    List<InvoiceProduct> inv = c6.list();
                                                    for (InvoiceProduct i : inv) {

                                                        Criteria c7 = s.createCriteria(InvoiceProductHasItem.class);
                                                        c7.add(Restrictions.eq("invoiceProduct", i));

                                                        if (!c7.list().isEmpty()) {

                                                            List<InvoiceProductHasItem> inv_items = c7.list();

                                                            for (InvoiceProductHasItem p : inv_items) {
                                                                String imgUrl = p.getProduct().getImg1().replace(request.getServletContext().getRealPath("/"), "");

                                                                Criteria c8 = s.createCriteria(Disandaddon.class);
                                                                c8.add(Restrictions.eq("product", p.getProduct()));
                                                                Disandaddon disAddon = null;
                                                                if (!c8.list().isEmpty()) {

                                                                    disAddon = (Disandaddon) c8.uniqueResult();

                                                                }

                                                                double product_total = p.getProduct().getPrice() + disAddon.getAddon() - disAddon.getDiscount();
                                            %>

                                            <tr>
                                                <th scope="row">
                                                    <span class="h6"><%=p.getProduct().getTitle()%></span>
                                        <div class="photo"> <div class="avatar" style="background-image: url(<%=imgUrl%>)" ></div> </div>



                                        </th> 
                                        <td><br><%=i.getIdinvoiceProduct()%></td>    
                                        <td><br><%=i.getDate()%></td>    
                                        <td><br>$<%=disAddon.getAddon()%></td>    
                                        <td><br>$<%=disAddon.getDiscount()%></td>    
                                        <td><br>$<%=p.getProduct().getPrice()%></td>    
                                        <td><br>$<%=product_total%></td>    
                                        <td><br>
                                            <button class="btn  btn-info" data-toggle="modal" data-target="#<%=p.getProduct().getIdproduct()%>"><i class="fa fa-download"></i> Download</button>

                                        </td>

                                        <!-- Modal purchase-->
                                        <div class="modal fade" id="<%=p.getProduct().getIdproduct()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">Downloads</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <center>
                                                            <h5 style="color: greenyellow;"><b><%=p.getProduct().getTitle()%></b></h5>
                                                            <br>
                                                            <h6>Software Original Version</h6>
                                                            <button class="btn btn-sm btn-info"> <a class="a" href="downloadSF?id=<%=p.getProduct().getIdproduct()%>&file=original&file_name=<%=p.getProduct().getTitle()%>">Download Original</a></button>

                                                            <hr>
                                                            <h6>Software Demo Version</h6>
                                                            <button class="btn btn-sm btn-info"> <a class="a" href="downloadSF?id=<%=p.getProduct().getIdproduct()%>&file=demo&file_name=<%=p.getProduct().getTitle()%>">Download Demo</a></button>

                                                            <hr>
                                                            <h6>Software Requirements Specification</h6>
                                                            <button class="btn btn-sm btn-info"> <a class="a" href="downloadSF?id=<%=p.getProduct().getIdproduct()%>&file=srs&file_name=<%=p.getProduct().getTitle()%>">Download SRS</a></button>


                                                        </center>

                                                    </div>
                                                    <div class="modal-footer">

                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        </tr>

                                        <%

                                                        }
                                                    }
                                                }

                                            }


                                        %>
                                        </tbody>
                                    </table>


                                </div>
                                <div class="tab-pane" id="tab_c">
                                    <h3>&nbsp;&nbsp;&nbsp;&nbsp;WISH LIST</h3>


                                    <%                                                Criteria c4 = s.createCriteria(WishList.class);
                                        c4.add(Restrictions.eq("user", u));

                                        Criteria c5 = s.createCriteria(WishListHasItem.class);
                                        c5.add(Restrictions.eq("wishList", (WishList) c4.uniqueResult()));

                                        if (!c5.list().isEmpty()) {
                                    %>
                                    <table class="table table-striped  table-hover  table-condensed">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">TITLE</th>
                                                <th scope="col">PRICE</th>
                                                <th scope="col">TYPE</th>
                                                <th scope="col">RATE</th>
                                                <th scope="col">SELLER</th>
                                                <th scope="col">VIEW MORE</th>
                                                <th scope="col">REMOVE</th>
                                            </tr>
                                        </thead>
                                        <tbody>


                                            <%
                                                List<WishListHasItem> items = c5.list();
                                                for (WishListHasItem w : items) {
                                                    String imgUrl = w.getProduct().getImg1().replace(request.getServletContext().getRealPath("/"), "");
                                            %>
                                            <tr>
                                                <th scope="row">
                                        <div class="photo"> <div class="avatar" style="background-image: url(<%=imgUrl%>)" ></div> </div>
                                        </th>
                                        <td><%=w.getProduct().getTitle()%></td>
                                        <td>$<%=w.getProduct().getPrice()%></td>
                                        <td><%=w.getProduct().getSellLimit()%></td>
                                        <td>

                                            <!--rate-->
                                            <div id="rate">
                                                <%
                                                    Criteria c3 = s.createCriteria(PRate.class);
                                                    c3.add(Restrictions.eq("product", w.getProduct()));

                                                    double overoll_rate = 0;
                                                    if (!c3.list().isEmpty()) {

                                                        List<PRate> rates = c3.list();
                                                        double rate = 0;
                                                        for (PRate r : rates) {
                                                            rate += r.getRate();

                                                        }
                                                        overoll_rate = (rate) / rates.size();
                                                        System.out.println(Math.round(overoll_rate) + "ooo");

                                                    }
                                                    int O_rate = (int) Math.round(overoll_rate);
                                                    switch (O_rate) {
                                                        case 1:
                                                %>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star "></span>
                                                <span class="fa fa-star "></span>
                                                <span class="fa fa-star"></span>
                                                <span class="fa fa-star"></span>
                                                <%
                                                        break;
                                                    case 2:
                                                %>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star "></span>
                                                <span class="fa fa-star"></span>
                                                <span class="fa fa-star"></span>
                                                <%
                                                        break;
                                                    case 3:
                                                %>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star"></span>
                                                <span class="fa fa-star"></span>
                                                <%
                                                        break;
                                                    case 4:
                                                %>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star"></span>
                                                <%
                                                        break;
                                                    case 5:
                                                %>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <%
                                                        break;
                                                    case 0:
                                                %>
                                                <span class="fa fa-star "></span>
                                                <span class="fa fa-star "></span>
                                                <span class="fa fa-star "></span>
                                                <span class="fa fa-star"></span>
                                                <span class="fa fa-star"></span>
                                                <%
                                                            break;

                                                    }
                                                %>



                                            </div>

                                        </td>
                                        <td><%=w.getProduct().getSeller().getUser().getFirstName()%> <%=w.getProduct().getSeller().getUser().getLastName()%></td>
                                        <td><button class="btn btn-info" onclick="gotoView(<%=w.getProduct().getIdproduct()%>)">View</button></td>
                                        <td>

                                            <button type="button"  class="btn btn-sm btn-danger" onclick="removeWishListItem(<%=w.getProduct().getIdproduct()%>);"><i class="fa fa-trash"></i></button>

                                        </td>


                                        <!--                                        <td>
                                            <button class="btn btn-sm btn-danger" data-toggle="modal" data-target="#<%=w.getProduct().getIdproduct()%>"><i class="fa fa-trash"></i></button>

                                        </td>



                                         Modal wish
                                        <div class="modal fade" id="<%=w.getProduct().getIdproduct()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">Remove Item</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-primary" onclick="removeWishListItem(<%=w.getProduct().getIdproduct()%>)">Remove</button>
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>-->

                                        </tr>
                                        <%
                                            }

                                        } else {
                                        %>
                                        <center>

                                            <h6>No Products Yet!</h6>
                                        </center>
                                        <%
                                            }

                                        %>


                                        </tbody>
                                    </table>

                                </div>

                                <div class="tab-pane" id="tab_d">
                                    <h3>&nbsp;&nbsp;&nbsp;&nbsp;SAVED SELLERS</h3>

                                    <%                                                Criteria c9 = s.createCriteria(SavedSeller.class);
                                        c9.add(Restrictions.eq("user", u));

                                        if (!c9.list().isEmpty()) {
                                    %>

                                    <table class="table table-striped table-hover table-responsive ">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">NAME</th>
                                                <th scope="col">RATE</th>
                                                <th scope="col">MOBILE</th>
                                                <th scope="col">EMAIL</th>
                                                <th scope="col">COUNTRY</th>
                                                <th scope="col">STATUS</th>
                                                <th scope="col">REMOVE</th>
                                            </tr>
                                        </thead>
                                        <tbody>  

                                            <%
                                                List<SavedSeller> sList = c9.list();

                                                for (SavedSeller k : sList) {
                                                    String imgUrlSeller = k.getSeller().getUser().getImgUrl().replace(request.getServletContext().getRealPath("/"), "");

                                            %>

                                            <tr>
                                                <td scope="row">
                                                    <div class="photo"> <div class="avatar" style="background-image: url(<%=imgUrlSeller%>)" ></div> </div>
                                                </td>
                                                <td><%=k.getSeller().getUser().getFirstName()%> <%=k.getSeller().getUser().getLastName()%></td>
                                                <td>

                                                    <%
                                                        Criteria c10 = s.createCriteria(SRate.class);
                                                        c10.add(Restrictions.eq("seller", k.getSeller()));

                                                        double seller_overoll_rate = 0;
                                                        int size2 = 0;
                                                        if (!c10.list().isEmpty()) {
                                                            double tot_rates = 0;
                                                            List<SRate> rates = c10.list();
                                                            size2 = rates.size();
                                                            for (SRate SRate : rates) {
                                                                tot_rates += SRate.getRate();
                                                            }

                                                            seller_overoll_rate = (tot_rates / rates.size());
                                                        }
                                                        System.out.println(seller_overoll_rate);
                                                    %>




                                                    <%
                                                        if (Math.round(seller_overoll_rate) == 1) {
                                                    %>
                                                    <span class="fa fa-star checked"> </span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span> 


                                                    <%
                                                    } else if (Math.round(seller_overoll_rate) == 2) {
                                                    %>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked "></span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>

                                                    <%
                                                    } else if (Math.round(seller_overoll_rate) == 3) {
                                                    %>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>

                                                    <%
                                                    } else if (Math.round(seller_overoll_rate) == 4) {
                                                    %>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star "></span>

                                                    <%
                                                    } else if (Math.round(seller_overoll_rate) == 5) {
                                                    %>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>
                                                    <span class="fa fa-star checked"></span>

                                                    <%
                                                    } else {
                                                    %>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>
                                                    <span class="fa fa-star "></span>


                                                    <%
                                                        }


                                                    %>


                                                </td>
                                                <td><%=k.getSeller().getUser().getMobile()%></td>
                                                <td><%=k.getSeller().getUser().getEmail()%></td>
                                                <td><%=k.getSeller().getUser().getCountry()%></td>

                                                <%
                                                    if (k.getSeller().getUser().getType().equals("online")) {
                                                %>

                                                <td style="color: green;"><%=k.getSeller().getUser().getType()%></td>
                                                <%
                                                } else {
                                                %>
                                                <td style="color: red;"><%=k.getSeller().getUser().getType()%></td>

                                                <%
                                                    }
                                                %>
                                                <td>

                                                    <button type="button"  class="btn btn-sm btn-danger" onclick="removeSavedSeller(<%=k.getSeller().getIdseller()%>);"><i class="fa fa-trash"></i></button>

                                                </td>

                                                <!--                                                <td class="text-right">
                                                                                                    <button class="btn btn-sm btn-danger" data-toggle="modal" data-target="#<%=k.getSeller().getIdseller()%>"><i class="fa fa-trash"></i></button>
                                                                                                </td>
                                                
                                                                                                 Modal seller
                                                                                        <div class="modal fade" id="<%=k.getSeller().getIdseller()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                            <div class="modal-dialog" role="document">
                                                                                                <div class="modal-content">
                                                                                                    <div class="modal-header">
                                                                                                        <h5 class="modal-title" id="exampleModalLabel">Remove Item</h5>
                                                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                                            <span aria-hidden="true">&times;</span>
                                                                                                        </button>
                                                                                                    </div>
                                                                                                    <div class="modal-body">
                                                                                                        Are you sure?
                                                                                                    </div>
                                                                                                    <div class="modal-footer">
                                                                                                        <button type="button" class="btn btn-primary" onclick="removeSavedSeller(<%=k.getSeller().getIdseller()%>);">Remove</button>
                                                                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>-->

                                            </tr>
                                            <%
                                                }

                                            } else {
                                            %>
                                        <center>

                                            <h6>No Saved Sellers Yet!</h6>
                                        </center>
                                        <%
                                            }


                                        %>

                                        </tbody>
                                    </table>

                                </div>


                                <div class="tab-pane" id="tab_f">
                                    <h3>&nbsp;&nbsp;&nbsp;&nbsp;MY REQUEST PROJECTS</h3>

                                    <table class="table table-striped  table-hover  table-condensed">
                                        <thead>
                                            <tr>

                                                <th scope="col">TITLE</th>
                                                <th scope="col">DATE</th>
                                                <th scope="col">PLATFORM</th>
                                                <th scope="col">CATEGORY</th>

                                                <th scope="col">WISH PRICE</th>

                                            </tr>
                                        </thead>
                                        <tbody>


                                            <%                                                Criteria c2 = s.createCriteria(ReqProject.class);
                                                c2.add(Restrictions.eq("user", u));
                                                if (!c2.list().isEmpty()) {
                                                    List<ReqProject> q = c2.list();

                                                    for (ReqProject k : q) {
                                            %>
                                            <tr>
                                                <td><%=k.getTitle()%></td>
                                                <td><%=k.getDate().toString()%></td>
                                                <td><%=k.getSfPlatform()%></td>
                                                <td><%=k.getSfCategory().getCategoryName()%></td>

                                                <td><%=k.getWishPrice()%></td>
                                            </tr>

                                            <%
                                                    }
                                                }
                                            %>



                                        </tbody>
                                    </table>

                                </div>


                                <div class="tab-pane" id="tab_e">
                                    <h3>&nbsp;&nbsp;&nbsp;&nbsp;MY INVOICES</h3>

                                    <table class="table table-striped  table-hover  table-condensed">
                                        <thead>
                                            <tr>

                                                <th scope="col">INV ID</th>
                                                <th scope="col">DATE</th>
                                                <th scope="col">TIME</th>
                                                <th scope="col">SUB TOTAL</th>
                                                <th scope="col">ADDITIONAL</th>
                                                <th scope="col">DISCOUNT</th>
                                                <th scope="col">TOTAL</th>

                                            </tr>
                                        </thead>
                                        <tbody>


                                            <%
                                                Criteria c3 = s.createCriteria(InvoiceProduct.class);
                                                c3.add(Restrictions.eq("user", u));
                                                if (!c3.list().isEmpty()) {
                                                    List<InvoiceProduct> q = c3.list();

                                                    for (InvoiceProduct k : q) {
                                            %>
                                            <tr>
                                                <td><%=k.getIdinvoiceProduct()%></td>
                                                <td><%=k.getDate().toString()%></td>
                                                <td><%=k.getTime().toString()%></td>
                                                <td><%=k.getSubTot()%></td>
                                                <td><%=k.getAddonTot()%></td>
                                                <td><%=k.getDisTot()%></td>
                                                <td><%=k.getTotal()%></td>
                                            </tr>

                                            <%
                                                    }
                                                }
                                            %>



                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>







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



                                                        function  updateUserDetails(uid) {


                                                            var msg2 = document.getElementById("msgUForm");



                                                            var fname = document.getElementById("fname").value;
                                                            var lname = document.getElementById("lname").value;
                                                            var street = document.getElementById("street").value;
                                                            var zip = document.getElementById("zip").value;
                                                            var city = document.getElementById("city").value;
                                                            var country = document.getElementById("country").value;
                                                            var mobile = document.getElementById("mobile").value;
                                                            var file = document.getElementById("u_img");

                                                            var form = new FormData();


                                                            var all_files = file.files;
                                                            form.append("file", all_files[0]);

                                                            var json = {"uid": uid, "fname": fname, "lname": lname, "street": street, "zip": zip, "city": city, "country": country, "mobile": mobile};
                                                            var json_str = JSON.stringify(json);
                                                            var req = new XMLHttpRequest();

                                                            req.onreadystatechange = function() {
                                                                if (req.readyState == 4 && req.status == 200) {
                                                                    var txt = req.responseText;
                                                                    if (txt == 1) {
                                                                        msg2.innerHTML = "Updated!";
                                                                        msg2.className = "alert alert-success";

                                                                    } else if (txt == 0) {
                                                                        msg2.innerHTML = "Something wrong!"
                                                                        msg2.className = "alert alert-danger";
                                                                    }
                                                                }

                                                            }
                                                            req.open("post", "updateUserDetails?json_str=" + json_str, true);
                                                            req.send(form);
                                                        }
                                                        function changePassword() {

                                                            var msg = document.getElementById("msgPass");
                                                            var cp = document.getElementById("currentP").value;
                                                            var div_main = document.getElementById("hiddenTxt");
                                                            div_main.innerHTML = "";
                                                            var json = {"cp": cp};
                                                            var json_str = JSON.stringify(json);

                                                            var req = new XMLHttpRequest();

                                                            req.onreadystatechange = function() {

                                                                var txt = req.responseText;
                                                                if (txt == 0) {

                                                                    msg.innerHTML = "Enter the password!"
                                                                    msg.className = "alert alert-danger";

                                                                } else if (txt == 1) {

                                                                    msg.innerHTML = "Password and user doesn't match!"
                                                                    msg.className = "alert alert-danger";

                                                                } else if (txt == 2) {

                                                                    msg.innerHTML = "Password ok!";
                                                                    msg.className = "alert alert-success";

                                                                    var div1 = document.createElement("div");
                                                                    div1.className = "form-group";

                                                                    var p1 = document.createElement("input");
                                                                    p1.className = "form-control";
                                                                    p1.setAttribute("placeholder", "Enter new password");
                                                                    p1.setAttribute("id", "newP");
                                                                    p1.setAttribute("type", "password");

                                                                    var br = document.createElement("br");
                                                                    var br2 = document.createElement("br");

                                                                    var p2 = document.createElement("input");
                                                                    p2.className = "form-control";
                                                                    p2.setAttribute("placeholder", "Enter password agin");
                                                                    p2.setAttribute("id", "againP");
                                                                    p2.setAttribute("type", "password");

                                                                    var btn = document.createElement("input");
                                                                    btn.className = "btn btn-info";
                                                                    btn.setAttribute("type", "button");
                                                                    btn.setAttribute("value", "Update Password");
                                                                    btn.setAttribute("onclick", "updatePassword();");

                                                                    div1.appendChild(p1);
                                                                    div1.appendChild(br);
                                                                    div1.appendChild(p2);
                                                                    div1.appendChild(br2);
                                                                    div1.appendChild(btn);

                                                                    div_main.appendChild(div1);


                                                                }
                                                            };

                                                            req.open("post", "checkPassword", true);
                                                            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                                            req.send("json_str=" + json_str);


                                                        }

                                                        function updatePassword() {

                                                            var pass1 = document.getElementById("newP").value;
                                                            var pass2 = document.getElementById("againP").value;

                                                            var msg = document.getElementById("msgPass");

                                                            if (pass1 != pass2) {

                                                                msg.innerHTML = "Password doesn't match!";
                                                                msg.className = "alert alert-danger";


                                                            } else {
                                                                msg.innerHTML = "Wait....";

                                                                var json = {"pass1": pass1, "pass2": pass2};
                                                                var json_str = JSON.stringify(json);


                                                                var req = new XMLHttpRequest();
                                                                req.onreadystatechange = function() {
                                                                    var txt = req.responseText;
                                                                    if (txt == 0) {
                                                                        msg.innerHTML = "Fill the details!";
                                                                        msg.className = "alert alert-danger";

                                                                    } else if (txt == 1) {
                                                                        msg.innerHTML = "Passwords doesn't match!"
                                                                        msg.className = "alert alert-danger";
                                                                    } else if (txt == 2) {
                                                                        msg.innerHTML = "Password Updated!";
                                                                        msg.className = "alert alert-success";
                                                                    }
                                                                };
                                                                req.open("post", "updatePassword", true);
                                                                req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                                                req.send("json_str=" + json_str);

                                                            }
                                                        }
                                                        function  gotoView(pid) {

                                                            window.location = "view_more.jsp?pid=" + pid;
                                                        }
                                                        function removeWishListItem(pid) {


                                                            var req = new XMLHttpRequest();

                                                            req.onreadystatechange = function() {


                                                                if (req.readyState == 4 && req.status == 200) {

                                                                    window.location = "userZone.jsp?tab=tab_c";

                                                                }


                                                            };

                                                            req.open("get", "removeWishListItem?pid=" + pid, true);
                                                            req.send();

                                                        }
                                                        function removeSavedSeller(sid) {

                                                            var req = new XMLHttpRequest();

                                                            req.onreadystatechange = function() {


                                                                if (req.readyState == 4 && req.status == 200) {

                                                                    window.location = "userZone.jsp?tab=tab_d";

                                                                }


                                                            };

                                                            req.open("get", "removeSavedSeller?sid=" + sid, true);
                                                            req.send();
                                                        }

        </script>

        <script type="text/javascript">

            function loadNoti() {
                var div_main = document.getElementById("noti");
                div_main.innerHTML = "";

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
//                                img_2.setAttribute("alt", "64x64");
//                                img_2.setAttribute("data-src", "holder.js/64x64");
//                                img_2.src = "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIHZpZXdCb3g9IjAgMCA2NCA2NCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvNjR4NjQKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+PCFbQ0RBVEFbI2hvbGRlcl8xNWZhMWJmZmI3MCB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEwcHQgfSBdXT48L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE1ZmExYmZmYjcwIj48cmVjdCB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIGZpbGw9IiNFRUVFRUUiLz48Zz48dGV4dCB4PSIxMy40Njg3NSIgeT0iMzYuNSI+NjR4NjQ8L3RleHQ+PC9nPjwvZz48L3N2Zz4=";
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
                div_main.innerHTML = "";

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

                        a.appendChild(img);
                        a.appendChild(span_1);

                        span_2.innerHTML = req.responseText;

                        a.appendChild(span_2);
                        div_main.appendChild(a);


                    }

                };
                req.open("get", "loadCartCount", true);
                req.send();
            }
        </script>
        <script type="text/javascript">
            $(document).ready(function() {


                var readURL = function(input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();

                        reader.onload = function(e) {
                            $('.profile-pic').attr('src', e.target.result);
                        }

                        reader.readAsDataURL(input.files[0]);
                    }
                }


                $(".file-upload").on('change', function() {
                    readURL(this);
                });

                $("#upload-button").on('click', function() {
                    $(".file-upload").click();
                });
            });
        </script>

        <%    } else {
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("server_underC.jsp");
            }

        %>








    </body>
</html>
