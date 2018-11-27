<%-- 
    Document   : view_more
    Created on : May 7, 2018, 4:25:00 PM
    Author     : Sheha
--%>
<%@page import="servelet.stopServer"%>
<%@page import="pojos.InvoiceProduct"%>
<%@page import="pojos.InvoiceProductHasItem"%>
<%@page import="pojos.SRate"%>
<%@page import="pojos.PRate"%>
<%@page import="pojos.ProductHasPlatform"%>
<%@page import="pojos.ProductHasSupportOs"%>
<%@page import="pojos.SupportOs"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="pojos.Product"%>
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
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>dydox.lk</title>

        <link rel="stylesheet" href="css/tabs.css" >
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="js/imageZoom.js"></script>
        <link rel="stylesheet" href="css/imageZoom.css" >


        <link rel="stylesheet" href="css/home_style.css" >
        <link rel="stylesheet" href="css/notification.css" >

        <style>
            .checked {
                color: orange;
            }
            .seller_img{

                max-width: 300px;
                max-height: 300px;

            }
        </style>
        <style class="cp-pen-styles">
            html, body {

                font-family: "PT Sans", "Helvetica Neue", "Helvetica", "Roboto", "Arial", sans-serif;
                color: #555f77;
                -webkit-font-smoothing: antialiased;
            }

            input, textarea {
                outline: none;
                border: none;
                display: block;
                margin: 0;
                padding: 0;
                -webkit-font-smoothing: antialiased;
                font-family: "PT Sans", "Helvetica Neue", "Helvetica", "Roboto", "Arial", sans-serif;
                font-size: 1rem;
                color: #555f77;
            }
            input::-webkit-input-placeholder, textarea::-webkit-input-placeholder {
                color: #ced2db;
            }
            input::-moz-placeholder, textarea::-moz-placeholder {
                color: #ced2db;
            }
            input:-moz-placeholder, textarea:-moz-placeholder {
                color: #ced2db;
            }
            input:-ms-input-placeholder, textarea:-ms-input-placeholder {
                color: #ced2db;
            }

            p {
                line-height: 1.3125rem;
            }

            .comments {
                margin: 2.5rem auto 0;
                max-width: 60.75rem;
                padding: 0 1.25rem;
            }

            .comment-wrap {
                margin-bottom: 1.25rem;
                display: table;
                width: 100%;
                min-height: 5.3125rem;
            }

            .photo {
                padding-top: 0.625rem;
                display: table-cell;
                width: 3.5rem;
            }
            .photo .avatar {
                height: 2.25rem;
                width: 2.25rem;
                border-radius: 50%;
                background-size: contain;
            }

            .comment-block {
                padding: 1rem;
                background-color: #fff;
                display: table-cell;
                vertical-align: top;
                border-radius: 0.1875rem;
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.08);
            }
            .comment-block textarea {
                width: 100%;
                resize: none;
            }

            .comment-text {
                margin-bottom: 1.25rem;
            }

            .bottom-comment {
                color: #acb4c2;
                font-size: 0.875rem;
            }

            .comment-date {
                float: left;
            }

            .comment-actions {
                float: right;
            }
            .comment-actions li {
                display: inline;
                margin: -2px;
                cursor: pointer;
            }
            .comment-actions li.complain {
                padding-right: 0.75rem;
                border-right: 1px solid #e1e5eb;
            }
            .comment-actions li.reply {
                padding-left: 0.75rem;
                padding-right: 0.125rem;
            }
            .comment-actions li:hover {
                color: #0095ff;
            }
        </style>
        <script type="text/javascript">
            $(document).ready(function() {
                //If your <ul> has the id "glasscase"
                $('#glasscase').glassCase({'thumbsPosition': 'bottom', 'widthDisplay': 560});
            });







        </script>

    </head>
    <%
        Session s = util.NewHibernateUtil.getSessionFactory().openSession();
        int pid = Integer.parseInt(request.getParameter("pid"));

        Criteria pro = s.createCriteria(Product.class);
        pro.add(Restrictions.eq("idproduct", pid));
        pro.add(Restrictions.eq("status", "active"));

        if (!pro.list().isEmpty()) {


    %>
    <body onload="loadCartCount(), loadComments(<%=pid%>), loadNoti()">
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




        <section class="jumbotron text-left">
            <div class="container">
                <%
                    Product p = (Product) s.load(Product.class, pid);
                    String imgUrl = p.getImg1().replace(request.getServletContext().getRealPath("/"), "");
                    String imgUrl_2 = p.getImg2().replace(request.getServletContext().getRealPath("/"), "");
                    String imgUrl_3 = p.getImg3().replace(request.getServletContext().getRealPath("/"), "");

                %>
                <!--<h2 class="jumbotron-heading"><%=pid%></h2>-->
                <p class="lead text-muted mb-0">
                    <!--Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un peintre anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte...-->
                </p>
            </div>
        </section>




        <div class="container">
            <div id="msg" role="alert">

            </div>
            <div id="msgW" role="alert">

            </div>
            <div class="row">
                <!-- Image -->
                <div class="col-12 col-lg-6">
                    <div class="card bg-light mb-3">
                        <div class="card-header">

                            <h1 class="h3"><%=p.getTitle().toUpperCase()%></h1>

                        </div>

                        <div class="card-body">




                            <div class="">
                                <ul id="glasscase" class="gc-start">
                                    <li><img class="img-fluid" src="<%=imgUrl%>" alt="Text" data-gc-caption="<%=p.getTitle()%>" /></li>
                                    <li><img class="img-fluid" src="<%=imgUrl_2%>" alt="Text" /></li>
                                    <li><img class="img-fluid" src="<%=imgUrl_3%>" alt="Text" /></li>
                                </ul>

                            </div>


                        </div>
                    </div>
                </div>

                <!-- Add to cart -->
                <div class="col-12 col-lg-6 add_to_cart_block">
                    <div class="card bg-light mb-3">

                        <div class="card-body">
                            <br>


                            <p class="h6"><%=p.getSmallDes().toUpperCase()%></p>

                            <h5 class="h3"> 
                                <span class="badge badge-info"><%=p.getSfCategory().getCategoryName()%></span>
                                <span class="badge badge-info"><%=p.getSfLanguage()%></span>
                                <span class="badge badge-info">by <%=p.getSeller().getUser().getFirstName()%> <%=p.getSeller().getUser().getLastName()%></span>
                                <br>
                                <span class="badge badge-secondary"><%=p.getSfType()%></span>
                                <br>
                                <%
                                    Criteria c = s.createCriteria(ProductHasSupportOs.class);
                                    c.add(Restrictions.eq("product", p));
                                    if (!c.list().isEmpty()) {
                                        List<ProductHasSupportOs> os_list = c.list();
                                        for (ProductHasSupportOs phs : os_list) {
                                %>

                                <span class="badge badge-warning"><%=phs.getSupportOs().getName()%></span>

                                <%
                                        }
                                    }
                                %>
                                <br>
                                <%
                                    Criteria c2 = s.createCriteria(ProductHasPlatform.class);
                                    c2.add(Restrictions.eq("product", p));
                                    if (!c2.list().isEmpty()) {
                                        List<ProductHasPlatform> platform_list = c2.list();
                                        for (ProductHasPlatform php : platform_list) {
                                %>

                                <span class="badge badge-dark"><%=php.getSfPlatform().getName()%></span>

                                <%
                                        }
                                    }
                                %>
                                <br>
                                <span class="badge badge-danger"><%=p.getSellLimit()%> Sell</span>
                                <%
                                    if (!p.getSellLimit().equals("oneTime")) {

                                        Criteria c3 = s.createCriteria(InvoiceProductHasItem.class);
                                        c3.add(Restrictions.eq("product", p));

                                        int soldQty = 0;
                                        if (!c3.list().isEmpty()) {
                                            //sold one

                                            List<InvoiceProductHasItem> inv_items = c3.list();
                                            for (InvoiceProductHasItem x : inv_items) {

                                                Criteria c4 = s.createCriteria(InvoiceProduct.class);
                                                c4.add(Restrictions.eq("idinvoiceProduct", x.getInvoiceProduct().getIdinvoiceProduct()));
                                                c4.add(Restrictions.eq("status", "done"));
                                                if (!c4.list().isEmpty()) {
                                                    //product and invoice matched with done payments

                                                    soldQty++;

                                                }

                                            }
                                        }
                                %>
                                <span class="badge badge-success"><%=soldQty%> sold</span>

                                <%
                                    }
                                %>

                            </h5>

                            <h1>
                                <%
                                    Criteria c3 = s.createCriteria(PRate.class);
                                    c3.add(Restrictions.eq("product", p));

                                    double overoll_rate = 0;
                                    int size = 0;
                                    if (!c3.list().isEmpty()) {
                                        double tot_rates = 0;
                                        List<PRate> rates = c3.list();
                                        size = rates.size();
                                        for (PRate pRate : rates) {
                                            tot_rates += pRate.getRate();
                                        }

                                        overoll_rate = (tot_rates / rates.size());
                                    }
                                %>
                            </h1>

                            <h1 class="h1">
                                <span class="h5"> <%=size%> reviews</span>
                                <%
                                    if (Math.round(overoll_rate) == 1) {
                                %>
                                <span class="fa fa-star checked"> </span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span> 
                                <span class="h3">(1/5)<span class="badge badge-warning">good</span></span>

                                <%
                                } else if (Math.round(overoll_rate) == 2) {
                                %>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked "></span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="h3">(2/5)<span class="badge badge-secondary">good+</span></span>
                                <%
                                } else if (Math.round(overoll_rate) == 3) {
                                %>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="h3">(3/5)<span class="badge badge-dark">quality</span></span>
                                <%
                                } else if (Math.round(overoll_rate) == 4) {
                                %>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star "></span>
                                <span class="h3">(4/5)<span class="badge badge-info">quality+</span></span>
                                <%
                                } else if (Math.round(overoll_rate) == 5) {
                                %>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="fa fa-star checked"></span>
                                <span class="h3">(5/5)<span class="badge badge-success">genuine</span></span>
                                <%
                                } else {
                                %>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="fa fa-star "></span>
                                <span class="h3">(0/5)<span class="badge badge-danger">weak</span></span>

                                <%
                                    }


                                %>


                            </h1>

                            <br>
                            <div class="product_rassurance">

                                <p class="price" style="color: #399900;">US $<%=p.getPrice()%></p>
                            </div>
                            <!--<p class="price_discounted">149.90 $</p>-->

                            <br>
                            <br>


                            <button href="" class="btn btn-danger btn-lg btn-block text-uppercase" onclick="addToWishList(<%=p.getIdproduct()%>);">
                                <i class="fa fa-heart"></i> Add To Wishlist
                            </button>
                            <button  class="btn btn-success btn-lg btn-block text-uppercase" onclick="addTOCart(<%=p.getIdproduct()%>)">
                                <i class="fa fa-shopping-cart"></i> Add To Cart
                            </button>
                            <br>
                            <div class="datasheet p-3 mb-2 bg-info text-white">
                                <a href="downloadSF?id=<%=p.getIdproduct()%>&file=demo&file_name=<%=p.getTitle()%>" class="text-white"><i class="fa fa-download"></i> Download Demo</a>
                            </div>


                            <div class="product_rassurance">
                                <ul class="list-inline">
                                    <%
                                        if (p.getReturnAccept() == true) {
                                    %>
                                    <li class="list-inline-item"><img src="images/right.png"><br/>Return Accept</li>

                                    <%
                                    } else {
                                    %>
                                    <li class="list-inline-item"><img src="images/wrong.png"><br/>Return Not Accept</li>

                                    <%
                                        }


                                    %>
                                    <li class="list-inline-item"><i class="fa fa-phone fa-2x"></i><br/><%=p.getSeller().getUser().getMobile()%></li>
                                    <li class="list-inline-item"><img src="images/Paypal-icon.png"><br/>Secure payment</li>


                                </ul>
                            </div>
                            <!--                            <div class="reviews_product p-3 mb-2 ">
                                                            3 reviews
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                            
                                                            (4/5)
                                                            <a class="pull-right" href="#reviews">View all reviews</a>
                                                        </div>-->
                        </div>
                    </div>
                </div>
            </div>




            <div class="col-md-12">



                <div class ="row">
                    <div class="tabbable-panel">

                        <div class="tabbable-line">
                            <ul class="nav nav-tabs ">
                                <li class="active">
                                    <a href="#more" data-toggle="tab">More Details&nbsp;&nbsp;</a>
                                </li>
                                <li>
                                    <a href="#seller" data-toggle="tab">About Seller&nbsp;&nbsp;</a>
                                </li>

                            </ul>
                        </div>
                    </div>


                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="tab-content">
                        <div class="tab-pane active" id="more">



                            <!-- Description -->
                            <div class="col-12">
                                <div class ="card border-info mb-3">
                                    <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-align-justify"></i> Description</div>
                                    <div class="card-body">
                                        <p class="card-text"><%=p.getBriefDes()%></p>

                                    </div>
                                </div>
                                <div class ="card border-success mb-3">
                                    <div class="card-header bg-success text-white text-uppercase"><i class="fa fa-star"></i> Features</div>
                                    <div class="card-body">
                                        <ul>

                                            <%

                                                String[] f = p.getFeatures().toString().split(",");

                                                for (String x : f) {
                                            %>
                                            <li>

                                                <p class="card-text"><%=x%></p>
                                            </li>


                                            <%
                                                }
                                                String v = p.getVideo().replace("https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/");
                                                String link = v.split("&")[0];
//                                                System.out.println(v);
//                                                System.out.println(link);

                                            %>

                                        </ul>
                                    </div>
                                </div>
                                <div class ="card border-info mb-3">
                                    <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-youtube-play"></i> Video</div>
                                    <div class="card-body">

                                        <div class="embed-responsive embed-responsive-16by9">
                                            <iframe class="embed-responsive-item" src="<%=link%>" allowfullscreen></iframe>
                                        </div>



                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="tab-pane" id="seller">

                            <center>

                                <div class="card">
                                    <div class="card-header">
                                        <h3>Seller Informations</h3>        
                                    </div>
                                    <br>
                                    <%

                                        if (p.getSeller().getUser().getImgUrl() == null) {
                                    %>
                                    <img class="seller_img" src="images/blank.png" alt="Card image cap">

                                    <%
                                    } else {
                                        String seller_img = p.getSeller().getUser().getImgUrl().replace(request.getServletContext().getRealPath("/"), "");
                                    %>

                                    <img class="seller_img" src="<%=seller_img%>" alt="Card image cap">
                                    <%

                                        }

                                    %>
                                    <div class="card-body">
                                        <h5  class="card-title" style="font-family: century gothic;font-weight: 12px;font-size: 25px;"><%=p.getSeller().getUser().getFirstName().toUpperCase() + " " + p.getSeller().getUser().getLastName().toUpperCase()%></h5>


                                        <%
                                            Criteria c4 = s.createCriteria(SRate.class);
                                            c4.add(Restrictions.eq("seller", p.getSeller()));

                                            double seller_overoll_rate = 0;
                                            int size2 = 0;
                                            if (!c4.list().isEmpty()) {
                                                double tot_rates = 0;
                                                List<SRate> rates = c4.list();
                                                size2 = rates.size();
                                                for (SRate SRate : rates) {
                                                    tot_rates += SRate.getRate();
                                                }

                                                seller_overoll_rate = (tot_rates / rates.size());
                                            }
                                            System.out.println(seller_overoll_rate);
                                        %>

                                        <h1 class="h1">
                                            <span class="h5"> <%=size2%> reviews</span>
                                            <%
                                                if (Math.round(seller_overoll_rate) == 1) {
                                            %>
                                            <span class="fa fa-star checked"> </span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span> 
                                            <span class="h3">(1/5)<span class="badge badge-warning">good</span></span>

                                            <%
                                            } else if (Math.round(seller_overoll_rate) == 2) {
                                            %>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="h3">(2/5)<span class="badge badge-secondary">good+</span></span>
                                            <%
                                            } else if (Math.round(seller_overoll_rate) == 3) {
                                            %>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="h3">(3/5)<span class="badge badge-dark">quality</span></span>
                                            <%
                                            } else if (Math.round(seller_overoll_rate) == 4) {
                                            %>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star "></span>
                                            <span class="h3">(4/5)<span class="badge badge-info">quality+</span></span>
                                            <%
                                            } else if (Math.round(seller_overoll_rate) == 5) {
                                            %>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="h3">(5/5)<span class="badge badge-success">top rated</span></span>
                                            <%
                                            } else {
                                            %>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="fa fa-star "></span>
                                            <span class="h3">(0/5)<span class="badge badge-danger">weak</span></span>

                                            <%
                                                }


                                            %>


                                        </h1>
                                        <!--<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>-->
                                    </div>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><i class="fa fa-phone"></i> <%=p.getSeller().getUser().getMobile()%></li>
                                        <li class="list-group-item"><i class="fa fa-envelope"></i> <%=p.getSeller().getUser().getEmail()%></li>


                                    </ul>
                                    <div class="card-body">
                                        <!--<a class="btn btn-danger "><i class="fa fa-envelope"></i> Message to Seller</a>-->
                                        <a class="btn btn-danger" onclick="saveSeller(<%=p.getSeller().getIdseller()%>);"><i class="fa fa-heart"></i> Save Seller</a>
                                        <a class="btn btn-warning" href="req_projects.jsp"><i class="fa fa-search"></i> Project Request</a>

                                    </div>
                                    <div id="msgSS" role="alert">

                                    </div>
                                </div>


                            </center>

                        </div>

                    </div>
                </div>

            </div>







            <!-- Reviews -->
            <div class="card">
                <div class="card-body">



                    <div class="col-12" id="reviews">
                        <div class="card border-success mb-3">
                            <div class ="card-header bg-success text-white text-uppercase"><i class="fa fa-comment"></i> Reviews</div>
                            <div class="card-body">
                                <center>

                                    <div>
                                        <h2>
                                            <a onclick="starCal(1);">  <span id="1" class="fa fa-star checked "></span></a>
                                            <a onclick="starCal(2);">  <span id="2" class="fa fa-star "></span></a>
                                            <a onclick="starCal(3);">  <span id="3" class="fa fa-star "></span></a>
                                            <a onclick="starCal(4);">  <span id="4" class="fa fa-star "></span></a>
                                            <a onclick="starCal(5);">  <span id="5" class="fa fa-star "></span></a>

                                            <br>
                                            <a class="btn btn-info" style="color: white;" onclick="addStarRate(<%=p.getSeller().getUser().getIduser()%>,<%=p.getIdproduct()%>);">Add rate for product</a>
                                            <br>
                                            <br>
                                        </h2>
                                        <div id="msg1">

                                        </div>
                                    </div>


                                    <div>
                                        <h2>
                                            <a onclick="starCal(6);">  <span id="6" class="fa fa-star checked "></span></a>
                                            <a onclick="starCal(7);">  <span id="7" class="fa fa-star "></span></a>
                                            <a onclick="starCal(8);">  <span id="8" class="fa fa-star "></span></a>
                                            <a onclick="starCal(9);">  <span id="9" class="fa fa-star "></span></a>
                                            <a onclick="starCal(10);">  <span id="10" class="fa fa-star "></span></a>

                                            <br>
                                            <a class="btn btn-info" style="color: white;" onclick="addStarRateSeller(<%=p.getSeller().getUser().getIduser()%>);">Add rate for seller</a>
                                            <br>
                                            <br>
                                        </h2>
                                        <div id="msg2">

                                        </div>
                                    </div>
                                </center>
                                <div class="comments">

                                    <%
                                        User u = (User) request.getSession().getAttribute("user");
                                        if (u != null) {
                                    %>
                                    <div class="comment-wrap">
                                        <div class="photo">
                                            <%
                                                if (u.getImgUrl() != null) {
                                                    String user_img = u.getImgUrl().replace(request.getServletContext().getRealPath("/"), "");
                                                    System.out.println(user_img);
                                            %>
                                            <div class="avatar" style="background-image: url('<%=user_img%>')"></div>

                                            <%
                                            } else {
                                            %>

                                            <div class="avatar" style="background-image: url('images/blank.png')"></div>

                                            <%
                                                }

                                            %>
                                        </div>

                                        <div class="comment-block">


                                            <textarea name="" id="comment" cols="30" rows="3" placeholder="Add comment..."></textarea>

                                        </div>

                                    </div>
                                    <div id="msg_2">

                                    </div>
                                    <div class="bottom-comment">

                                        <ul class="comment-actions">
                                            <li class="complain"><a onclick="addComment(<%=p.getSeller().getUser().getIduser()%>,<%=p.getIdproduct()%>);">Post</a></li>

                                        </ul>
                                    </div>


                                    <%                                    } else {
                                    %>

                                    <p>Please <a href="savePage?page=view_more.jsp&pid=<%=p.getIdproduct()%>">Sign in</a> to add comments</p>
                                    <%
                                        }
                                    %>

                                    <div id="allComments"> 
                                    </div>
                                    <p id="err"></p>


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


        <script type="text/javascript">
            var starCount = 1;
            var starCountSeller = 1;
            function starCal(id) {

                if (id == 5) {
                    starCount = 5;
                    document.getElementById("1").className = "fa fa-star checked";
                    document.getElementById("2").className = "fa fa-star checked";
                    document.getElementById("3").className = "fa fa-star checked";
                    document.getElementById("4").className = "fa fa-star checked";
                    document.getElementById("5").className = "fa fa-star checked";


                } else if (id == 4) {
                    starCount = 4;
                    document.getElementById("1").className = "fa fa-star checked";
                    document.getElementById("2").className = "fa fa-star checked";
                    document.getElementById("3").className = "fa fa-star checked";
                    document.getElementById("4").className = "fa fa-star checked";
                    document.getElementById("5").className = "fa fa-star ";
                } else if (id == 3) {
                    starCount = 3;
                    document.getElementById("1").className = "fa fa-star checked";
                    document.getElementById("2").className = "fa fa-star checked";
                    document.getElementById("3").className = "fa fa-star checked";
                    document.getElementById("4").className = "fa fa-star ";
                    document.getElementById("5").className = "fa fa-star ";
                } else if (id == 2) {
                    starCount = 2;
                    document.getElementById("1").className = "fa fa-star checked";
                    document.getElementById("2").className = "fa fa-star checked";
                    document.getElementById("3").className = "fa fa-star ";
                    document.getElementById("4").className = "fa fa-star ";
                    document.getElementById("5").className = "fa fa-star ";
                } else if (id == 1) {
                    starCount = 1;
                    document.getElementById("1").className = "fa fa-star checked";
                    document.getElementById("2").className = "fa fa-star ";
                    document.getElementById("3").className = "fa fa-star ";
                    document.getElementById("4").className = "fa fa-star ";
                    document.getElementById("5").className = "fa fa-star ";
                }


                if (id == 10) {
                    starCountSeller = 5;
                    document.getElementById("6").className = "fa fa-star checked";
                    document.getElementById("7").className = "fa fa-star checked";
                    document.getElementById("8").className = "fa fa-star checked";
                    document.getElementById("9").className = "fa fa-star checked";
                    document.getElementById("10").className = "fa fa-star checked";
                } else if (id == 9) {
                    starCountSeller = 4;
                    document.getElementById("6").className = "fa fa-star checked";
                    document.getElementById("7").className = "fa fa-star checked";
                    document.getElementById("8").className = "fa fa-star checked";
                    document.getElementById("9").className = "fa fa-star checked";
                    document.getElementById("10").className = "fa fa-star ";
                } else if (id == 8) {
                    starCountSeller = 3;
                    document.getElementById("6").className = "fa fa-star checked";
                    document.getElementById("7").className = "fa fa-star checked";
                    document.getElementById("8").className = "fa fa-star checked";
                    document.getElementById("9").className = "fa fa-star ";
                    document.getElementById("10").className = "fa fa-star ";
                } else if (id == 7) {
                    starCountSeller = 2;
                    document.getElementById("6").className = "fa fa-star checked";
                    document.getElementById("7").className = "fa fa-star checked";
                    document.getElementById("8").className = "fa fa-star ";
                    document.getElementById("9").className = "fa fa-star ";
                    document.getElementById("10").className = "fa fa-star ";
                } else if (id == 6) {
                    starCountSeller = 1;
                    document.getElementById("6").className = "fa fa-star checked";
                    document.getElementById("7").className = "fa fa-star ";
                    document.getElementById("8").className = "fa fa-star ";
                    document.getElementById("9").className = "fa fa-star ";
                    document.getElementById("10").className = "fa fa-star ";
                }
            }
            function addStarRate(uid, pid) {


                var req = new XMLHttpRequest();
                var msg = document.getElementById("msg1");

                var json = {"rate": starCount, "uid": uid, "pid": pid};
                var json_str = JSON.stringify(json);


                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {

                        if (req.responseText == 1) {

                            msg.innerHTML = "You Rated " + starCount + " Stars!";
                            msg.className = "alert alert-success";
                        } else if (req.responseText == 2) {
                            msg.innerHTML = "Login  <a href='savePage?page=view_more.jsp&pid=<%=p.getIdproduct()%>'>Here</a> First!"
                            msg.className = "alert alert-danger";

                        } else if (req.responseText == 3) {
                            msg.innerHTML = "You can't rate for your product!"
                            msg.className = "alert alert-danger";

                        } else if (req.responseText == 4) {
                            msg.innerHTML = "You alredy rated for this product!"
                            msg.className = "alert alert-danger";

                        }
                    }

                };

                req.open("get", "addStarRate?json_str=" + json_str, true);
                req.send();
            }
            function addStarRateSeller(uid) {


                var req = new XMLHttpRequest();
                var msg = document.getElementById("msg2");

                var json = {"rate": starCountSeller, "uid": uid};
                var json_str = JSON.stringify(json);


                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {
                        if (req.responseText == 1) {

                            msg.innerHTML = "You Rated " + starCountSeller + " Stars!";
                            msg.className = "alert alert-success";
                        } else if (req.responseText == 2) {
                            msg.innerHTML = "Login  <a href='savePage?page=view_more.jsp&pid=<%=p.getIdproduct()%>'>Here</a> First!"
                            msg.className = "alert alert-danger";

                        } else if (req.responseText == 3) {
                            msg.innerHTML = "You can't rate for your profile!"
                            msg.className = "alert alert-danger";

                        } else if (req.responseText == 4) {
                            msg.innerHTML = "You alredy rated for this seller!"
                            msg.className = "alert alert-danger";

                        }
                    }

                };

                req.open("get", "addStarRateSeller?json_str=" + json_str, true);
                req.send();
            }

            function addComment(uid, pid) {

                var req = new XMLHttpRequest();
                var msg = document.getElementById("msg_2");

                var comment = document.getElementById("comment");

                var json = {"comment": comment.value, "uid": uid, "pid": pid};
                var json_str = JSON.stringify(json);

                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {
                        if (req.responseText == 1) {

                            comment.value = "";
                            msg.innerHTML = "posted!"
                            msg.className = "alert alert-success";
                            loadComments(pid);

                        } else if (req.responseText == 0) {
                            msg.innerHTML = "Login <a href='savePage?page=view_more.jsp&pid=<%=p.getIdproduct()%>'>Here</a> First!"
                            msg.className = "alert alert-danger";

                        } else if (req.responseText == 2) {
                            msg.innerHTML = "Write something!"
                            msg.className = "alert alert-danger";
                        } else if (req.responseText == 3) {
                            msg.innerHTML = "Something Wrong.use strings only!"
                            msg.className = "alert alert-danger";
                        }
                    }

                };

                req.open("get", "addComment?json_str=" + json_str, true);
                req.send();


            }
            function loadComments(pid) {

                var div_main = document.getElementById("allComments");
                div_main.innerHTML = "";

                var req = new XMLHttpRequest();

                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {
                        var txt = req.responseText;
                        if (txt == 2) {

                            document.getElementById("err").innerHTML = "No Comments yet!";
                        } else {
                            var json_arr = JSON.parse(req.responseText);

                            for (var i = 0; i < json_arr.length; i++) {
                                var json_obj = json_arr[i];

                                var div_1 = document.createElement("div");
                                div_1.className = "comment-wrap";

                                var div_2 = document.createElement("div");
                                div_2.className = "photo";

                                var div_3 = document.createElement("div");
                                div_3.className = "avatar";
                                div_3.setAttribute("style", "background-image: url(" + json_obj.user_image + ")")

                                div_2.appendChild(div_3);

                                var div_4 = document.createElement("div");
                                div_4.className = "comment-block";

                                var span_1 = document.createElement("span");
                                span_1.className = "badge badge-info";
                                span_1.innerHTML = json_obj.owner;

                                var p_1 = document.createElement("p");
                                p_1.className = "comment-text";
                                p_1.innerHTML = json_obj.comment;

                                var div_5 = document.createElement("div");
                                div_5.className = "bottom-comment";

                                var div_6 = document.createElement("div");
                                div_6.className = "comment-date";
                                div_6.innerHTML = "#" + json_obj.user_name + " " + json_obj.date + " @" + json_obj.time;


                                div_5.appendChild(div_6);
                                if (json_obj.owner == "Owner") {

                                    div_4.appendChild(span_1);
                                }
                                div_4.appendChild(p_1);
                                div_4.appendChild(div_5);

                                div_1.appendChild(div_2);
                                div_1.appendChild(div_4);

                                div_main.appendChild(div_1);


                            }

                        }
                    }
                };
                req.open("get", "loadComments?pid=" + pid, true);
                req.send();


            }
            function addTOCart(pid) {

                var msg = document.getElementById("msg");
                var req = new XMLHttpRequest();

                req.onreadystatechange = function() {

                    if (req.readyState == 4 && req.status == 200) {
                        var txt = req.responseText;

                        if (txt == "1") {
                            msg.className = "alert alert-success";
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "New session cart created and added product! checkout <a href='cart.jsp'>HERE</a>";

                        } else if (txt == "2") {
                            msg.className = "alert alert-success"
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "Product not in session cart added new product!  checkout <a href='cart.jsp'>HERE</a>";
                        } else if (txt == "3") {
                            msg.className = "alert alert-danger alert-block"
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "This product alredy added to your cart!  checkout <a href='cart.jsp'>HERE</a> ";
                        } else if (txt == "4") {
                            msg.className = "alert alert-success"
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "Added to your cart!  checkout <a href='cart.jsp'>HERE</a> ";
                        } else if (txt == "5") {
                            msg.className = "alert alert-success";
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "New DB cart created and added product! checkout <a href='cart.jsp'>HERE</a>";

                        } else if (txt == "6") {
                            msg.className = "alert alert-danger";
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "You can't buy your product!";

                        } else if (txt == "7") {
                            msg.className = "alert alert-danger";
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "You already brought this product! checkout <a href='userZone.jsp?tab=tab_b'>Here</a>";

                        }
                        loadCartCount();
                    }
                }
                ;
                req.open("get", "addToCart?pid=" + pid, true);
                req.send();
            }
            function addToWishList(pid) {

                var msg = document.getElementById("msgW");
                var req = new XMLHttpRequest();

                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {
                        var txt = req.responseText;
                        if (txt == "1") {
                            msg.className = "alert alert-danger";
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "Please Login <a href='savePage?page=view_more.jsp&pid=<%=p.getIdproduct()%>'>Here</a> First";

                        } else if (txt == "3") {
                            msg.className = "alert alert-danger alert-block"
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "This product already added to your Wishlist! View <a href='userZone.jsp?tab=tab_c'>Here</a>";
                        } else if (txt == "4") {
                            msg.className = "alert alert-success"
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "Added to your Wishlist! View <a href='userZone.jsp?tab=tab_c'>Here</a>";
                        } else if (txt == "5") {
                            msg.className = "alert alert-success";
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "New Wishlist created and added product!";

                        } else if (txt == "6") {
                            msg.className = "alert alert-danger";
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "You can't buy your product!";

                        } else if (txt == "7") {
                            msg.className = "alert alert-danger";
                            msg.setAttribute("style", "font-size:18px;");
                            msg.innerHTML = "You already brought this product! checkout <a href='userZone.jsp?tab=tab_b'>Here</a>";

                        }
                    }

                }
                req.open("get", "addToWishlist?pid=" + pid, true);
                req.send();
            }

            function saveSeller(sid) {

                var msg = document.getElementById("msgSS");
                var req = new XMLHttpRequest();

                req.onreadystatechange = function() {

                    if (req.readyState == 4 && req.status == 200) {
                        var txt = req.responseText;
                        if (txt == "0") {
                            msg.className = "alert alert-danger";
                            msg.innerHTML = "Please Login <a href='savePage?page=view_more.jsp&pid=<%=p.getIdproduct()%>'>Here</a> First";

                        } else if (txt == "1") {
                            msg.className = "alert alert-danger"
                            msg.innerHTML = "You can't save your profile! ";
                        } else if (txt == "2") {
                            msg.className = "alert alert-danger"
                            msg.innerHTML = "This seller alredy in your saved seller list! View <a href='userZone.jsp?tab=tab_d'>Here</a>";
                        } else if (txt == "3") {
                            msg.className = "alert alert-success";
                            msg.innerHTML = "Seller added to your saved list! View <a href='userZone.jsp?tab=tab_d'>Here</a>";

                        }
                    }
                };

                req.open("get", "saveSeller?sid=" + sid, true);
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

//                            loadNoti();
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
        <script src="Bootstrap/js/bootstrap.min.js"></script>
        <!--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
        <%            } else {
                response.sendRedirect("server_underC.jsp");
            }

        %>

    </body>
    <%        } else {
            response.sendRedirect("product_view.jsp");
        }
    %>
</html>
