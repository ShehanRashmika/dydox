<%-- 
    Document   : admin_charts
    Created on : Jun 22, 2018, 8:02:46 PM
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
    <body onload="loadPieChart(), loadBarChart1(), loadBarChart2(), loadBarChart3()">
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
                            <h1>Analyze</h1>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="page-header float-right">
                        <div class="page-title">
                            <ol class="breadcrumb text-right">
                                <li><a href="#">Charts</a></li>
                                <li class="active">Financial</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content mt-3">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="mb-3">TOTAL PROFIT</h4>
                                    <canvas id="pieChart"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="mb-3">PRODUCT INCOME AND DATE</h4>
                                    <canvas id="barchart1"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- /# column -->
            <div class="content mt-3">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="mb-3">PACKAGE INCOME AND DATE</h4>
                                    <canvas id="barchart2"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="mb-3">USER AND INCOME</h4>
                                    <canvas id="barchart3"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>


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

        <script src="admin/assets/js/vendor/jquery-2.1.4.min.js"></script>
        <script src="admin/assets/js/popper.min.js"></script>
        <script src="admin/assets/js/plugins.js"></script>
        <script src="admin/assets/js/main.js"></script>
        <!--  Chart js -->

        <script src="admin/assets/js/lib/chart-js/Chart.bundle.js"></script>
        <script src="admin/assets/js/lib/chart-js/chartjs-init.js"></script>

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
            function loadPieChart() {


                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {

                        var tot_products = req.responseText.split(",")[0];
                        var tot_package = req.responseText.split(",")[1];
                        var tot_cost = req.responseText.split(",")[2];
                        var profit = req.responseText.split(",")[3];


                        var ctx = document.getElementById("pieChart");
                        ctx.height = 200;
                        var myChart = new Chart(ctx, {
                            type: 'pie',
                            data: {
                                datasets: [{
                                        data: [tot_products, tot_package, tot_cost, profit],
                                        backgroundColor: [
                                            "rgba(218, 160, 93,0.7)",
                                            "rgba(191, 175, 64,0.9)",
                                            "rgba(215, 49, 33,0.9)",
                                            "rgba(18, 183, 118,0.9)",
                                            "rgba(0,0,0,0.07)"
                                        ],
                                        hoverBackgroundColor: [
                                            "rgba(218, 160, 93,0.7)",
                                            "rgba(191, 175, 64,0.9)",
                                            "rgba(215, 49, 33,0.9)",
                                            "rgba(18, 183, 118,0.9)",
                                            "rgba(0,0,0,0.07)"
                                        ]

                                    }],
                                labels: [
                                    "Products Income",
                                    "Package Income",
                                    "Seller Cost",
                                    "Profit",
                                ]
                            },
                            options: {
                                responsive: true
                            }
                        });
                    }
                };

                req.open("get", "loadChartsValue?status=pie1", true);
                req.send();




            }
            function loadBarChart1() {

                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {


                        var o = JSON.parse(req.responseText); //responce eke ena txt eka aye object ekakata cast krnwa
                        var date = []
                        var total = []
                        for (x in o) {

                            date.push(o[x].date);
                            total.push(o[x].total);


                        }

                        var ctx = document.getElementById("barchart1");
                        ctx.height = 200;
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: date,
                                datasets: [
                                    {
                                        label: "Product Incomes",
                                        data: total,
                                        borderColor: "rgba(170, 108, 0, 0.9)",
                                        borderWidth: "0",
                                        backgroundColor: "rgba(255, 162, 0, 0.5)"
                                    }
                                ]
                            },
                            options: {
                                scales: {
                                    yAxes: [{
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }]
                                }
                            }
                        });
                    }
                };

                req.open("get", "loadChartsValue?status=bar1", true);
                req.send();


            }
            function loadBarChart2() {

                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {


                        var o = JSON.parse(req.responseText); //responce eke ena txt eka aye object ekakata cast krnwa
                        var date = []
                        var total = []
                        for (x in o) {

                            date.push(o[x].date);
                            total.push(o[x].total);


                        }

                        var ctx = document.getElementById("barchart2");
                        ctx.height = 200;
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: date,
                                datasets: [
                                    {
                                        label: "Package Incomes",
                                        data: total,
                                        borderColor: "rgba(170, 108, 0, 0.9)",
                                        borderWidth: "0",
                                        backgroundColor: "rgba(255, 162, 0, 0.5)"
                                    }
                                ]
                            },
                            options: {
                                scales: {
                                    yAxes: [{
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }]
                                }
                            }
                        });
                    }
                };

                req.open("get", "loadChartsValue?status=bar2", true);
                req.send();


            }

            function loadBarChart3() {

                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {


                        var o = JSON.parse(req.responseText); //responce eke ena txt eka aye object ekakata cast krnwa
                        var uid = []
                        var total = []
                        for (x in o) {

                            uid.push(o[x].uid);
                            total.push(o[x].total);


                        }

                        var ctx = document.getElementById("barchart3");
                        ctx.height = 200;
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: uid,
                                datasets: [
                                    {
                                        label: "User Incomes",
                                        data: total,
                                        borderColor: "rgba(3, 0, 253, 0.9)",
                                        borderWidth: "0",
                                        backgroundColor: "rgba(22, 159, 235, 0.5)"
                                    }
                                ]
                            },
                            options: {
                                scales: {
                                    yAxes: [{
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }]
                                }
                            }
                        });
                    }
                };

                req.open("get", "loadChartsValue?status=bar3", true);
                req.send();


            }
        </script>
    </body>
</html>
