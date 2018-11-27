<%-- 
    Document   : memberZone
    Created on : Apr 17, 2018, 11:21:31 AM
    Author     : Sheha
--%>
<%@page import="pojos.Admin"%>
<%@page import="pojos.ReqProject"%>
<%@page import="servelet.stopServer"%>
<%@page import="pojos.Disandaddon"%>
<%@page import="pojos.PRate"%>
<%@page import="pojos.InvoiceProduct"%>
<%@page import="pojos.InvoiceProductHasItem"%>
<%@page import="pojos.SellerHasPackage"%>
<%@page import="pojos.Product"%>
<%@page import="pojos.SupportOs"%>
<%@page import="pojos.SfPlatform"%>
<%@page import="java.util.List"%>
<%@page import="pojos.SfCategory"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="pojos.Seller"%>
<%@page import="org.hibernate.Session"%>
<%@page import="pojos.User"%>
<%@page import="pojos.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!------ Include the above in your HEAD tag ---------->


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

    <body onload="loadCartCount(), loadCata(), loadNoti()">

        <%
            if (stopServer.serverState) {

                if (request.getSession().getAttribute("user") != null) {
                    User u = (User) request.getSession().getAttribute("user");
                    Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                    Criteria c = s.createCriteria(Seller.class);
                    c.add(Restrictions.eq("user", u));
                    c.add(Restrictions.eq("status", "approved"));

                    if (!c.list().isEmpty()) {

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

                                <button class="dropdown-item" type="button"><a href="memberZone.jsp" style="text-decoration: none;">Visit Member Zone</a></button>


                                <div class="dropdown-divider"></div>


                                <button class="dropdown-item" type="button"><a href="logOut?status=user" style="text-decoration: none;">Log Out</a></button>

                            </div>
                        </div>

                    </form>

                </div>
            </div>
        </nav>


        <div class="tabs_1" >
            <div class="container">
                <div class="card" >

                    <div class="card-header">Member Area</div>
                    <div class="row">

                        <div class="col-sm-2">
                            <ul class="nav nav-pills nav-stacked flex-column">

                                <li  class="active"><a href="#tab_b" data-toggle="pill" >MY DASHBOARD</a></li>
                                <li><a href="#tab_a" data-toggle="pill">ADD PRODUCTS</a></li>
                                <li><a href="#tab_c" data-toggle="pill">ALL PRODUCTS</a></li>
                                <li><a href="#tab_d" data-toggle="pill">MY CUSTOMERS</a></li>
                                <li><a href="#tab_e" data-toggle="pill" style="font-size: 12px;">PROJECT REQUEST</a></li>
                                <li><a href="#tab_f" data-toggle="pill">CONTACT ADMIN</a></li>

                            </ul>
                        </div>

                        <div class="col-lg">
                            <div class="tab-content">
                                <div class="tab-pane " id="tab_a">



                                    <div class="col-md-12">

                                        <div class="tabbable-panel">

                                            <div class="tabbable-line">
                                                <ul class="nav nav-tabs ">
                                                    <li class="active">
                                                        <a href="#tab_default_1" data-toggle="tab">General</a>
                                                    </li>
                                                    <li>
                                                        <a href="#tab_default_2" data-toggle="tab">Images</a>
                                                    </li>
                                                    <li>
                                                        <a href="#tab_default_3" data-toggle="tab">Zip</a>
                                                    </li>
                                                </ul>
                                                <div class="tab-content">
                                                    <div class="tab-pane active" id="tab_default_1">

                                                        <div class="form-area">  
                                                            <form role="form" name="form_1">
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="title" name="sf_title" placeholder="Software Title" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" id="small_des" name="sf_small_des" placeholder="Small Description" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <textarea class="form-control" type="textarea" id="brief_des" name="sf_brief_des" placeholder="Brief Description" maxlength="4000" rows="3.8"></textarea>
                                                                    <span class="help-block"><p id="characterLeft" class="help-block ">You have reached the limit</p></span>                    
                                                                </div>
                                                                <div class="input-group">
                                                                    <select class="custom-select" id="soft_cata" name="cata">
                                                                        <!--loadCata-->
                                                                    </select>
                                                                    <div class="input-group-append">
                                                                        <button class="btn btn-secondary" type="button" data-toggle="modal" data-target="#exampleModal"  >Add New</button>
                                                                    </div>
                                                                </div>
                                                                <hr>

                                                                <div class="dropdown">
                                                                    <select class="custom-select" id="languages" name="langu">
                                                                        <option value="0">Select Software Language</option>
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
                                                                        <option value="Sinhala">Sinhala</option>
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
                                                                        <option value="other">Other</option>
                                                                    </select>

                                                                </div>




                                                                <hr>


                                                                <div id="sf_platform_main">
                                                                    <label class="label-info">Software Platform &nbsp;&nbsp;&nbsp;</label>

                                                                    <%
                                                                        Criteria c2 = s.createCriteria(SfPlatform.class);

                                                                        List<SfPlatform> sf_p_list = c2.list();

                                                                        for (SfPlatform sfP : sf_p_list) {
                                                                    %>
                                                                    <div class="custom-control custom-control-inline custom-checkbox my-1 mr-sm-2 ">
                                                                        <input type="checkbox" class="custom-control-input" id="<%=sfP.getIdsfPlatform()%>" name="platform" value="<%=sfP.getIdsfPlatform()%>">
                                                                        <label class="custom-control-label" for="<%=sfP.getIdsfPlatform()%>"><%=sfP.getName()%></label>

                                                                    </div>


                                                                    <%
                                                                        }

                                                                    %>


                                                                </div>


                                                                <hr>


                                                                <label class="label-info">Software Type &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                                <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                                    <input type="radio" class="custom-control-input" id="single" name="1" checked>
                                                                    <label class="custom-control-label" for="single">Single</label>
                                                                </div>
                                                                <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                                    <input type="radio" class="custom-control-input" id="multi"  name="1">
                                                                    <label class="custom-control-label" for="multi">Multi</label>
                                                                </div>
                                                                <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                                    <input type="radio" class="custom-control-input" id="cloud"  name="1">
                                                                    <label class="custom-control-label" for="cloud">Cloud</label>
                                                                </div>

                                                                <hr>

                                                                <div id="sf_os_main">

                                                                    <label class="label-info">Support OS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                                    <%                                                                        Criteria c3 = s.createCriteria(SupportOs.class);

                                                                        List<SupportOs> so_list = c3.list();

                                                                        for (SupportOs os : so_list) {
                                                                    %>
                                                                    <div class="custom-control custom-control-inline custom-checkbox my-1 mr-sm-2 ">
                                                                        <input type="checkbox" class="custom-control-input" id="<%=os.getIdsupportOs()%>" name="os" value="<%=os.getIdsupportOs()%>">
                                                                        <label class="custom-control-label" for="<%=os.getIdsupportOs()%>"><%=os.getName()%></label>

                                                                    </div>
                                                                    <%
                                                                        }

                                                                    %>




                                                                </div>

                                                            </form>
                                                        </div>

                                                    </div>

                                                    <!--model-->
                                                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel">Add New Category</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <form name="add_new_cataForm">

                                                                        <div class="form-group">
                                                                            <label for="name_cata" class="col-form-label">New Category Name</label>
                                                                            <input type="text" class="form-control" id="id_name_cata" name="name_cata" placeholder="Type Category Name">
                                                                            <p class="label-warning"><strong>Note:</strong> please use only letters.</p>
                                                                        </div>
                                                                        <div id="add_cata_msg">
                                                                            <span></span>
                                                                        </div>

                                                                    </form>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-primary" onclick="addNewCata();">Add New</button>
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="tab-pane" id="tab_default_2">

                                                        <form name="form_2">


                                                            <div class="file-loading">
                                                                <input  class="file" type="file" multiple data-min-file-count="3"  multiple data-preview-file-type="any" id="file_images" accept="image/*"  >
                                                            </div>

                                                            <hr>

                                                            <div class="form-group">
                                                                <input type="text" class="form-control" id="sf_videoLink" name="video" placeholder="Youtube video link" required>
                                                            </div>

                                                            <hr>

                                                            <div class="form-group">
                                                                <textarea class="form-control" type="textarea" placeholder="Features of your software" maxlength="400" rows="2.5" id="features"></textarea>
                                                                <span class="help-block"><p id="characterLeft" class="help-block ">Use "," to divide feature.EX -: friendly interface,good look</p></span>                    
                                                            </div>

                                                            <label class="label-info">Software Sell Time &nbsp;&nbsp;</label>
                                                            <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                                <input type="radio" class="custom-control-input" id="nolimit"  name="1" checked="">
                                                                <label class="custom-control-label" for="nolimit">No Limit</label>
                                                            </div>
                                                            <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                                <input type="radio" class="custom-control-input" id="onetime"  name="1">
                                                                <label class="custom-control-label" for="onetime">One Time</label>
                                                            </div>



                                                        </form>
                                                    </div>

                                                    <div class="tab-pane" id="tab_default_3">

                                                        <form name="form_3">



                                                            <div class="custom-file">
                                                                <input type="file" class="custom-file-input" id="demo_zip" accept="application/zip,application/rar">
                                                                <label class="custom-file-label" for="demo_zip" >Upload Software Demo Zip File</label>
                                                            </div>
                                                            <hr>

                                                            <div class="custom-file">
                                                                <input type="file" class="custom-file-input" id="original_zip" accept="application/zip,application/rar">
                                                                <label class="custom-file-label" for="original_zip">Upload Software Original Zip File</label>
                                                            </div>
                                                            <hr>
                                                            <div class="custom-file">
                                                                <input type="file" class="custom-file-input" id="srs" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document">
                                                                <label class="custom-file-label" for="srs">Upload Software Requirements Specification Document(SRS)</label>
                                                            </div>


                                                            <hr>


                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">US $</span>
                                                                </div>
                                                                <input type="text" class="form-control" id="price" name="pricee" placeholder="Price" required onkeyup="calculateTotalPrice('price', 'price');">
                                                            </div>




                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">US $</span>
                                                                </div>
                                                                <input type="text" class="form-control" id="addon_price" name="addon_pricee" placeholder="Additional Price" required onkeyup="calculateTotalPrice('addon_price', 'addon');">
                                                            </div>




                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">US $</span>
                                                                </div>
                                                                <input type="text" class="form-control" id="dis_price" name="dis_pricee" placeholder="Discount price" required onkeyup="calculateTotalPrice('dis_price', 'dis');">
                                                            </div>

                                                            <span id="msg_price">

                                                            </span>

                                                            <hr>
                                                            <div class="custom-control custom-control-inline custom-checkbox my-1 mr-sm-2">
                                                                <input type="checkbox" class="custom-control-input" id="return_a" checked>
                                                                <label class="custom-control-label" for="return_a">Return accept</label>
                                                            </div>
                                                            <br>
                                                            <br>

                                                            <input type="button" class="btn btn-info" value="Add My Product" onclick="addProduct();">

                                                            <br>
                                                            <img id="img_load">
                                                            <div id="msg">

                                                            </div>

                                                        </form>
                                                    </div>




                                                </div>



                                            </div>
                                        </div>
                                    </div>


                                </div>


                                <div class="tab-pane active" id="tab_b">
                                    <h3>MEMBER DASHBOARD</h3>
                                    <center>
                                        <%                                            Seller seller = (Seller) c.uniqueResult();

                                            int all_products = 0;
                                            int pending_products = 0;
                                            int active_products = 0;
                                            int rejected_products = 0;
                                            int remining_addTime = 0;
                                            int sold_products = 0;
                                            int oneTime_products = 0;
                                            int noLimit_products = 0;

                                            List<Product> all_p = null;

                                            Criteria c4 = s.createCriteria(Product.class);
                                            c4.add(Restrictions.eq("seller", seller));

                                            if (!c4.list().isEmpty()) {

                                                all_p = c4.list();
                                                all_products = all_p.size();

                                            }

                                            Criteria c5 = s.createCriteria(Product.class);
                                            c5.add(Restrictions.eq("seller", seller));
                                            c5.add(Restrictions.eq("status", "pending"));

                                            if (!c5.list().isEmpty()) {

                                                List<Product> pending_p = c5.list();
                                                pending_products = pending_p.size();

                                            }

                                            Criteria c6 = s.createCriteria(Product.class);
                                            c6.add(Restrictions.eq("seller", seller));
                                            c6.add(Restrictions.eq("status", "active"));

                                            if (!c6.list().isEmpty()) {

                                                List<Product> active_p = c6.list();
                                                active_products = active_p.size();

                                            }

                                            Criteria c7 = s.createCriteria(Product.class);
                                            c7.add(Restrictions.eq("seller", seller));
                                            c7.add(Restrictions.eq("status", "rejected"));

                                            if (!c7.list().isEmpty()) {

                                                List<Product> reject_p = c7.list();
                                                rejected_products = reject_p.size();

                                            }

                                            Criteria c8 = s.createCriteria(SellerHasPackage.class);
                                            c8.add(Restrictions.eq("seller", seller));
                                            c8.add(Restrictions.eq("status", "active"));

                                            if (!c8.list().isEmpty()) {
                                                SellerHasPackage shp = (SellerHasPackage) c8.uniqueResult();
                                                remining_addTime = shp.getRemainingAddTime();
                                            }

                                            Criteria c9 = s.createCriteria(InvoiceProductHasItem.class);

                                            if (!c9.list().isEmpty()) {
                                                List<InvoiceProductHasItem> inv_items = c9.list();
                                                for (InvoiceProductHasItem p : inv_items) {

                                                    Criteria c10 = s.createCriteria(InvoiceProduct.class);
                                                    c10.add(Restrictions.eq("idinvoiceProduct", p.getInvoiceProduct().getIdinvoiceProduct()));
                                                    c10.add(Restrictions.eq("status", "done"));
                                                    if (!c10.list().isEmpty()) {

                                                        if (p.getProduct().getSeller().getIdseller().equals(seller.getIdseller())) {
                                                            //inv prodct eke seller == login seller
                                                            sold_products++;

                                                        } else {

                                                        }
                                                    }
                                                }

                                            }

                                            Criteria c11 = s.createCriteria(Product.class);
                                            c11.add(Restrictions.eq("seller", seller));
                                            c11.add(Restrictions.eq("sellLimit", "oneTime"));

                                            if (!c11.list().isEmpty()) {

                                                List<Product> onetime_p = c11.list();
                                                oneTime_products = onetime_p.size();

                                            }

                                            Criteria c12 = s.createCriteria(Product.class);
                                            c12.add(Restrictions.eq("seller", seller));
                                            c12.add(Restrictions.eq("sellLimit", "noLimit"));

                                            if (!c12.list().isEmpty()) {

                                                List<Product> noLimit_p = c12.list();
                                                noLimit_products = noLimit_p.size();

                                            }

                                        %>
                                        <table>
                                            <tr>
                                                <td>

                                                    <div class="card text-white bg-primary mb-3" style="max-width: 18rem;">
                                                        <div class="card-header">ALL PRODUCTS</div>
                                                        <div class="card-body">
                                                            <h1 class="card-title" style="font-size: 120px;">&nbsp;&nbsp;<%=all_products%>&nbsp;</h1>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="card text-white bg-info mb-3" style="max-width: 18rem;">
                                                        <div class="card-header">REMAINING ADD TIME</div>
                                                        <div class="card-body">
                                                            <h1 class="card-title" style="font-size: 120px;">&nbsp;&nbsp;<%=remining_addTime%>&nbsp;</h1>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="card text-white bg-dark mb-3" style="max-width: 18rem;">
                                                        <div class="card-header">ONE TIME SELL PRODUCTS</div>
                                                        <div class="card-body">
                                                            <h1 class="card-title" style="font-size: 120px;">&nbsp;&nbsp;<%=oneTime_products%>&nbsp;</h1>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="card text-white bg-secondary mb-3" style="max-width: 18rem;">
                                                        <div class="card-header">NO LIMIT SELL PRODUCTS</div>
                                                        <div class="card-body">
                                                            <h1 class="card-title" style="font-size: 120px;">&nbsp;&nbsp;<%=noLimit_products%>&nbsp;</h1>
                                                        </div>
                                                    </div>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>

                                                    <div class="card text-white bg-success mb-3" style="max-width: 18rem;">
                                                        <div class="card-header">ACTIVE PRODUCTS</div>
                                                        <div class="card-body">
                                                            <h1 class="card-title" style="font-size: 120px;">&nbsp;&nbsp;<%=active_products%>&nbsp;</h1>
                                                        </div>
                                                    </div>

                                                </td>

                                                <td>
                                                    <div class="card text-white bg-warning mb-3" style="max-width: 18rem;">
                                                        <div class="card-header">PENDING PRODUCTS</div>
                                                        <div class="card-body">
                                                            <h1 class="card-title" style="font-size: 120px;">&nbsp;&nbsp;<%=pending_products%>&nbsp;</h1>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="card text-white bg-danger mb-3" style="max-width: 18rem;">
                                                        <div class="card-header">REJECTED PRODUCTS</div>
                                                        <div class="card-body">
                                                            <h1 class="card-title" style="font-size: 120px;">&nbsp;&nbsp;<%=rejected_products%>&nbsp;</h1>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="card text-white bg-info mb-3" style="max-width: 18rem;">
                                                        <div class="card-header">TOTAL SOLD</div>
                                                        <div class="card-body">
                                                            <h1 class="card-title" style="font-size: 120px;">&nbsp;&nbsp;<%=sold_products%>&nbsp;</h1>
                                                        </div>
                                                    </div>
                                                </td>

                                            </tr>
                                        </table>

                                    </center>



                                </div>


                                <div class="tab-pane" id="tab_c">
                                    <h3>ALL PRODUCT LIST</h3>



                                    <%

                                        if (!c4.list().isEmpty()) {
                                    %>


                                    <table class="table table-responsive table-hover table-striped table-condensed">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">RATE</th>
                                                <th scope="col">ADD DATE</th>
                                                <th scope="col">ADDITIONAL</th>
                                                <th scope="col">DISCOUNT</th>
                                                <th scope="col">PRODUCT</th>
                                                <th scope="col">SELL</th>
                                                <th scope="col">STATUS</th>
                                                <th scope="col">VIEW</th>
                                            </tr>
                                        </thead>
                                        <tbody>  
                                            <%
                                                for (Product p : all_p) {
                                                    String imgUrl = p.getImg1().replace(request.getServletContext().getRealPath("/"), "");

                                            %>
                                            <tr>
                                                <th scope="row">
                                        <div class="photo"> <div class="avatar" style="background-image: url(<%=imgUrl%>)" ></div> </div>
                                        </th>

                                        <td>
                                            <!--rate-->
                                            <div id="rate">
                                                <%
                                                    Criteria c13 = s.createCriteria(PRate.class);
                                                    c13.add(Restrictions.eq("product", p));

                                                    double overoll_rate = 0;
                                                    if (!c13.list().isEmpty()) {
                                                        List<PRate> rates = c13.list();
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
                                        <td><%=p.getAddDate()%></td>

                                        <%

                                            Criteria c14 = s.createCriteria(Disandaddon.class);
                                            c14.add(Restrictions.eq("product", p));
                                            Disandaddon disaddon = null;
                                            if (!c14.list().isEmpty()) {

                                                disaddon = (Disandaddon) c14.uniqueResult();

                                            }
                                        %>
                                        <td>$<%=disaddon.getAddon()%></td>
                                        <td>$<%=disaddon.getDiscount()%></td>
                                        <td>$<%=p.getPrice()%></td>
                                        <td><%=p.getSellLimit()%></td>
                                        <%
                                            if (p.getStatus().equals("active")) {
                                        %>
                                        <td style="color: #28A745;text-transform: uppercase;"><b><%=p.getStatus()%></b></td>
                                        <td><button class="btn btn-info" onclick="gotoView(<%=p.getIdproduct()%>)">View</button></td>
                                        <%
                                        } else if (p.getStatus().equals("pending")) {
                                        %>
                                        <td style="color: #FFB014;text-transform: uppercase;"><b><%=p.getStatus()%></b></td>
                                        <td></td>
                                        <%
                                        } else if (p.getStatus().equals("rejected")) {
                                        %>
                                        <td style="color: #DC3545;text-transform: uppercase;"><b><%=p.getStatus()%></b></td>
                                        <td></td>
                                        <%
                                        } else if (p.getStatus().equals("sold")) {
                                        %>
                                        <td style="color: #007BFF;text-transform: uppercase;"><b><%=p.getStatus()%></b></td>
                                        <td></td>
                                        <%
                                        } else {
                                        %>
                                        <td><b><%=p.getStatus()%></b></td>
                                        <td></td>
                                        <%
                                            }
                                        %>


                                        </tr>
                                        <%
                                            }
                                        } else {
                                        %>

                                        <center>
                                            <h6>No Products yet!</h6>
                                        </center>
                                        <%
                                            }


                                        %>
                                        </tbody>
                                    </table>

                                </div>

                                <div class="tab-pane" id="tab_d">
                                    <h3>SOLD PRODUCTS</h3>
                                    <table class="table table-striped table-responsive table-condensed table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">TITLE</th>
                                                <th scope="col">INV</th>
                                                <th scope="col">SOLD DATE</th>
                                                <th scope="col">CUSTOMER NAME</th>
                                                <th scope="col">CONTACT NO</th>
                                                <th scope="col">EMAIL</th>
                                                <!--<th scope="col">STATUS</th>-->
                                                <!--<th scope="col">VIEW</th>-->
                                            </tr>
                                        </thead>
                                        <tbody>  

                                            <%                                                Criteria c16 = s.createCriteria(InvoiceProduct.class);
                                                c16.add(Restrictions.eq("status", "done"));

                                                if (!c16.list().isEmpty()) {

                                                    List<InvoiceProduct> ip = c16.list();
                                                    for (InvoiceProduct i : ip) {

                                                        Criteria c17 = s.createCriteria(InvoiceProductHasItem.class);
                                                        c17.add(Restrictions.eq("invoiceProduct", i));
                                                        if (!c17.list().isEmpty()) {

                                                            List<InvoiceProductHasItem> iphi = c17.list();
                                                            for (InvoiceProductHasItem ipi : iphi) {

                                                                if (ipi.getProduct().getSeller().getIdseller().equals(seller.getIdseller())) {
                                                                    String imgUrlP = ipi.getProduct().getImg1().replace(request.getServletContext().getRealPath("/"), "");

                                                                    String date = i.getDate().toString();
                                            %>



                                            <tr>
                                                <th scope="row">
                                        <div class="photo"> <div class="avatar" style="background-image: url(<%=imgUrlP%>)" ></div> </div>
                                        </th>

                                        <td><%=ipi.getProduct().getTitle()%></td>
                                        <td><%=i.getIdinvoiceProduct()%></td>
                                        <td><%=date%></td>
                                        <td><%=i.getUser().getFirstName()%> <%=i.getUser().getLastName()%></td>
                                        <td><%=i.getUser().getMobile()%></td>
                                        <td><%=i.getUser().getEmail()%></td>
                                        </tr>
                                        <%

                                                            }
                                                        }
                                                    }
                                                }
                                            }

                                        %>

                                        </tbody>
                                    </table>

                                </div>

                                <div class="tab-pane" id="tab_e">
                                    <h3>&nbsp;&nbsp;&nbsp;&nbsp;PROJECT REQUEST</h3>

                                    <table class="table table-striped  table-hover  table-condensed">
                                        <thead>
                                            <tr>

                                                <th scope="col">TITLE</th>
                                                <th scope="col">DATE</th>
                                                <th scope="col">PLATFORM</th>
                                                <th scope="col">CATEGORY</th>
                                                <th scope="col">DESCRIPTION</th>
                                                <th scope="col">WISH PRICE</th>
                                                <th scope="col">USER</th>

                                            </tr>
                                        </thead>
                                        <tbody>


                                            <%                                                Criteria c10 = s.createCriteria(ReqProject.class);

                                                if (!c10.list().isEmpty()) {
                                                    List<ReqProject> q = c10.list();

                                                    for (ReqProject k : q) {

                                                        if (!u.getIduser().equals(k.getUser().getIduser())) {
                                            %>
                                            <tr>
                                                <td><%=k.getTitle()%></td>
                                                <td><%=k.getDate().toString()%></td>
                                                <td><%=k.getSfPlatform()%></td>
                                                <td><%=k.getSfCategory().getCategoryName()%></td>
                                                <td><%=k.getDes()%></td>
                                                <td><%=k.getWishPrice()%></td>
                                                <td><%=k.getUser().getFirstName()%> <%=k.getUser().getLastName()%></td>
                                            </tr>

                                            <%
                                                        }
                                                    }
                                                }
                                            %>



                                        </tbody>
                                    </table>

                                </div>


                                <div class="tab-pane" id="tab_f">
                                    <h3>&nbsp;&nbsp;&nbsp;&nbsp;ADMINISTRATOR CONTACT DETAILS</h3>

                                    <table class="table table-striped  table-hover  table-condensed">
                                        <thead>
                                            <tr>

                                                <th scope="col">NAME</th>
                                                <th scope="col">MOBILE</th>
                                                <th scope="col">EMAIL</th>


                                            </tr>
                                        </thead>
                                        <tbody>


                                            <%
                                                Criteria c13 = s.createCriteria(Admin.class);

                                                if (!c13.list().isEmpty()) {
                                                    List<Admin> q = c13.list();

                                                    for (Admin k : q) {


                                            %>
                                            <tr>
                                                <td><%=k.getFname()%> <%=k.getLname()%></td>
                                                <td><%=k.getMobile()%></td>
                                                <td><%=k.getEmail()%></td>

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



        <%                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("home.jsp");
            }

        %>



        <script src="Bootstrap/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>




        <script type="text/javascript">
                                            function addNewCata() {
                                                var name_cata = document.forms["add_new_cataForm"]["name_cata"].value;
                                                var msg = document.getElementById("add_cata_msg");
                                                if (name_cata === null || name_cata === "") {

                                                    msg.innerHTML = "please fill the details!";
                                                    msg.setAttribute("class", "alert alert-danger");
                                                } else {
                                                    var name = document.getElementById("id_name_cata").value;
                                                    var json = {"name": name};
                                                    var json_str = JSON.stringify(json);
                                                    var req = new XMLHttpRequest();
                                                    req.onreadystatechange = function() {
                                                        if (req.readyState == 4 && req.status == 200) {
                                                            if (req.responseText == 1) {
                                                                msg.innerHTML = "new category added!";
                                                                msg.setAttribute("class", "alert alert-success");
                                                                loadCata();
                                                            } else if (req.responseText == 2) {
                                                                msg.innerHTML = "same item found.try new one!";
                                                                msg.setAttribute("class", "alert alert-danger");
                                                            } else {

                                                                msg.innerHTML = "something wrong!";
                                                                msg.setAttribute("class", "alert alert-danger");
                                                            }
                                                        }
                                                    };
                                                    req.open("get", "addNewCata?json_str=" + json_str, true);
                                                    req.send();
                                                }


                                            }
                                            function loadCata() {

                                                var select = document.getElementById("soft_cata");
                                                select.innerHTML = "";
                                                var op1 = document.createElement("option");
                                                op1.innerHTML = "Choose Software Category";
                                                op1.setAttribute("value", 0);
                                                select.appendChild(op1);
                                                var req = new XMLHttpRequest();
                                                req.onreadystatechange = function() {


                                                    if (req.readyState == 4 && req.status == 200) {
                                                        var json_arr = JSON.parse(req.responseText);
                                                        for (var i = 0; i < json_arr.length; i++) {
                                                            var json_obj = json_arr[i];
                                                            var op = document.createElement("option");
                                                            op.innerHTML = json_obj.name;
                                                            op.setAttribute("value", json_obj.id);
                                                            select.appendChild(op);
                                                        }
                                                    }
                                                };
                                                req.open("get", "loadCataList", true);
                                                req.send();
                                            }

                                            function loadCheckBox() {


                                                var req = new XMLHttpRequest();
                                                req.onreadystatechange = function() {

                                                    if (req.readyState == 4 && req.status == 200) {

                                                    }

                                                };
                                                req.open("get", "loadCheckBox_1", true);
                                                req.send();

                                            }

                                            function calculateTotalPrice(id, type) {

                                                var price = document.getElementById(id).value;

                                                var msg = document.getElementById("msg_price");
                                                var json = {"price": price, "type": type};
                                                var json_str = JSON.stringify(json);
                                                var req = new XMLHttpRequest();
                                                req.onreadystatechange = function() {

                                                    if (req.readyState == 4 && req.status == 200) {
                                                        var res = req.responseText;

                                                        var txt = res.split(",")[0];
                                                        var pro = res.split(",")[1];
                                                        if (txt == 0) {
                                                            msg.innerHTML = "Invalid Ammount!";
                                                            msg.setAttribute("class", "alert-danger");
                                                        } else if (txt == 1) {
                                                            msg.innerHTML = "Your nor seller!";
                                                            msg.setAttribute("class", "alert-danger");

                                                        } else if (txt == 2) {
                                                            msg.innerHTML = "Opps! You haven't active packages!";
                                                            msg.setAttribute("class", "alert-danger");

                                                        } else if (txt == 3) {

                                                            msg.innerHTML = "$" + pro + " is your profit";
                                                            msg.setAttribute("class", "alert-success");

                                                        } else if (txt == 4) {

                                                            msg.innerHTML = "Paymont ok!";
                                                            msg.setAttribute("class", "alert-success");

                                                        }

                                                    }
                                                };
                                                req.open("get", "calculateTotalPrice?json_str=" + json_str, true);
                                                req.send();
                                            }


                                            function addProduct() {


                                                var msg = document.getElementById("msg");
                                                //form_1
                                                var t = document.forms["form_1"]["sf_title"].value;
                                                var s = document.forms["form_1"]["sf_small_des"].value;
                                                var b = document.forms["form_1"]["sf_brief_des"].value;

                                                var soft_cata = document.forms["form_1"]["cata"].value;
                                                var langu = document.forms["form_1"]["langu"].value;

                                                //PLATFORM

                                                var array_platform = []
                                                var checkboxes_1 = document.querySelectorAll('input[type=checkbox][name=platform]:checked')

                                                for (var i = 0; i < checkboxes_1.length; i++) {
                                                    array_platform.push(checkboxes_1[i].value)
                                                }



                                                //type
                                                var r1 = document.getElementById("single").checked;
                                                var r2 = document.getElementById("multi").checked;
                                                var r3 = document.getElementById("cloud").checked;

                                                var sf_type = "";

                                                if (r1) {
                                                    sf_type = "single";

                                                }
                                                if (r2) {
                                                    sf_type = "multi";
                                                }
                                                if (r3) {
                                                    sf_type = "cloud";
                                                }

                                                //sell type
                                                var s1 = document.getElementById("onetime").checked;
                                                var s2 = document.getElementById("nolimit").checked;


                                                var sellType = "";

                                                if (s1) {
                                                    sellType = "oneTime";

                                                }
                                                if (s2) {
                                                    sellType = "noLimit";
                                                }


                                                //os
                                                var array_os = []
                                                var checkboxes_2 = document.querySelectorAll('input[type=checkbox][name=os]:checked')

                                                for (var i = 0; i < checkboxes_2.length; i++) {
                                                    array_os.push(checkboxes_2[i].value)
                                                }




                                                //form_2
                                                var images = document.getElementById("file_images");
                                                var video = document.getElementById("file_video");
                                                var fe = document.forms["form_2"]["features"].value;


                                                //form_3
                                                var p = document.forms["form_3"]["price"].value;
                                                var addon = document.forms["form_3"]["addon_price"].value;
                                                var dis = document.forms["form_3"]["dis_price"].value;
                                                var demo_zip = document.getElementById("demo_zip");
                                                var original_zip = document.getElementById("original_zip");
                                                var srs = document.getElementById("srs");
                                                var c7 = document.getElementById("return_a").checked;

                                                var return_a = "false";
                                                if (c7) {
                                                    return_a = "true";
                                                }



                                                if (t == null || t == "", s == null || s == "", b == null || b == "", fe == null || fe == "", p == "" || p == null, addon == "" || addon == null, dis == "" || dis == null) {
                                                    msg.innerHTML = "Fill the details!";
                                                    msg.setAttribute("class", "alert alert-danger");
                                                } else {

                                                    if (soft_cata == 0) {
                                                        msg.innerHTML = "Choose the software category!";
                                                        msg.setAttribute("class", "alert alert-danger");

                                                    } else {

                                                        if (langu == 0) {
                                                            msg.innerHTML = "Choose the software language!";
                                                            msg.setAttribute("class", "alert alert-danger");

                                                        } else {

                                                            var title = document.getElementById("title").value;
                                                            var small_des = document.getElementById("small_des").value;
                                                            var brief_des = document.getElementById("brief_des").value;
                                                            var soft_cata = document.getElementById("soft_cata").value;
                                                            var languages = document.getElementById("languages").value;
                                                            var features = document.getElementById("features").value;
                                                            var price = document.getElementById("price").value;
                                                            var addon_P = document.getElementById("addon_price").value;
                                                            var dis_P = document.getElementById("dis_price").value;
                                                            var videoLink = document.getElementById("sf_videoLink").value;

                                                            var json = {
                                                                "title": title
                                                                , "small_des": small_des
                                                                , "brief_des": brief_des
                                                                , "soft_cata": soft_cata
                                                                , "languages": languages
                                                                , "sf_platform": array_platform
                                                                , "sf_type": sf_type
                                                                , "sf_os": array_os
                                                                , "features": features
                                                                , "sellType": sellType
                                                                , "price": price
                                                                , "addon": addon_P
                                                                , "dis": dis_P
                                                                , "return_a": return_a
                                                            };

                                                            var json_str = JSON.stringify(json);

                                                            var form = new FormData();
                                                            form.append("image1", images.files[0], images.files[0].name);
                                                            form.append("image2", images.files[1], images.files[1].name);
                                                            form.append("image3", images.files[2], images.files[2].name);

                                                            form.append("demo", demo_zip.files[0], demo_zip.files[0].name);
                                                            form.append("original", original_zip.files[0], original_zip.files[0].name);
                                                            form.append("srs", srs.files[0], srs.files[0].name);



                                                            var req = new XMLHttpRequest();
                                                            req.onreadystatechange = function() {
                                                                document.getElementById("img_load").src = "images/loading_3.gif";

                                                                if (req.readyState === 4 && req.status === 200) {
                                                                    document.getElementById("img_load").src = "";
                                                                    var txt = req.responseText;


                                                                    var sp = txt.split(',');
                                                                    var one = sp[0];
                                                                    var two = sp[1];


                                                                    if (one === "1") {
                                                                        msg.innerHTML = "Product added success! please wait for admin approvel. You have another " + two + " times product publish time!";
                                                                        msg.setAttribute("class", "alert-success");

                                                                    } else {

                                                                        msg.innerHTML = txt;
                                                                        msg.setAttribute("class", "alert-danger");
                                                                    }
                                                                }
                                                            };
                                                            req.open("post", "addProduct?json_str=" + json_str + "&video=" + videoLink, true);
                                                            req.send(form);

                                                        }

                                                    }



                                                }



                                            }

                                            function test() {

                                                var str = "hello,man"
                                                var sp = str.split(',');
                                                var one = sp[0];
                                                var two = sp[1];
                                                alert(one);
                                                alert(two);
                                            }
                                            function  gotoView(pid) {

                                                window.location = "view_more.jsp?pid=" + pid;
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
        <script type="text/javascript">

            $('.custom-file-input').on('change', function() {
                let fileName = $(this).val().split('\\').pop();
                $(this).siblings('.custom-file-label').addClass('selected').html(fileName);
            });


        </script>
        <%            } else {
                response.sendRedirect("server_underC.jsp");
            }

        %>



    </body>
</html>
