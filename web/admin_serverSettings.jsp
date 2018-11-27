<%-- 
    Document   : admin_serverSettings
    Created on : Jun 23, 2018, 2:49:01 AM
    Author     : Sheha
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="pojos.User"%>
<%@page import="org.hibernate.Criteria"%>
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
            .table-wrapper-2 {
                display: block;
                max-height: 300px;
                overflow-y: auto;
                -ms-overflow-style: -ms-autohiding-scrollbar;
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
                                <li><a href="#">Server Settings</a></li>

                            </ol>
                        </div>
                    </div>
                </div>
            </div>



            <br>
            <br>
            <div class="container">
                <div class="row">

                    <div class="col col-md-5">
                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">Stop Server</strong>
                            </div>

                            <div class="card-body">

                                <div class="content mt-3">

                                    <div class="animated fadeIn">
                                        <div class="row">

                                            <div class="card-body card-block">
                                                <form  onsubmit="return false">

                                                    <div class="col col-md-12">
                                                        <span>Time in Minutes</span><input id="time" type="text" class="form-control" >                                                
                                                    </div>
                                                    <div class="col col-md-12">
                                                        <span>Message</span><input id="msg" type="text" class="form-control">
                                                    </div>
                                                    <div class="col col-md-12">
                                                        <br>

                                                        <input type="button" class="btn btn-danger btn-block" value="STOP" onclick="stopServer();">
                                                    </div>
                                                </form>

                                            </div>



                                        </div>

                                    </div>

                                </div>
                            </div>
                            <div id="msg_dialog" role="alert" >


                            </div>

                        </div>
                    </div>


                    <div class="col col-md-7">
                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">Send Custom Notification</strong>
                            </div>
                            <div id="alert_msg" role="alert"></div>
                            <div class="card-body">

                                <div class="content mt-3">

                                    <div class="animated fadeIn">

                                        <div class="table-wrapper-2">
                                            <table class="table  table-striped ">
                                                <thead>
                                                    <tr>
                                                        <th>UID</th>
                                                        <th>Name</th>
                                                        <th>Select</th>


                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%    Criteria c = s.createCriteria(User.class);
                                                        if (!c.list().isEmpty()) {
                                                            List<User> list = c.list();
                                                            for (User us : list) {
                                                    %>
                                                    <tr>
                                                        <td><%=us.getIduser()%></td>
                                                        <td><%=us.getFirstName()%> <%=us.getLastName()%></td>
                                                        <td><input type="checkbox" value="<%=us.getIduser()%>" name="users"></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }

                                                    %>
                                                </tbody>
                                            </table>



                                        </div>


                                        <div class="card-body card-block">
                                            <button class="btn btn-sm btn-dark" onclick="selectAll();">select all</button>
                                            <button class="btn btn-sm btn-secondary" onclick="unselectAll();">un select all</button>
                                            <br> 
                                            <br> 
                                            <form class="form-horizontal" onsubmit="return false">
                                                <div class="col col-md-12">
                                                    <span>Subject</span><input id="sub" type="text" class="form-control" >                                                
                                                </div>
                                                <div class="col col-md-12">
                                                    <span>Message</span><input id="noti" type="text" class="form-control">
                                                </div>
                                                <div class="col col-md-12">
                                                    <br>

                                                    <button class="btn btn-info btn-block"  onclick="sendNoti();">Send</button>
                                                </div>

                                            </form>
                                        </div>


                                    </div>

                                </div>
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

            function stopServer() {

                var time = document.getElementById("time").value;
                var msg = document.getElementById("msg").value;

                var msg_dialog = document.getElementById("msg_dialog");

                var json = {"time": time, "msg": msg};
                var json_str = JSON.stringify(json);

                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {
                        var txt = req.responseText;
                        if (txt == 0) {
                            msg_dialog.innerHTML = "Fill the Details!";
                            msg_dialog.className = "alert alert-danger";

                        } else if (txt == 1) {
                            msg_dialog.innerHTML = "Incorrect Time!";
                            msg_dialog.className = "alert alert-danger";

                        } else if (txt == 2) {
                            msg_dialog.innerHTML = "Server Stopped!";
                            msg_dialog.className = "alert alert-success";

                        }

                    }
                };
                req.open("get", "stopServer?json_str=" + json_str, true);
                req.send();

            }

            function selectAll() {


                var checkboxes_1 = document.querySelectorAll('input[type=checkbox][name=users]')

                for (var i = 0; i < checkboxes_1.length; i++) {
                    checkboxes_1[i].checked = true;

                }
            }
            function unselectAll() {


                var checkboxes_1 = document.querySelectorAll('input[type=checkbox][name=users]')

                for (var i = 0; i < checkboxes_1.length; i++) {
                    checkboxes_1[i].checked = false;

                }
            }
            function sendNoti() {

                var sub = document.getElementById("sub").value;
                var noti = document.getElementById("noti").value;

                var msg = document.getElementById("alert_msg");

                var checkboxes_1 = document.querySelectorAll('input[type=checkbox][name=users]:checked')

                var selectedUID = [];
                for (var i = 0; i < checkboxes_1.length; i++) {
                    selectedUID.push(checkboxes_1[i].value);

                }

                var json = {"sub": sub, "noti": noti, "uid": selectedUID};
                var json_str = JSON.stringify(json);

                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {

                        var txt = req.responseText;
                        if (txt == 0) {
                            msg.innerHTML = "Fill The Details!";
                            msg.className = "alert alert-danger";
                        } else if (txt == 1) {
                            msg.innerHTML = "Select The UID!";
                            msg.className = "alert alert-danger";

                        } else if (txt == 2) {
                            msg.innerHTML = "Send!";
                            msg.className = "alert alert-success";

                        }
                    }

                };
                req.open("get", "sendNoti?json_str=" + json_str, true);
                req.send();
            }
        </script>

    </body>
</html>
