<%-- 
    Document   : product_view
    Created on : May 2, 2018, 9:40:01 PM
    Author     : Sheha
--%>
<%@page import="servelet.stopServer"%>
<%@page import="pojos.SupportOs"%>
<%@page import="pojos.SfPlatform"%>
<%@page import="pojos.PRate"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="pojos.SfCategory"%>
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

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="css/home_style.css" >
        <link rel="stylesheet" href="css/notification.css" >

        <style>
            .checked {
                color: orange;
            }
        </style>
    </head>
    <body onload="loadCartCount(), loadProducts(), loadNoti()">
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

                        <%  Session s = util.NewHibernateUtil.getSessionFactory().openSession();
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
                <h2 class="jumbotron-heading">SEARCH SOFTWARE AS YOUR WISH!</h2>
                <br>
                <!--<p class="lead text-muted mb-0">Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un peintre anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte...</p>-->
                <button class="btn btn-success" type="button" data-toggle="collapse" data-target="#ad" aria-expanded="false" aria-controls="ad" >Advanced Filters</button>
                <br>
                <br>

                <div class="collapse container" id="ad">

                    <div class="card card-body"  style="background-color: #EBEBEB;">
                        <div class="container">
                            <div class="row"> 
                                <div class="col-lg-2 table-bordered">
                                    <h5 class="border-bottom p-1">Software Type</h5>
                                    <div class="ml-3">
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="display"  class="custom-control-input" onclick="loadProducts();" id="advance_single">
                                            <label class="custom-control-label" for="advance_single">Single</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="display"  class="custom-control-input" onclick="loadProducts();" id="advance_multi">
                                            <label class="custom-control-label" for="advance_multi">Multi</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="display"  class="custom-control-input" onclick="loadProducts();" id="advance_cloud">
                                            <label class="custom-control-label" for="advance_cloud">Cloud</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="display"  class="custom-control-input" onclick="loadProducts();" id="advance_all">
                                            <label class="custom-control-label" for="advance_all">All</label>
                                        </div>
                                    </div>

                                    <br>
                                    <h5 class="border-bottom p-1">Categories</h5>
                                    <div class="ml">
                                        <select id="advance_cata" class="custom-select" onchange="loadProducts()">
                                            <option value="all">All</option>
                                            <%
                                                Criteria c5 = s.createCriteria(SfCategory.class);

                                                List<SfCategory> list_sf = c5.list();

                                                if (!c5.list().isEmpty()) {
                                                    for (SfCategory sf : list_sf) {
                                            %>

                                            <option  value="<%=sf.getIdsfCategory()%>"><%=sf.getCategoryName()%></option>


                                            <%
                                                    }
                                                }%>


                                        </select>
                                    </div>

                                    <br>
                                    <br>
                                    <br>
                                </div>
                                <div class="col-lg-3 table-bordered">

                                    <h5 class="border-bottom p-1">Software Platform</h5>
                                    <div class="ml-3">


                                        <%
                                            Criteria c1 = s.createCriteria(SfPlatform.class);
                                            List<SfPlatform> list = c1.list();
                                            for (SfPlatform d : list) {
                                        %>
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="advance_platform" class="custom-control-input" id="<%=d.getIdsfPlatform()%>" value="<%=d.getIdsfPlatform()%>" onclick="loadProducts();">
                                            <label class="custom-control-label" for="<%=d.getIdsfPlatform()%>"><%=d.getName()%></label>
                                        </div>

                                        <%
                                            }

                                        %>

                                    </div>
                                    <br>

                                    <h5 class="border-bottom p-1">Price Range</h5>
                                    <div class="ml">

                                        <div class="form-group">
                                            <input type="number" class="form-control" id="advance_sp" name="" placeholder="From" value="0" required>
                                        </div>
                                        <div class="form-group">
                                            <input type="number" class="form-control" id="advance_ep" name="" placeholder="To" value="s" required onkeyup="loadProducts();">
                                        </div>
                                    </div>

                                </div>

                                <div class="col-lg-2 table-bordered">
                                    <h5 class="border-bottom p-1">Support OS</h5>
                                    <div class="ml-3">
                                        <%                                            Criteria c4 = s.createCriteria(SupportOs.class);
                                            List<SupportOs> list_c = c4.list();
                                            for (SupportOs d : list_c) {
                                        %>
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input" id="<%=d.getIdsupportOs()%>" value="edge" onclick="advancedFilters(0);">
                                            <label class="custom-control-label" for="<%=d.getIdsupportOs()%>"><%=d.getName()%></label>
                                        </div>

                                        <%
                                            }

                                        %>

                                    </div>  
                                    <br>

                                    <h5 class="border-bottom p-1">Language</h5>
                                    <div class="ml">
                                        <select id="advance_langu" class="custom-select" onchange="loadProducts();">
                                            <option value="all">Other</option>
                                            <option value="Afrikanns">Afrikanns</option>
                                            <option value="Albanian">Albanian</option>
                                            <option value="Arabic">Arabic</option>
                                            <option value="Armenian">Armenian</option>
                                            <option value="Basque">Basque</option>
                                            <option value="Bengali">Bengali</option>
                                            <option value="Bulgarian">Bulgarian</option>
                                            <option value="Catalan">Catalan</option>
                                            <option value="Cambodian">Cambodian</option>
                                            <option value="Chinese (Mandarin)">Chinese (Mandarin)</option>
                                            <option value="Croation">Croation</option>
                                            <option value="Czech">Czech</option>
                                            <option value="Danish">Danish</option>
                                            <option value="Dutch">Dutch</option>
                                            <option value="English">English</option>
                                            <option value="Estonian">Estonian</option>
                                            <option value="Fiji">Fiji</option>
                                            <option value="Finnish">Finnish</option>
                                            <option value="French">French</option>
                                            <option value="Georgian">Georgian</option>
                                            <option value="German">German</option>
                                            <option value="Greek">Greek</option>
                                            <option value="Gujarati">Gujarati</option>
                                            <option value="Hebrew">Hebrew</option>
                                            <option value="Hindi">Hindi</option>
                                            <option value="Hungarian">Hungarian</option>
                                            <option value="Icelandic">Icelandic</option>
                                            <option value="Indonesian">Indonesian</option>
                                            <option value="Irish">Irish</option>
                                            <option value="Italian">Italian</option>
                                            <option value="Japanese">Japanese</option>
                                            <option value="Javanese">Javanese</option>
                                            <option value="Korean">Korean</option>
                                            <option value="Latin">Latin</option>
                                            <option value="Latvian">Latvian</option>
                                            <option value="Lithuanian">Lithuanian</option>
                                            <option value="Macedonian">Macedonian</option>
                                            <option value="Malay">Malay</option>
                                            <option value="Malayalam">Malayalam</option>
                                            <option value="Maltese">Maltese</option>
                                            <option value="Maori">Maori</option>
                                            <option value="Marathi">Marathi</option>
                                            <option value="Mongolian">Mongolian</option>
                                            <option value="Nepali">Nepali</option>
                                            <option value="Norwegian">Norwegian</option>
                                            <option value="Persian">Persian</option>
                                            <option value="Polish">Polish</option>
                                            <option value="Portuguese">Portuguese</option>
                                            <option value="Punjabi">Punjabi</option>
                                            <option value="Quechua">Quechua</option>
                                            <option value="Romanian">Romanian</option>
                                            <option value="Russian">Russian</option>
                                            <option value="Samoan">Samoan</option>
                                            <option value="Serbian">Serbian</option>
                                            <option value="Slovak">Slovak</option>
                                            <option value="Slovenian">Slovenian</option>
                                            <option value="Spanish">Spanish</option>
                                            <option value="Swahili">Swahili</option>
                                            <option value="Swedish ">Swedish </option>
                                            <option value="Tamil">Tamil</option>
                                            <option value="Tatar">Tatar</option>
                                            <option value="Telugu">Telugu</option>
                                            <option value="Thai">Thai</option>
                                            <option value="Tibetan">Tibetan</option>
                                            <option value="Tonga">Tonga</option>
                                            <option value="Turkish">Turkish</option>
                                            <option value="Ukranian">Ukranian</option>
                                            <option value="Urdu">Urdu</option>
                                            <option value="Uzbek">Uzbek</option>
                                            <option value="Vietnamese">Vietnamese</option>
                                            <option value="Welsh">Welsh</option>
                                            <option value="Xhosa">Xhosa</option>

                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-3 table-bordered">
                                    <h5 class="border-bottom p-1">Purchase Type</h5>
                                    <div class="ml-3">
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="processor" class="custom-control-input" id="advance_oneTime" onchange="loadProducts();">
                                            <label class="custom-control-label" for="advance_oneTime">One time</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="processor" class="custom-control-input" id="advance_noLimit" onchange="loadProducts();">
                                            <label class="custom-control-label" for="advance_noLimit">Other</label>
                                        </div>

                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="processor" class="custom-control-input" id="advance_allTypes" onchange="loadProducts();">
                                            <label class="custom-control-label" for="advance_allTypes">All</label>
                                        </div>
                                    </div>
                                    <br>
                                    <br>
                                    <br>
                                    <h5 class="border-bottom p-1">Return</h5>
                                    <div class="ml-3">

                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input" id="advance_ra"  onclick="loadProducts()">
                                            <label class="custom-control-label" for="advance_ra">Return Accept</label>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-lg-2 table-bordered">
                                    <h5 class="border-bottom p-1">Star Ratings</h5>
                                    <div class="ml-3">

                                        <select id="primarycam" class="custom-select">
                                            <option value="All">1</option>
                                            <option value="24">2</option>
                                            <option value="12">3</option>
                                            <option value="15">4</option>
                                            <option value="15">5</option>
                                        </select>

                                    </div>
                                    <br>
                                    <br>
                                    <br>
                                    <h5 class="border-bottom p-1">Seller Type</h5>
                                    <div class="ml-3">

                                        <select id="primarycam" class="custom-select">
                                            <option value="All">All</option>
                                            <option value="24">My Saved Sellers</option>
                                            <option value="12">Top Rated Sellers</option>

                                        </select>

                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>



            </div>
        </section>

        <div class="container">

            <div class="row">
                <div class="col">
                    <div class="card">
                        <div class="card-header">


                            <div class="input-group">

                                <input type="text" class="form-control" aria-label="..." placeholder="Search software.." id="searchSoftware" onkeyup="loadProducts();">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" onclick="loadProducts();">
                                        <span class="fa fa-search" aria-hidden="true">

                                        </span>
                                    </button>
                                </span>
                            </div>

                        </div>



                    </div>

                </div>

            </div>

        </div>
        <br>
        <br>


        <div class="container">
            <div id="msg" role="alert">

            </div>
            <div id="msgW" role="alert">

            </div>
            <div class="row">
                <div class="col-12 col-sm-3">
                    <div class="card bg-light mb-3 fixed-left">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                        <ul class="list-group category_block">

                            <li class="list-group-item" style="cursor: pointer;" value="all" id="cata"><a onclick="assign('all');">All Categories</a></li>

                            <%                                Criteria c = s.createCriteria(SfCategory.class);

                                List<SfCategory> sf_list = c.list();

                                if (!c.list().isEmpty()) {
                                    for (SfCategory sf : sf_list) {
                            %>

                            <li class="list-group-item" style="cursor: pointer;" value="<%=sf.getIdsfCategory()%>" id="cata"><a onclick="assign(<%=sf.getIdsfCategory()%>);"><%=sf.getCategoryName().toUpperCase()%></a></li>

                            <%

                                    }
                                }
                            %>

                        </ul>
                    </div>


                    <div class="card bg-light mb-3">
                        <div class="card-header bg-success text-white text-uppercase">Last product</div>
                        <%
                            Criteria c2 = s.createCriteria(Product.class);
                            c2.add(Restrictions.eq("status", "active"));
                            c2.setMaxResults(1);
                            c2.addOrder(Order.desc("idproduct"));
                            if (c2.list().isEmpty()) {
                            } else {

                                Product p = (Product) c2.uniqueResult();
                                String imgUrl = p.getImg1().replace(request.getServletContext().getRealPath("/"), "");
                        %>
                        <div class="card-body">
                            <img class="img-fluid" src="<%=imgUrl%>" />
                            <h5>
                                <span class="badge badge-success">$<%=p.getPrice()%></span>
                                <span class="badge badge-info"><%=p.getSfCategory().getCategoryName()%></span>
                            </h5>
                            <h5 class="card-title">

                                <a href="view_more.jsp?pid=<%= p.getIdproduct()%>"><%=p.getTitle()%></a>
                            </h5>

                            <div id="rate">
                                <%
                                    Criteria c3 = s.createCriteria(PRate.class);
                                    c3.add(Restrictions.eq("product", p));

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
                            <p class="card-text"><%=p.getSmallDes()%></p>

                            <div class="row">

                                <button href="#" class="btn btn-info btn-block" onclick="view_more(<%= p.getIdproduct()%>)">View more <img src="images/viewmore.png"></button>
                                <button href="#" class="btn btn-success btn-block" onclick="addTOCart(<%=p.getIdproduct()%>)" >Add to cart <img src="images/cart.png"></button>
                                <button href="#" class="btn btn-danger btn-block" onclick="addToWishList(<%=p.getIdproduct()%>);">Add to Wishlist<img src="images/Heart Health_25px.png"></button>
                            </div>
                        </div>
                        <% }%>

                    </div>
                </div>
                <div class="col">
                    <div class="row">
                        <div class="card">



                            <div class="card-header bg-primary text-white text-uppercase">
                                <i class="fa fa-laptop"></i> Product List
                            </div>
                            <br>
                            <div id="all_products" class="row">


                            </div>

                            <nav aria-label="...">
                                <ul class="pagination">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" tabindex="-1">Previous</a>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>

                                    <li class="page-item active">
                                        <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Next</a>
                                    </li>
                                </ul>
                            </nav>



                        </div>
                    </div>
                </div>

            </div>
        </div>





        <div id="test_msg"></div>





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

                                    var id = "all";
                                    function assign(idd) {
                                        id = idd;
                                        loadProducts();
                                    }
                                    function loadProducts() {

                                        var divmain = document.getElementById("all_products");


                                        var advance_cata = document.getElementById("advance_cata").value;

                                        var advance_single = document.getElementById("advance_single").checked;
                                        var advance_multi = document.getElementById("advance_multi").checked;
                                        var advance_cloud = document.getElementById("advance_cloud").checked;
                                        var advance_all = document.getElementById("advance_all").checked;

                                        var sf_type = 'all';
                                        if (advance_single) {
                                            sf_type = "single";
                                        } else if (advance_multi) {
                                            sf_type = "multi";
                                        } else if (advance_cloud) {
                                            sf_type = "cloud";
                                        } else if (advance_all) {
                                            sf_type = "all";
                                        }

                                        var array_platform = []
                                        var checkboxes_1 = document.querySelectorAll('input[type=checkbox][name=advance_platform]:checked')

                                        for (var i = 0; i < checkboxes_1.length; i++) {
                                            array_platform.push(checkboxes_1[i].value)
                                        }

                                        var advance_oneTime = document.getElementById("advance_oneTime").checked;
                                        var advance_noLimit = document.getElementById("advance_noLimit").checked;
                                        var advance_allTypes = document.getElementById("advance_allTypes").checked;

                                        var sellTime = "all";
                                        if (advance_oneTime) {
                                            sellTime = "oneTime";
                                        } else if (advance_noLimit) {
                                            sellTime = "noLimit";
                                        } else if (advance_allTypes) {
                                            sellTime = "all";
                                        }

                                        var advance_sp = document.getElementById("advance_sp").value;
                                        var advance_ep = document.getElementById("advance_ep").value;

                                        var advance_langu = document.getElementById("advance_langu").value;


                                        var advance_ra = document.getElementById("advance_ra").checked;


                                        var searchSoftware = document.getElementById("searchSoftware").value;



                                        divmain.innerHTML = "";

                                        var json = {"cata_id": advance_cata, "cata": id, "sf_type": sf_type, "platform": array_platform, "sellTime": sellTime, "sp": advance_sp, "ep": advance_ep, "langu": advance_langu, "ra": advance_ra, "searchBar": searchSoftware};
                                        var json_str = JSON.stringify(json);
                                        var req = new XMLHttpRequest();
                                        req.onreadystatechange = function() {


                                            if (req.readyState == 4 && req.status == 200) {
                                                var json_arr = JSON.parse(req.responseText);
                                                if (req.responseText != 0) {


                                                    for (var i = 0; i < json_arr.length; i++) {
                                                        var json_obj = json_arr[i];
                                                        var div_1 = document.createElement("div");
                                                        div_1.className = "col-12 col-md-6 col-lg-4";
                                                        var div_2 = document.createElement("div");
                                                        div_2.className = "card";
                                                        var img = document.createElement("img");
                                                        img.src = json_obj.image;
                                                        img.className = "card-img-top";
//                                                        img.setAttribute("style", "display:block;height:auto;max-width:100%;width:auto;max-height:100%;")
                                                        img.setAttribute("style", "max-height:200px;max-width:260px;min-height:200px;min-width:260px;")
                                                        var div_3 = document.createElement("div");
                                                        div_3.className = "card-body";
                                                        var h4 = document.createElement("h4");
                                                        h4.className = "card-title";
                                                        var a_1 = document.createElement("a");
                                                        a_1.setAttribute("href", "view_more.jsp?pid=" + json_obj.pid);
                                                        a_1.setAttribute("title", "View Product");
                                                        a_1.innerHTML = json_obj.title;
                                                        var p_1 = document.createElement("p");
                                                        p_1.className = "card-text";
                                                        p_1.innerHTML = json_obj.small_des;
                                                        var div_4 = document.createElement("div");
                                                        div_4.className = "row";
                                                        //-------------------------btn1-------------
                                                        var div_5 = document.createElement("div");
                                                        div_5.className = "col";
                                                        var img_btn_1 = document.createElement("img");
                                                        img_btn_1.src = "images/viewmore.png";
                                                        var a_2 = document.createElement("button");
                                                        a_2.className = "btn btn-primary btn-block";
                                                        a_2.innerHTML = "View More &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                                                        a_2.setAttribute("onclick", "view_more(" + json_obj.pid + ");");
                                                        //-------------------------btn1-------------


                                                        //-------------------------btn2-------------
                                                        var div_6 = document.createElement("div");
                                                        div_6.className = "col";
                                                        var img_btn_2 = document.createElement("img");
                                                        img_btn_2.src = "images/cart.png";
                                                        var a_3 = document.createElement("button");
                                                        a_3.className = "btn btn-success btn-block";
                                                        a_3.innerHTML = "Add To Cart &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                                                        a_3.setAttribute("onclick", "addTOCart(" + json_obj.pid + "); ")
                                                        //-------------------------btn2-------------



                                                        //-------------------------btn3-------------
                                                        var div_7 = document.createElement("div");
                                                        div_7.className = "col";
                                                        var img_btn_3 = document.createElement("img");
                                                        img_btn_3.src = "images/Heart Health_25px.png";
                                                        var a_4 = document.createElement("button");
                                                        a_4.className = "btn btn-danger btn-block";
                                                        a_4.innerHTML = "Add To Wishlist &nbsp; ";
                                                        a_4.setAttribute("onclick", "addToWishList(" + json_obj.pid + "); ")
                                                        //-------------------------btn3-------------


                                                        //------badges-------------------------------
                                                        var h5 = document.createElement("h5");
                                                        var span_1 = document.createElement("span");
                                                        span_1.innerHTML = "$" + json_obj.price;
                                                        span_1.className = "badge badge-success";
                                                        var span_2 = document.createElement("span");
                                                        span_2.innerHTML = "by " + json_obj.seller;
                                                        span_2.className = "badge badge-info";
                                                        var span_3 = document.createElement("span");
                                                        span_3.innerHTML = json_obj.cata;
                                                        span_3.className = "badge badge-dark";
                                                        var span_4 = document.createElement("span");
                                                        span_4.innerHTML = json_obj.sold_qty + " sold";
                                                        span_4.className = "badge badge-warning";
                                                        var span_5 = document.createElement("span");
                                                        span_5.innerHTML = json_obj.p_type + " sell";
                                                        span_5.className = "badge badge-danger";
                                                        //------badges-------------------------------


                                                        //------rateings------------------------------
                                                        var h4_1 = document.createElement("h6");
                                                        var div_8 = document.createElement("div");
                                                        //     div_8.className = "col";
                                                        var star_1 = document.createElement("span");
                                                        var star_2 = document.createElement("span");
                                                        var star_3 = document.createElement("span");
                                                        var star_4 = document.createElement("span");
                                                        var star_5 = document.createElement("span");
                                                        var overoll_rate = json_obj.overoll_rate;
                                                        if (overoll_rate == 1) {
                                                            star_1.className = "fa fa-star checked";
                                                        }
                                                        else if (overoll_rate == 2) {
                                                            star_1.className = "fa fa-star checked";
                                                            star_2.className = "fa fa-star checked";
                                                            star_3.className = "fa fa-star ";
                                                            star_4.className = "fa fa-star ";
                                                            star_5.className = "fa fa-star ";
                                                        }
                                                        else if (overoll_rate == 3) {
                                                            star_1.className = "fa fa-star checked";
                                                            star_2.className = "fa fa-star checked";
                                                            star_3.className = "fa fa-star checked";
                                                            star_4.className = "fa fa-star ";
                                                            star_5.className = "fa fa-star ";
                                                        }
                                                        else if (overoll_rate == 4) {
                                                            star_1.className = "fa fa-star checked";
                                                            star_2.className = "fa fa-star checked";
                                                            star_3.className = "fa fa-star checked";
                                                            star_4.className = "fa fa-star checked";
                                                            star_5.className = "fa fa-star ";
                                                        }
                                                        else if (overoll_rate == 5) {
                                                            star_1.className = "fa fa-star checked";
                                                            star_2.className = "fa fa-star checked";
                                                            star_3.className = "fa fa-star checked";
                                                            star_4.className = "fa fa-star checked";
                                                            star_5.className = "fa fa-star checked";
                                                        } else {

                                                            star_1.className = "fa fa-star ";
                                                            star_2.className = "fa fa-star ";
                                                            star_3.className = "fa fa-star ";
                                                            star_4.className = "fa fa-star ";
                                                            star_5.className = "fa fa-star ";
                                                        }





                                                        //------rateings------------------------------
                                                        a_2.appendChild(img_btn_1);
                                                        a_3.appendChild(img_btn_2);
                                                        a_4.appendChild(img_btn_3);
                                                        //                                                                    div_5.appendChild(a_2);
                                                        //                                                                    div_6.appendChild(a_3);
                                                        //                                                                    div_7.appendChild(a_4);


                                                        div_8.appendChild(star_1);
                                                        div_8.appendChild(star_2);
                                                        div_8.appendChild(star_3);
                                                        div_8.appendChild(star_4);
                                                        div_8.appendChild(star_5);
                                                        div_8.innerHTML += "&nbsp;&nbsp;";
                                                        if (json_obj.p_type != "oneTime") {

                                                            div_8.appendChild(span_4);
                                                        }
                                                        div_2.appendChild(img);
                                                        h4.appendChild(a_1);
                                                        div_3.appendChild(h5);
                                                        div_3.appendChild(h4);
                                                        div_3.appendChild(div_8);
                                                        div_3.appendChild(p_1);
                                                        h5.appendChild(span_3);
                                                        h5.innerHTML += "&nbsp;";
                                                        h5.appendChild(span_1);
                                                        h5.innerHTML += "&nbsp;";
                                                        h5.appendChild(span_2);
                                                        h5.innerHTML += "&nbsp;";
                                                        h5.appendChild(span_5);
                                                        div_4.appendChild(a_2);
                                                        div_4.appendChild(a_3);
                                                        div_4.appendChild(a_4);
                                                        div_3.appendChild(div_4);
                                                        div_2.appendChild(div_3);
                                                        div_1.appendChild(div_2);
                                                        divmain.appendChild(div_1);
                                                    }
                                                } else {

                                                    var div_card = document.createElement("div");
                                                    div_card.className = "card-body";
                                                    var h2 = document.createElement("h2");
                                                    h2.className = "h2";
                                                    h2.innerHTML = "No Restults Found!";
                                                    var p = document.createElement("p");
                                                    p.className = "p";
                                                    p.innerHTML = "la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un peintre anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte...";
                                                    div_card.appendChild(h2);
                                                    div_card.appendChild(p);
                                                    divmain.appendChild(div_card);
                                                }
                                            }

                                        }
                                        ;
                                        req.open("get", "loadProducts?json_str=" + json_str, true);
                                        req.send();
                                    }

                                    function view_more(id) {

                                        window.location = "view_more.jsp?pid=" + id;
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
                                                    msg.innerHTML = "Please Login <a href='savePage?page=product_view.jsp&pid=1'>Here</a> First";

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
        <%            } else {
                response.sendRedirect("server_underC.jsp");
            }

        %>



    </body>
</html>
