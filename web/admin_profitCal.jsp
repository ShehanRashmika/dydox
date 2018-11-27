<%-- 
    Document   : admin_profitCal
    Created on : Jun 21, 2018, 11:01:05 PM
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
    <body onload="loadPackageProfitTable(), loadProductProfitTable(), loadSellerCost(), loadTXT()">
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


            <div id="test"></div>

            <div class="breadcrumbs">
                <div class="col-sm-4">
                    <div class="page-header float-left">
                        <div class="page-title">
                            <h1>Financial Management</h1>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="page-header float-right">
                        <div class="page-title">
                            <ol class="breadcrumb text-right">
                                <li><a href="#">Profit Calculation</a></li>
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
                                <strong class="card-title">Income From Package</strong>
                            </div>

                            <div class="card-body">
                                <div class="card-body card-block">
                                    <form class="form-horizontal" onsubmit="return false">
                                        <div class="row form-group">
                                            <div class="col col-md-6">
                                                <span>From</span><input id="date1" type="date" class="form-control" onchange="">                                                
                                            </div>
                                            <div class="col col-md-6">
                                                <span>To</span><input id="date2" type="date" class="form-control" onchange="loadPackageProfitTable();">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="content mt-3">

                                    <div class="animated fadeIn">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <table id="bootstrap-data-table" class="table table-striped table-bordered ">
                                                    <thead>
                                                        <tr>
                                                            <th>Date</th>
                                                            <th>Amount</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody id="packageProfitTable">

                                                    </tbody>
                                                </table>

                                            </div>

                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>


                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">Seller Cost</strong>
                            </div>

                            <div class="card-body">

                                <div class="content mt-3">
                                    <div class="animated fadeIn">
                                        <div class="row">

                                            <div class="col-md-12">



                                                <table id="bootstrap-data-table" class="table table-striped table-bordered ">
                                                    <thead>
                                                        <tr>
                                                            <th>SID</th>
                                                            <th>Seller Cost</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="sellerCostTable">

                                                    </tbody>
                                                </table>

                                            </div>

                                        </div>

                                    </div>

                                </div>


                            </div>
                        </div>

                    </div>



                    <div class="col col-md-7">

                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">Income From Products</strong>
                            </div>

                            <div class="card-body">
                                <div class="card-body card-block">
                                    <form class="form-horizontal" onsubmit="return false">
                                        <div class="row form-group">
                                            <div class="col col-md-6">
                                                <span>From</span><input id="date3" type="date" class="form-control" onchange="">                                                
                                            </div>
                                            <div class="col col-md-6">
                                                <span>To</span><input id="date4" type="date" class="form-control" onchange="loadProductProfitTable();">
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="content mt-3">
                                    <div class="animated fadeIn">
                                        <div class="row">

                                            <div class="col-md-12">



                                                <table id="bootstrap-data-table" class="table table-striped table-bordered ">
                                                    <thead>
                                                        <tr>
                                                            <th>Date</th>
                                                            <th>Time</th>
                                                            <th>Amount</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="productProfitTable">

                                                    </tbody>
                                                </table>

                                            </div>

                                        </div>

                                    </div>

                                </div>


                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">Profit Calculation</strong>
                            </div>

                            <div class="card-body">

                                <div class="content mt-3">
                                    <div class="animated fadeIn">
                                        <div class="row">

                                            <div class="col-md-12">
                                                <form class="form-horizontal" onsubmit="return false">
                                                    <div class="row form-group">
                                                        <div class="col col-md-6">
                                                            <span>Total Income</span>
                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">$</span>
                                                                </div>
                                                                <input id="tot_income" type="text" class="form-control" aria-describedby="basic-addon1">
                                                            </div>
                                                        </div>
                                                        <div class="col col-md-6">
                                                            <span>Total Cost</span>
                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">$</span>
                                                                </div>
                                                                <input id="tot_cost" type="text" class="form-control" aria-describedby="basic-addon1">
                                                            </div>
                                                        </div>

                                                        <div class="col col-md-12">
                                                            <br>
                                                            <span>Profit</span>
                                                            <div class="input-group mb-3">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text" id="basic-addon1">$</span>
                                                                </div>
                                                                <input id="profit" type="text" class="form-control" aria-describedby="basic-addon1">
                                                            </div>
                                                        </div>

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
            </div>

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
                                                    });</script>

            <%    } else {
                    response.sendRedirect("admin_login.jsp");
                }

            %>
            <script type="text/javascript">


//
                function loadTXT() {

                    var json = {"status": "totals"};
                    var json_str = JSON.stringify(json);

                    var req = new XMLHttpRequest();
                    req.onreadystatechange = function() {

                        if (req.readyState == 4 && req.status == 200) {
                            var txt = req.responseText;
                            var income = txt.split(",")[0];
                            var cost = txt.split(",")[1];
                            var profit = txt.split(",")[2];

                            document.getElementById("tot_income").value = income;
                            document.getElementById("tot_cost").value = cost;
                            document.getElementById("profit").value = profit;
                            if (profit < 0) {

                                document.getElementById("profit").setAttribute("style", "background-color:red;color:white;")
                            } else {

                                document.getElementById("profit").setAttribute("style", "background-color:#FFFFFF;")

                            }
                        }
                    };
                    req.open("get", "loadProfitsTables?json_str=" + json_str, true);
                    req.send();
                }
                function loadPackageProfitTable() {

                    document.getElementById("packageProfitTable").innerHTML = "";
                    var date = document.getElementById("date1").value;
                    var date2 = document.getElementById("date2").value;
                    var json = {"status": "package", "date": date, "date2": date2};
                    var json_str = JSON.stringify(json);
                    var req = new XMLHttpRequest();
                    req.onreadystatechange = function() {

                        if (req.readyState == 4 && req.status == 200) {

                            var o = JSON.parse(req.responseText); //responce eke ena txt eka aye object ekakata cast krnwa
                            for (x in o) {


                                var tr = document.createElement("tr");
                                var td1 = document.createElement("td");
                                td1.innerHTML = o[x].pack_date;
                                var td3 = document.createElement("td");
                                td3.innerHTML = "$" + o[x].pack_amount;

                                tr.appendChild(td1);
                                tr.appendChild(td3);
                                var tb = document.getElementById("packageProfitTable");
                                tb.appendChild(tr);
//  

                                loadTXT();
                            }

                        }
                    };
                    req.open("get", "loadProfitsTables?json_str=" + json_str, true);
                    req.send();
                }
                function loadProductProfitTable() {

                    document.getElementById("productProfitTable").innerHTML = "";
                    var date = document.getElementById("date3").value;
                    var date2 = document.getElementById("date4").value;
                    var json = {"status": "product", "date3": date, "date4": date2};
                    var json_str = JSON.stringify(json);
                    var req = new XMLHttpRequest();
                    req.onreadystatechange = function() {

                        if (req.readyState == 4 && req.status == 200) {

                            var o = JSON.parse(req.responseText); //responce eke ena txt eka aye object ekakata cast krnwa
                            for (x in o) {


                                var tr = document.createElement("tr");
                                var td1 = document.createElement("td");
                                td1.innerHTML = o[x].pro_date;
                                var td2 = document.createElement("td");
                                td2.innerHTML = o[x].pro_time;
                                var td3 = document.createElement("td");
                                td3.innerHTML = "$" + o[x].pro_amount;

                                tr.appendChild(td1);
                                tr.appendChild(td2);
                                tr.appendChild(td3);
                                var tb = document.getElementById("productProfitTable");
                                tb.appendChild(tr);


                                loadTXT();
                            }

                        }
                    };
                    req.open("get", "loadProfitsTables?json_str=" + json_str, true);
                    req.send();
                }
                function loadSellerCost() {

                    document.getElementById("sellerCostTable").innerHTML = "";
                    var json = {"status": "seller_cost"};
                    var json_str = JSON.stringify(json);
                    var req = new XMLHttpRequest();
                    req.onreadystatechange = function() {

                        if (req.readyState == 4 && req.status == 200) {

                            var o = JSON.parse(req.responseText); //responce eke ena txt eka aye object ekakata cast krnwa
                            for (x in o) {



                                var tr = document.createElement("tr");
                                var td01 = document.createElement("td");
                                td01.innerHTML = o[x].sid;
                                var td1 = document.createElement("td");
                                td1.innerHTML = "$" + o[x].seller_cost;

                                tr.appendChild(td01);
                                tr.appendChild(td1);
                                var tb = document.getElementById("sellerCostTable");
                                tb.appendChild(tr);

//                                loadTXT();
                            }

                        }
                    };
                    req.open("get", "loadProfitsTables?json_str=" + json_str, true);
                    req.send();
                }

            </script>

    </body>
</html>
