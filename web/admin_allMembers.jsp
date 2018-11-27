<%-- 
    Document   : admin_allMembers
    Created on : Jun 16, 2018, 7:40:01 PM
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
        <meta name="viewport" content="width=device-width, initial-scale=1">

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
    <body onload="loadUserDataTable();">
        <%

            Admin a = (Admin) request.getSession().getAttribute("admin");
            if (a != null) {

                Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                //admin logged

        %>
        <!-- Left Panel -->

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
                            
                        <%
                Date d = new Date();
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

            <!-- Header-->



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
                                <li class="active">All Members</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content mt-3">
                <div class="animated fadeIn">
                    <div class="row">

                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong class="card-title">Member Data Table</strong>
                                </div>
                                <div class="card-body">
                                    <div class="card-body card-block">
                                        <form class="form-horizontal" onsubmit="return false">
                                            <div class="row form-group">
                                                <div class="col col-md-2"><input id="searchById" type="text" placeholder="Search By SID.." class="form-control" onkeyup="loadUserDataTable()"></div>
                                                <div class="col col-md-3"><input id="searchByName" type="text" placeholder="Search By First Name.." class="form-control" onkeyup="loadUserDataTable()"></div>
                                                <div class="col col-md-3"><input id="searchByLast" type="text" placeholder="Search By Last Name.." class="form-control" onkeyup="loadUserDataTable()"></div>
                                                <div class="col col-md-4">

                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="all" name="1" checked onchange="loadUserDataTable()">
                                                        <label class="custom-control-label" for="all">All</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="C_users" name="1"  onchange="loadUserDataTable()">
                                                        <label class="custom-control-label" for="C_users">Approved</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="I_users" name="1" onchange="loadUserDataTable()">
                                                        <label class="custom-control-label" for="I_users">Inactive</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="P_users" name="1" onchange="loadUserDataTable()">
                                                        <label class="custom-control-label" for="P_users">Pending</label>
                                                    </div>

                                                </div>




                                            </div>

                                        </form>
                                    </div>


                                    <table id="bootstrap-data-table" class="table table-striped table-bordered ">
                                        <thead>
                                            <tr>
                                                <th>Seller ID</th>
                                                <th>User ID</th>
                                                <th>Image</th>
                                                <th>First name</th>
                                                <th>Last name</th>
                                                <th>Mobile</th>
                                                <th>Email</th>
                                                <th>Package</th>
                                                <th>Remaining time</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody id="userDataTable">


                                        </tbody>

                                    </table>
                                    <div class="col col-md-4">
                                        <br>
                                        <button class=" btn btn-sm btn-danger" onclick="setUserStatus('all', 'inactive')">Inactive all</button>
                                        <button class=" btn btn-sm btn-success" onclick="setUserStatus('all', 'approved')">active all</button>
                                    </div>
                                </div>

                            </div>

                        </div>


                    </div>
                </div><!-- .animated -->
            </div><!-- .content -->


        </div><!-- /#right-panel -->

        <!-- Right Panel -->


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

            function loadUserDataTable() {


                document.getElementById("userDataTable").innerHTML = "";

                var name = document.getElementById("searchByName").value;
                var id = document.getElementById("searchById").value;
                var last = document.getElementById("searchByLast").value;

                var r1 = document.getElementById("all").checked;
                var r2 = document.getElementById("C_users").checked;
                var r3 = document.getElementById("I_users").checked;
                var r4 = document.getElementById("P_users").checked;

                var userStatus = "";

                if (r1) {
                    userStatus = "all";

                }
                if (r2) {
                    userStatus = "approved";
                }
                if (r3) {
                    userStatus = "inactive";
                }
                if (r4) {
                    userStatus = "pending";
                }

                var json = {"name": name, "id": id, "last": last, "status": userStatus};
                var json_str = JSON.stringify(json);

                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {

                    if (req.readyState == 4 && req.status == 200) {

                        var o = JSON.parse(req.responseText);//responce eke ena txt eka aye object ekakata cast krnwa

                        for (x in o) {


                            var tr = document.createElement("tr");

                            var td1 = document.createElement("td");
                            td1.innerHTML = o[x].sid;

                            var td01 = document.createElement("td");
                            td01.innerHTML = o[x].uid;


                            var div1 = document.createElement("div");
                            div1.className = "photo";

                            var div2 = document.createElement("div");
                            div2.className = "avatar";
                            div2.setAttribute("style", "background-image: url('" + o[x].img + "')")

                            div1.appendChild(div2);


                            var td2 = document.createElement("td");
                            td2.appendChild(div1);

                            var td3 = document.createElement("td");
                            td3.innerHTML = o[x].fname;

                            var td4 = document.createElement("td");
                            td4.innerHTML = o[x].lname;

                            var td5 = document.createElement("td");
                            td5.innerHTML = o[x].mobile;

                            var td6 = document.createElement("td");
                            td6.innerHTML = o[x].email;

                            var td7 = document.createElement("td");
                            td7.innerHTML = o[x].package;

                            var td8 = document.createElement("td");
                            td8.innerHTML = o[x].remaining;




                            var td10 = document.createElement("td");

                            if (o[x].status == "approved") {

                                var b1 = document.createElement("b");

                                var sp1 = document.createElement("span");
                                sp1.setAttribute("style", "color:#28A745");
                                sp1.innerHTML = o[x].status;

                                var btn1 = document.createElement("button");
                                btn1.className = "btn btn-sm btn-danger";
                                btn1.innerHTML = "inactive";
                                btn1.setAttribute("onclick", "setUserStatus('" + o[x].sid + "', 'inactive')");

                                var br1 = document.createElement("br");
                                var br2 = document.createElement("br");

                                b1.appendChild(sp1)
                                td10.appendChild(b1);
                                td10.appendChild(br1);
                                td10.appendChild(br2);
                                td10.appendChild(btn1);

                            } else if (o[x].status == "inactive") {

                                var b2 = document.createElement("b");

                                var sp2 = document.createElement("span");
                                sp2.setAttribute("style", "color:#DC3545");
                                sp2.innerHTML = o[x].status;

                                var btn2 = document.createElement("button");
                                btn2.className = "btn btn-sm btn-info";
                                btn2.innerHTML = "active";
                                btn2.setAttribute("onclick", "setUserStatus('" + o[x].sid + "', 'approved')");

                                var br3 = document.createElement("br");
                                var br4 = document.createElement("br");

                                b2.appendChild(sp2);
                                td10.appendChild(b2);
                                td10.appendChild(br3);
                                td10.appendChild(br4);
                                td10.appendChild(btn2);
                            } else if (o[x].status == "pending") {

                                var b3 = document.createElement("b");

                                var sp3 = document.createElement("span");
                                sp3.setAttribute("style", "color:#FFC107 ");
                                sp3.innerHTML = o[x].status;

                                var btn3 = document.createElement("button");
                                btn3.className = "btn btn-sm btn-success";
                                btn3.innerHTML = "confirmed";
                                btn3.setAttribute("onclick", "setUserStatus('" + o[x].sid + "', 'approved')");

                                var br5 = document.createElement("br");
                                var br6 = document.createElement("br");

                                b3.appendChild(sp3);
                                td10.appendChild(b3);
                                td10.appendChild(br5);
                                td10.appendChild(br6);
                                td10.appendChild(btn3);

                            }




                            tr.appendChild(td1);
                            tr.appendChild(td01);
                            tr.appendChild(td2);
                            tr.appendChild(td3);
                            tr.appendChild(td4);
                            tr.appendChild(td5);
                            tr.appendChild(td6);
                            tr.appendChild(td7);
                            tr.appendChild(td8);

                            tr.appendChild(td10);

                            var tb = document.getElementById("userDataTable");

                            tb.appendChild(tr);
//


                        }

                    }
                };
                req.open("get", "loadMemberDataTable?json_str=" + json_str, true);
                req.send();
            }
            function setUserStatus(sid, status) {


                var json = {"mainST": "member", "uid": sid, "status": status};
                var json_str = JSON.stringify(json);

                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {

                    if (req.readyState == 4 && req.status == 200) {

                        var txt = req.responseText;
                        if (txt == 1) {


                            loadUserDataTable();
                        } else if (txt == 0) {

                        }

                    }
                };
                req.open("get", "setUserStatus?json_str=" + json_str, true);
                req.send();
            }
        </script>
    </body>
</html>
