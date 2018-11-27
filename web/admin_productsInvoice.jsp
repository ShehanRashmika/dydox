<%-- 
    Document   : admin_productsInvoice
    Created on : Jun 21, 2018, 6:12:39 PM
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
    <body onload="loadProductInvoiceTable();">
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
                                <li><a href="#">Invoices</a></li>
                                <li class="active">Products Invoices</li>
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
                                    <strong class="card-title">Products Invoices Table</strong>
                                </div>
                                <div class="card-body">
                                    <div class="card-body card-block">
                                        <form class="form-horizontal" onsubmit="return false">
                                            <div class="row form-group">
                                                <div class="col col-md-3">
                                                    <span>From</span><input id="date" type="date" class="form-control" onchange="">                                                
                                                </div>
                                                <div class="col col-md-3">
                                                    <span>To</span><input id="date2" type="date" class="form-control" onchange="loadProductInvoiceTable();">
                                                </div>

                                                <div class="col col-md-3">
                                                    <br>
                                                    <input id="searchByINV_ID" type="text" placeholder="Search By INV ID.." class="form-control" onkeyup="loadProductInvoiceTable()">
                                                </div>
                                                <div class="col col-md-3">
                                                    <br>

                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="all" name="1" checked onchange="loadProductInvoiceTable()">
                                                        <label class="custom-control-label" for="all">All</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="C_users" name="1"  onchange="loadProductInvoiceTable()">
                                                        <label class="custom-control-label" for="C_users">Done</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="I_users" name="1" onchange="loadProductInvoiceTable()">
                                                        <label class="custom-control-label" for="I_users">Pending</label>
                                                    </div>

                                                </div>



                                            </div>

                                        </form>
                                    </div>

                                    <table id="bootstrap-data-table" class="table table-striped table-bordered ">
                                        <thead>
                                            <tr>
                                                <th>INV ID</th>
                                                <th>Date</th>
                                                <th>Time</th>
                                                <th>Sub Total</th>
                                                <th>Additional</th>
                                                <th>Discount</th>
                                                <th>Total</th>
                                                <th>Status</th>
                                                <th>Pay</th>

                                            </tr>
                                        </thead>
                                        <tbody id="productsInvoiceTable">

                                        </tbody>
                                    </table>
                                    <div class="row">

                                        <button class="btn btn-info" onclick="printInvoiceTable();">PRINT INVOICE</button>
                                        <img id="loadPrint">
                                    </div> 
                                </div>
                            </div>
                        </div>


                    </div>
                </div><!-- .animated -->
            </div><!-- .content -->

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
                                            });
        </script>

        <%    } else {
                response.sendRedirect("admin_login.jsp");
            }

        %>
        <script type="text/javascript">

            function printInvoiceTable() {

                var tbl = document.getElementById("productsInvoiceTable");

                var arr_1 = [];
                var arr_2 = [];
                var arr_3 = [];
                var arr_4 = [];
                var arr_5 = [];
                var arr_6 = [];
                var arr_7 = [];
                var arr_8 = [];
                var row_count = tbl.rows.length;

                for (var x = 0; x < row_count; x++) {

                    var row = tbl.rows[x];
                    arr_1.push(row.cells[0].innerHTML);
                    arr_2.push(row.cells[1].innerHTML);
                    arr_3.push(row.cells[2].innerHTML);
                    arr_4.push(row.cells[3].innerHTML);
                    arr_5.push(row.cells[4].innerHTML);
                    arr_6.push(row.cells[5].innerHTML);
                    arr_7.push(row.cells[6].innerHTML);
                    arr_8.push(row.cells[7].innerHTML);



                }

                var json_obj = {"inv_id": arr_1, "date": arr_2, "time": arr_3, "sub_tot": arr_4, "addon": arr_5, "dis": arr_6, "tot": arr_7, "status": arr_8};
                var json_str = JSON.stringify(json_obj);

                var req = new XMLHttpRequest();
                document.getElementById("loadPrint").src = "images/loading_3.gif";
                req.onreadystatechange = function() {
                    // window.location = "pdf/x.pdf";
                    if (req.readyState == 4 && req.status == 200) {
                        document.getElementById("loadPrint").src = "";

                        window.open(req.responseText);
                        // window.location = req.responseText;
                    }
                };

                req.open("get", "jasper_productInvoice?json_str=" + json_str, true);
                req.send();


            }




            function loadProductInvoiceTable() {
                document.getElementById("productsInvoiceTable").innerHTML = "";

                var date = document.getElementById("date").value;
                var date2 = document.getElementById("date2").value;
                var inv_id = document.getElementById("searchByINV_ID").value;



                var r1 = document.getElementById("all").checked;
                var r2 = document.getElementById("C_users").checked;
                var r3 = document.getElementById("I_users").checked;

                var userStatus = "";

                if (r1) {
                    userStatus = "all";

                }
                if (r2) {
                    userStatus = "done";
                }
                if (r3) {
                    userStatus = "pending";
                }


                var json = {"date": date, "date2": date2, "inv_id": inv_id, "status": userStatus};
                var json_str = JSON.stringify(json);

                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {

                    if (req.readyState == 4 && req.status == 200) {


                        var o = JSON.parse(req.responseText);//responce eke ena txt eka aye object ekakata cast krnwa
                        for (x in o) {


                            var tr = document.createElement("tr");

                            var td1 = document.createElement("td");
                            td1.innerHTML = o[x].inv_id;

                            var td3 = document.createElement("td");
                            td3.innerHTML = o[x].date;

                            var td4 = document.createElement("td");
                            td4.innerHTML = o[x].time;

                            var td5 = document.createElement("td");
                            td5.innerHTML = "$" + o[x].sub;

                            var td6 = document.createElement("td");
                            td6.innerHTML = "$" + o[x].addon;

                            var td8 = document.createElement("td");
                            td8.innerHTML = "$" + o[x].dis;

                            var td9 = document.createElement("td");
                            td9.innerHTML = "$" + o[x].total;


                            var td7 = document.createElement("td");
                            var td10 = document.createElement("td");



                            if (o[x].inv_status == "done") {


                                var btn1 = document.createElement("button");
                                btn1.className = "btn btn-sm btn-info";
                                btn1.innerHTML = "Pay To Seller";
                                btn1.setAttribute("data-target", "#" + o[x].inv_id);
                                btn1.setAttribute("data-toggle", "modal");


                                td7.innerHTML = o[x].inv_status;
                                td7.setAttribute("style", "color:#28A745;");
                                td10.appendChild(btn1);

//-----------------------------------model-----------------------------------------
                                var div11 = document.createElement("div");
                                div11.className = "modal fade bd-example-modal-lg";

                                div11.setAttribute("id", o[x].inv_id);
                                div11.setAttribute("tabindex", "-1");
                                div11.setAttribute("role", "dialog");
                                div11.setAttribute("aria-labelledby", "exampleModalLongTitle");
                                div11.setAttribute("aria-hidden", "true");

                                var div22 = document.createElement("div");
                                div22.className = "modal-dialog  modal-lg";
                                div22.setAttribute("role", "document");

                                var div33 = document.createElement("div");
                                div33.className = "modal-content";

                                var div44 = document.createElement("div");
                                div44.className = "modal-header";

                                var h1 = document.createElement("h5");
                                h1.className = "modal-title";
                                h1.id = "exampleModalLongTitle";
                                h1.setAttribute("style", "text-transform: uppercase");
                                h1.innerHTML = "Invoice NO " + o[x].inv_id;

                                var btn11 = document.createElement("button");
                                btn11.className = "close";
                                btn11.setAttribute("type", "button");
                                btn11.setAttribute("data-dismiss", "modal");
                                btn11.setAttribute("aria-label", "Close");

                                div44.appendChild(h1);
                                div44.appendChild(btn11);
//-----------------------model body-----------------------------
                                var div55 = document.createElement("div");
                                div55.className = "modal-body";

                                var div_tb1 = document.createElement("div");
                                div_tb1.className = "content mt-3";

                                var div_tb2 = document.createElement("div");
                                div_tb2.className = "animated fadeIn";

                                var div_tb3 = document.createElement("div");
                                div_tb3.className = "row";

                                var div_tb4 = document.createElement("div");
                                div_tb4.className = "col-md-12";

                                var div_tb5 = document.createElement("div");
                                div_tb5.className = "card";

                                var div_tb6 = document.createElement("div");
                                div_tb6.className = "card-header";

                                var div_txt1 = document.createElement("strong");
                                div_txt1.className = "card-title";
                                div_txt1.innerHTML = "Invoice Products";

                                div_tb6.appendChild(div_txt1);


                                var div_tb7 = document.createElement("div");
                                div_tb7.className = "card-body";

                                var div_tbl = document.createElement("table");
                                div_tbl.setAttribute("id", "bootstrap-data-table");
                                div_tbl.className = "table table-striped table-bordered ";

                                var div_tb_head = document.createElement("thead");
                                var div_tb_tr1 = document.createElement("tr");

                                var div_tb_th1 = document.createElement("th");
                                div_tb_th1.innerHTML = "PID";

                                var div_tb_th2 = document.createElement("th");
                                div_tb_th2.innerHTML = "Title";

                                var div_tb_th3 = document.createElement("th");
                                div_tb_th3.innerHTML = "SID";

                                var div_tb_th4 = document.createElement("th");
                                div_tb_th4.innerHTML = "Seller Name";

                                var div_tb_th5 = document.createElement("th");
                                div_tb_th5.innerHTML = "Email";

                                var div_tb_th6 = document.createElement("th");
                                div_tb_th6.innerHTML = "Pay";

                                div_tb_tr1.appendChild(div_tb_th1);
                                div_tb_tr1.appendChild(div_tb_th2);
                                div_tb_tr1.appendChild(div_tb_th3);
                                div_tb_tr1.appendChild(div_tb_th4);
                                div_tb_tr1.appendChild(div_tb_th5);
                                div_tb_tr1.appendChild(div_tb_th6);

                                div_tb_head.appendChild(div_tb_tr1);

                                div_tbl.appendChild(div_tb_head);


                                var div_tbody = document.createElement("tbody");

                                for (k in o[x].product_list) {

                                    var div_tb_tr2 = document.createElement("tr");

                                    var div_tb_td1 = document.createElement("td");
                                    div_tb_td1.innerHTML = o[x].product_list[k].pid;

                                    var div_tb_td2 = document.createElement("td");
                                    div_tb_td2.innerHTML = o[x].product_list[k].title;


                                    var div_tb_td3 = document.createElement("td");
                                    div_tb_td3.innerHTML = o[x].product_list[k].sid;


                                    var div_tb_td4 = document.createElement("td");
                                    div_tb_td4.innerHTML = o[x].product_list[k].s_name;


                                    var div_tb_td5 = document.createElement("td");
                                    div_tb_td5.innerHTML = o[x].product_list[k].emails;

                                    var div_tb_td6 = document.createElement("td");

                                    var btn3 = document.createElement("a");
                                    btn3.className = "btn btn-sm btn-info btn-block";
                                    btn3.innerHTML = "Pay Now";
                                    btn3.setAttribute("href", "admin_sellerPayments.jsp?pid=" + o[x].product_list[k].pid + "&sid=" + o[x].product_list[k].sid);

                                    div_tb_td6.appendChild(btn3);

                                    div_tb_tr2.appendChild(div_tb_td1);
                                    div_tb_tr2.appendChild(div_tb_td2);
                                    div_tb_tr2.appendChild(div_tb_td3);
                                    div_tb_tr2.appendChild(div_tb_td4);
                                    div_tb_tr2.appendChild(div_tb_td5);
                                    div_tb_tr2.appendChild(div_tb_td6);

                                    div_tbody.appendChild(div_tb_tr2);

                                }
                                div_tbl.appendChild(div_tbody);



                                div_tb7.appendChild(div_tbl);
                                div_tb5.appendChild(div_tb6);
                                div_tb5.appendChild(div_tb7);
                                div_tb4.appendChild(div_tb5);
                                div_tb3.appendChild(div_tb4);
                                div_tb2.appendChild(div_tb3);
                                div_tb1.appendChild(div_tb2);

                                div55.appendChild(div_tb1);





//-----------------------model body-----------------------------

                                var div66 = document.createElement("div");
                                div66.className = "modal-footer";

                                var btn22 = document.createElement("button");
                                btn22.className = "btn btn-secondary";
                                btn22.setAttribute("type", "button");
                                btn22.setAttribute("data-dismiss", "modal");
                                btn22.setAttribute("onclick", "window.location='admin_productsInvoice.jsp';");
                                btn22.innerHTML = "Close";



                                div66.appendChild(btn22);
                                div33.appendChild(div44);
                                div33.appendChild(div55);
                                div33.appendChild(div66);
                                div22.appendChild(div33);
                                div11.appendChild(div22);
                                document.getElementById("test").appendChild(div11);

//------------------------------------------------model----------------------------
                            } else if (o[x].inv_status == "pending") {


                                var sp3 = document.createElement("span");
                                sp3.setAttribute("style", "color:#DC3545;");
                                sp3.innerHTML = "Waiting..";

                                td7.innerHTML = o[x].inv_status;
                                td7.setAttribute("style", "color:#DC3545;");
                                td10.appendChild(sp3);
                            }




                            tr.appendChild(td1);
                            tr.appendChild(td3);
                            tr.appendChild(td4);
                            tr.appendChild(td5);
                            tr.appendChild(td6);
                            tr.appendChild(td8);
                            tr.appendChild(td9);
                            tr.appendChild(td7);
                            tr.appendChild(td10);

                            var tb = document.getElementById("productsInvoiceTable");

                            tb.appendChild(tr);
//


                        }

                    }
                };
                req.open("get", "loadProductsInvoiceTable?json_str=" + json_str, true);
                req.send();

            }

        </script>

    </body>
</html>
