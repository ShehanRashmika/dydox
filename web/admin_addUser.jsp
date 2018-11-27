<%-- 
    Document   : admin_addUser
    Created on : Jun 18, 2018, 1:09:27 PM
    Author     : Sheha
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.hibernate.Session"%>
<%@page import="pojos.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>dydox.lk</title>
        <link rel="apple-touch-icon" href="apple-icon.png">
        <link rel="shortcut icon" href="favicon.ico">

        <link rel="stylesheet" href="admin/assets/css/normalize.css">
        <link rel="stylesheet" href="admin/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="admin/assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="admin/assets/css/themify-icons.css">
        <link rel="stylesheet" href="admin/assets/css/flag-icon.min.css">
        <link rel="stylesheet" href="admin/assets/css/cs-skin-elastic.css">
        <link rel="stylesheet" href="admin/assets/css/bootstrap-select.less"> 
        <link rel="stylesheet" href="admin/assets/scss/style.css">
        <link href="admin/assets/css/lib/vector-map/jqvmap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="admin/assets/css/lib/datatable/dataTables.bootstrap.min.css">
        <!-- <link rel="stylesheet" href="assets/css/bootstrap-select.less"> -->
        <link rel="stylesheet" href="admin/assets/scss/style.css">

        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
        <style>
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
    <body>
        <%

            Admin a = (Admin) request.getSession().getAttribute("admin");
            if (a != null) {

                Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                //admin logged

        %>
        <aside id="left-panel" class="left-panel">
            <nav class="navbar navbar-expand-sm navbar-default">

                <div class="navbar-header">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main-menu" aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="fa fa-bars"></i>
                    </button>

                    <a class="navbar-brand"> <img src="admin/images/logo_dydox.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="admin/images/logo2.png" alt="Logo"></a>
                </div>

                <div id="main-menu" class="main-menu collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="admin_index.jsp"> <i class="menu-icon fa fa-dashboard"></i>Dashboard </a>
                        </li>
                        <h3 class="menu-title">SYSTEM MANAGEMENT</h3><!-- /.menu-title -->
                        <li class="menu-item-has-children dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-user"></i>User Management</a>
                            <ul class="sub-menu children dropdown-menu">
                                <li><i class="fa fa-users"></i><a href="admin_allUsers.jsp">All Users</a></li>
                                <li><i class="fa fa-male"></i><a href="admin_allMembers.jsp">All Members</a></li>
                                <li><i class="fa fa-user-plus"></i><a href="admin_addUser.jsp">Add User</a></li>

                            </ul>
                        </li>
                        <li class="menu-item-has-children dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-table"></i>Packages</a>
                            <ul class="sub-menu children dropdown-menu">
                                <li><i class="fa fa-book"></i><a href="admin_allPackages.jsp">All Packages</a></li>
                                <li><i class="fa fa-address-book"></i><a href="admin_sellerPackages.jsp">Seller Packages</a></li>
                            </ul>
                        </li>
                        <li class="menu-item-has-children dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-laptop"></i>Products</a>
                            <ul class="sub-menu children dropdown-menu">
                                <li><i class="menu-icon fa fa-product-hunt"></i><a href="admin_allProducts.jsp">All Products</a></li>
                                <li><i class="menu-icon fa fa-sellsy"></i><a href="admin_soldProducts.jsp">Sold Products</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="admin_serverSettings.jsp"> <i class="menu-icon fa fa-edit"></i>Server Settings</a>
                        </li>
                        <h3 class="menu-title">FINANCIAL MANAGEMENT</h3><!-- /.menu-title -->

                        <li class="menu-item-has-children dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-money"></i>Invoices</a>
                            <ul class="sub-menu children dropdown-menu">
                                <li><i class="menu-icon fa fa-table"></i><a href="admin_packageINV.jsp">Package Invoices</a></li>
                                <li><i class="menu-icon fa fa-product-hunt"></i><a href="admin_productsInvoice.jsp">Product Invoices</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="admin_profitCal.jsp"> <i class="menu-icon fa fa-bar-chart"></i>Profit Calculation</a>
                        </li>
                        <h3 class="menu-title">Analyze</h3><!-- /.menu-title -->
                        <li class="menu-item-has-children dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-line-chart"></i>Charts</a>
                            <ul class="sub-menu children dropdown-menu">
                                <li><i class="menu-icon fa fa-pie-chart"></i><a href="admin_charts.jsp">Financial</a></li>
                                <li><i class="menu-icon fa fa-line-chart"></i><a href="admin_charts2.jsp">System</a></li>
                            </ul>
                        </li>
                        <h3 class="menu-title">admin privileges</h3><!-- /.menu-title -->
                        <li>
                            <a href="admin_settings.jsp"> <i class="menu-icon fa fa-edit"></i>Edit and ADD</a>
                        </li>

                    </ul>
                </div><!-- /.navbar-collapse -->
            </nav>
        </aside><!-- /#left-panel -->

        <!-- Left Panel -->


        <!-- Right Panel -->

        <div id="right-panel" class="right-panel">

            <!-- Header-->
            <header id="header" class="header">

                <div class="header-menu">
                    <div class="col-sm-7">
                        <a id="menuToggle" class="menutoggle pull-left"><i class="fa fa fa-tasks"></i></a>
                            <%                            Date d = new Date();
                                String date = new SimpleDateFormat("yyy-MM-dd").format(d);
                                String time = new SimpleDateFormat("hh:mm a").format(d);
                            %>
                        <span>Hello <b><%=a.getFname()%></b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span><%=date%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span><%=time%></span>
                    </div>


                    <div class="col-sm-5">
                        <div class="user-area dropdown float-right">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img class="user-avatar rounded-circle" src="images/blank.png" alt="User Avatar">

                            </a>

                            <div class="user-menu dropdown-menu">
                                <a class="nav-link" href="admin_settings.jsp"><i class="fa fa-user"></i>&nbsp;&nbsp;My Profile</a>

                                <a class="nav-link" href="admin_index.jsp"><i class="fa fa-dashboard"></i>&nbsp;&nbsp;Dashboard</a>

                                <a class="nav-link" href="admin_serverSettings.jsp"><i class="fa fa-gear"></i>&nbsp;&nbsp;Server Settings</a>


                                <a class="nav-link" href="logOut?status=admin"><i class="fa fa-power-off"></i>&nbsp;&nbsp;Logout</a>

                            </div>
                        </div>



                    </div>
                </div>

            </header><!-- /header -->
            <div class="breadcrumbs">
                <div class="col-sm-4">
                    <div class="page-header float-left">
                        <div class="page-title">
                            <h1>System Management</h1>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="page-header float-right">
                        <div class="page-title">
                            <ol class="breadcrumb text-right">
                                <li><a href="#">User Management</a></li>
                                <li class="active">Add User</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>


            <div class="container">
                <br>
                <div class="row">
                    <div class="col col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">Add User</strong>
                            </div>
                            <div class="card-body">


                                <div class="card-body">


                                    <form name="signUp_form" onsubmit="return false">

                                        <div class="form-group">
                                            <label for="sign_fname" class="control-label mb-1">First Name</label>
                                            <input  name="fname" id="sign_fname" type="text" class="form-control" aria-required="true" aria-invalid="false" placeholder="Enter First Name">
                                        </div>
                                        <div class="form-group">
                                            <label for="sign_lname" class="control-label mb-1">Last Name</label>
                                            <input  name="lname" id="sign_lname" type="text" class="form-control" aria-required="true" aria-invalid="false" placeholder="Enter Last Name">
                                        </div>
                                        <div class="form-group">
                                            <label for="sign_email" class="control-label mb-1">Email</label>
                                            <input  name="email" id="sign_email" type="email" class="form-control" aria-required="true" aria-invalid="false" placeholder="Enter Last Name">
                                        </div>
                                        <div class="row">
                                            <div class="col-6">
                                                <div class="form-group">
                                                    <label for="sign_password" class="control-label mb-1">Password</label>
                                                    <input  name="password" id="sign_password" type="password" class="form-control" aria-required="true" aria-invalid="false" placeholder="Enter Password">
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="form-group">
                                                    <label for="sign_re_password" class="control-label mb-1">Re-Enter Password</label>
                                                    <input  name="re_password"  id="sign_re_password" type="password" class="form-control" aria-required="true" aria-invalid="false" placeholder="Re-Enter Password">
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <button  class="btn btn-sm btn-info btn-block" onclick="signUp();"><i class="fa fa-user fa-lg"></i>&nbsp; Add</button>
                                        </div>
                                        <br>
                                        <img id="img_load_1">
                                        <br>
                                        <div id="msg_signUp" role="alert">

                                        </div>                                 
                                    </form>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div> <!-- .card -->

            <script src="admin/assets/js/vendor/jquery-2.1.4.min.js"></script>
            <script src="admin/assets/js/popper.min.js"></script>
            <script src="admin/assets/js/plugins.js"></script>
            <script src="admin/assets/js/main.js"></script>


            <script src="admin/assets/js/lib/data-table/datatables.min.js"></script>
            <script src="admin/assets/js/lib/data-table/dataTables.bootstrap.min.js"></script>
            <script src="admin/assets/js/lib/data-table/dataTables.buttons.min.js"></script>
            <script src="admin/assets/js/lib/data-table/buttons.bootstrap.min.js"></script>
            <script src="admin/assets/js/lib/data-table/jszip.min.js"></script>
            <script src="admin/assets/js/lib/data-table/pdfmake.min.js"></script>
            <script src="admin/assets/js/lib/data-table/vfs_fonts.js"></script>
            <script src="admin/assets/js/lib/data-table/buttons.html5.min.js"></script>
            <script src="admin/assets/js/lib/data-table/buttons.print.min.js"></script>
            <script src="admin/assets/js/lib/data-table/buttons.colVis.min.js"></script>
            <!--<script src="admin/assets/js/lib/data-table/datatables-init.js"></script>-->


            <script type="text/javascript">
                                                $(document).ready(function() {
                                                    $('#bootstrap-data-table-export').DataTable();
                                                });
            </script>

            <%    } else {
                    response.sendRedirect("admin_login.jsp");
                }

            %>

            <script type="text/javascript">

                function checkPassword() {
                    var pass1 = document.getElementById("sign_password").value;
                    var pass2 = document.getElementById("sign_re_password").value;

                    var msg = document.getElementById("msg_signUp");

                    if (pass1 != pass2) {

                        msg.innerHTML = "Password doesn't match!";
                        msg.className = "alert alert-danger";
                        return false;

                    } else {
                        msg.innerHTML = "";
                        return true;

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
                        msg.className = "alert alert-danger";
                    } else {

                        var email = document.getElementById("sign_email").value;
                        var atpos = email.indexOf("@");
                        var dotpos = email.lastIndexOf(".");
                        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                            msg.innerHTML = "Not a valid e-mail address";
                            msg.className = "alert alert-danger";
                            return false;
                        } else {
                            //right email
                            var fname = document.getElementById("sign_fname").value;
                            var lname = document.getElementById("sign_lname").value;
                            var password = document.getElementById("sign_password").value;


                            if (checkPassword()) {
                                var json = {"sendEmail": "false", "email": email, "password": password, "fname": fname, "lname": lname};
                                var json_str = JSON.stringify(json);
                                var req = new XMLHttpRequest();

                                req.onreadystatechange = function() {
                                    document.getElementById("img_load_1").src = "images/loading_3.gif";
                                    if (req.readyState == 4 && req.status == 200) {
                                        document.getElementById("img_load_1").src = "";

                                        var resp = req.responseText;
                                        alert(resp);
                                        if (resp == 2) {

                                            msg.innerHTML = "User Added!";
                                            msg.className = "alert alert-success";
                                        }
                                        else {

                                            msg.innerHTML = "Something error!";
                                            msg.className = "alert alert-danger";
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
    </body>
</html>
