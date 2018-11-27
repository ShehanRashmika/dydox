<%-- 
    Document   : admin_allProducts
    Created on : Jun 18, 2018, 6:48:01 PM
    Author     : Sheha
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="pojos.SfCategory"%>
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
        </style>
    </head>
    <body onload="loadAllProductsTable()">
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
        <div id="test"></div>
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
                                <li><a href="#">Products</a></li>
                                <li class="active">All Products</li>
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
                                    <strong class="card-title">All Products List</strong>
                                </div>
                                <div class="card-body">
                                    <div class="card-body card-block">
                                        <form class="form-horizontal" onsubmit="return false">
                                            <div class="row form-group">
                                                <div class="col col-md-2"><input id="searchById" type="text" placeholder="Search By PID.." class="form-control" onkeyup="loadAllProductsTable();"></div>
                                                <div class="col col-md-2"><input id="searchByName" type="text" placeholder="Search By Title.." class="form-control" onkeyup="loadAllProductsTable();"></div>

                                                <div class="col col-md-3">
                                                    <select name="select" id="catageorySelect" class="form-control" onchange="loadAllProductsTable();">
                                                        <option value="0">Search by category</option>
                                                        <%                                                            Criteria c = s.createCriteria(SfCategory.class);
                                                            List<SfCategory> list = null;
                                                            if (!c.list().isEmpty()) {
                                                                list = c.list();
                                                                for (SfCategory v : list) {
                                                        %>
                                                        <option value="<%=v.getIdsfCategory()%>"><%=v.getCategoryName()%></option>

                                                        <%
                                                                }
                                                            }

                                                        %>

                                                    </select>
                                                </div>


                                                <div class="col col-md-5">

                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="all" name="1" checked onchange="loadAllProductsTable()">
                                                        <label class="custom-control-label" for="all">All</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="C_users" name="1"  onchange="loadAllProductsTable()">
                                                        <label class="custom-control-label" for="C_users">Active</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="I_users" name="1" onchange="loadAllProductsTable()">
                                                        <label class="custom-control-label" for="I_users">Inactive</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="P_users" name="1" onchange="loadAllProductsTable()">
                                                        <label class="custom-control-label" for="P_users">Pending</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio my-1 mr-sm-2">
                                                        <input type="radio" class="custom-control-input" id="S_users" name="1" onchange="loadAllProductsTable()">
                                                        <label class="custom-control-label" for="S_users">Sold</label>
                                                    </div>



                                                </div>




                                            </div>

                                        </form>
                                    </div>


                                    <table id="bootstrap-data-table" class="table table-striped table-bordered ">


                                        <thead>
                                            <tr>
                                                <th>PID</th>
                                                <th>Image</th>
                                                <th>UID</th>
                                                <th>Image</th>
                                                <th>Title</th>
                                                <th>Category</th>
                                                <th>Add Date</th>
                                                <th>Sell Limit</th>
                                                <th>Price</th>
                                                <th>Status</th>
                                                <th>View</th>


                                            </tr>
                                        </thead>
                                        <tbody id="allProductTable">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>


                    </div>
                </div><!-- .animated -->
            </div><!-- .content -->

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

                function loadAllProductsTable() {


                    document.getElementById("allProductTable").innerHTML = "";

                    var name = document.getElementById("searchByName").value;
                    var id = document.getElementById("searchById").value;
                    var last = document.getElementById("catageorySelect").value;

                    var r1 = document.getElementById("all").checked;
                    var r2 = document.getElementById("C_users").checked;
                    var r3 = document.getElementById("I_users").checked;
                    var r4 = document.getElementById("P_users").checked;
                    var r5 = document.getElementById("S_users").checked;

                    var userStatus = "";

                    if (r1) {
                        userStatus = "all";

                    }
                    if (r2) {
                        userStatus = "active";
                    }
                    if (r3) {
                        userStatus = "inactive";
                    }
                    if (r4) {
                        userStatus = "pending";
                    }
                    if (r5) {
                        userStatus = "sold";
                    }

                    var json = {"title": name, "id": id, "cata": last, "status": userStatus};
                    var json_str = JSON.stringify(json);

                    var req = new XMLHttpRequest();
                    req.onreadystatechange = function() {

                        if (req.readyState == 4 && req.status == 200) {

                            var o = JSON.parse(req.responseText);//responce eke ena txt eka aye object ekakata cast krnwa

                            for (x in o) {
                                var tr = document.createElement("tr");


//---------------------------------------------model---------------------------
                                var br7 = document.createElement("br");

                                var btn4 = document.createElement("button");
                                btn4.className = "btn btn-sm btn-info";
                                btn4.innerHTML = " View ";
                                btn4.setAttribute("data-target", "#" + o[x].pid);
                                btn4.setAttribute("data-toggle", "modal");

                                var i1 = document.createElement("i");
                                i1.className = "fa fa-search";
                                btn4.appendChild(i1)
                                var td12 = document.createElement("td");
                                td12.appendChild(br7);
                                td12.appendChild(btn4);

                                var div11 = document.createElement("div");
                                div11.className = "modal fade bd-example-modal-lg";

                                div11.setAttribute("id", o[x].pid);
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
                                h1.innerHTML = o[x].title;

                                var btn11 = document.createElement("button");
                                btn11.className = "close";
                                btn11.setAttribute("type", "button");
                                btn11.setAttribute("data-dismiss", "modal");
                                btn11.setAttribute("aria-label", "Close");

                                div44.appendChild(h1);
                                div44.appendChild(btn11);

//                -------------------------------model body--------------------------

                                var div55 = document.createElement("div");
                                div55.className = "modal-body";

                                var body_br1 = document.createElement("br");
                                var body_br2 = document.createElement("br");
                                var body_br3 = document.createElement("br");
                                var body_br4 = document.createElement("br");
                                var body_br5 = document.createElement("br");
                                var body_br6 = document.createElement("br");
                                var body_br7 = document.createElement("br");
                                var body_br8 = document.createElement("br");
                                var body_br9 = document.createElement("br");
                                var body_br10 = document.createElement("br");
                                var body_br11 = document.createElement("br");

                                var body_div1 = document.createElement("div");
                                body_div1.className = "form-area";

                                var body_form = document.createElement("form");

                                var body_div2 = document.createElement("div");
                                body_div2.className = "form-group";

                                var body_input = document.createElement("input");
                                body_input.className = "form-control disabled";
                                body_input.setAttribute("type", "text");
                                body_input.setAttribute("disabled", "");
                                body_input.setAttribute("id", "pid" + o[x].pid);
                                body_input.value = o[x].pid;

                                body_div2.appendChild(body_input);
                                body_form.appendChild(body_div2);
                                body_div2.appendChild(body_br1);
                                body_div1.appendChild(body_form);




                                var body_div3 = document.createElement("div");
                                body_div3.className = "form-area";

                                var body_form = document.createElement("form");

                                var body_div4 = document.createElement("div");
                                body_div4.className = "form-group";

                                var body_input2 = document.createElement("input");
                                body_input2.className = "form-control";
                                body_input2.setAttribute("type", "text");
                                body_input2.setAttribute("id", "title" + o[x].pid);
                                body_input2.value = o[x].title;

                                body_div2.appendChild(body_input2);
                                body_form.appendChild(body_div4);
                                body_div3.appendChild(body_form);


                                var body_div5 = document.createElement("div");
                                body_div5.className = "input-group";

                                var body_select = document.createElement("select");
                                body_select.className = "custom-select";
                                body_select.setAttribute("id", "cata_select" + o[x].pid);


                                for (var i = 0; i < o[x].all_cataList.length; i++) {
                                    var val = o[x].all_cataList[i];

                                    var op = document.createElement("option");
                                    op.setAttribute("value", o[x].cata.split(",")[1]);
                                    if (val.split(",")[0] == o[x].cata.split(",")[0]) {

                                        op.setAttribute("selected", "selected")
                                    }
                                    op.innerHTML = val.split(",")[0];
                                    op.value = val.split(",")[1];
                                    body_select.appendChild(op);

                                }



                                body_div5.appendChild(body_select);



                                var body_div6 = document.createElement("div");
                                body_div6.className = "form-group";

                                var body_input3 = document.createElement("input");
                                body_input3.className = "form-control";
                                body_input3.setAttribute("type", "text");
                                body_input3.setAttribute("id", "langu" + o[x].pid);
                                body_input3.value = o[x].langu;

                                body_div6.appendChild(body_br2);
                                body_div6.appendChild(body_input3);
                                body_form.appendChild(body_div6);


                                var body_div7 = document.createElement("div");
                                body_div7.className = "form-group";

                                var body_textarea1 = document.createElement("textarea");
                                body_textarea1.className = "form-control";
                                body_textarea1.setAttribute("type", "textarea");
                                body_textarea1.setAttribute("rows", "3");
                                body_textarea1.setAttribute("id", "small_des" + o[x].pid);
                                body_textarea1.value = o[x].small_des;


                                body_div7.appendChild(body_textarea1);
                                body_form.appendChild(body_div7);


                                var body_div8 = document.createElement("div");
                                body_div8.className = "form-group";

                                var body_input4 = document.createElement("input");
                                body_input4.className = "form-control";
                                body_input4.setAttribute("type", "text");
                                body_input4.setAttribute("id", "sf_type" + o[x].pid);
                                body_input4.value = o[x].sf_type;


                                body_div8.appendChild(body_input4);
                                body_form.appendChild(body_div8);

                                var body_div9 = document.createElement("div");

                                var body_lbl1 = document.createElement("label");
                                body_lbl1.className = "label-info";
                                body_lbl1.innerHTML = "Software Platform";


                                var divOut = document.createElement("div");
//                                divOut.className = "container";

                                var divIN = document.createElement("div");
//                                divIN.className = "row";

                                var name;
                                var id;
                                for (var j = 0; j < o[x].all_platformList.length; j++) {

                                    name = o[x].all_platformList[j].split(",")[0];
                                    id = o[x].all_platformList[j].split(",")[1];

                                    var body_input5 = document.createElement("input");
                                    body_input5.setAttribute("name", "platform" + o[x].pid);
                                    body_input5.setAttribute("type", "checkbox");
                                    body_input5.setAttribute("id", id + "x");
                                    body_input5.setAttribute("value", id + "_" + o[x].pid);


                                    var body_lbl2 = document.createElement("label");
                                    body_lbl2.setAttribute("for", id + "x");
                                    body_lbl2.innerHTML = name + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

                                    divIN.appendChild(body_input5);
                                    divIN.appendChild(body_lbl2);




                                }
                                divOut.appendChild(divIN);
                                body_div9.appendChild(divOut);


                                var body_div10 = document.createElement("div");

                                var body_lbl2 = document.createElement("label");
                                body_lbl2.className = "label-info";
                                body_lbl2.innerHTML = "Software Platform";

                                var divOut2 = document.createElement("div");
//                                divOut2.className = "container";

                                var divIN2 = document.createElement("div");
//                                divIN2.className = "row";

                                var name2;
                                var id2;
                                for (var j = 0; j < o[x].all_osList.length; j++) {

                                    name2 = o[x].all_osList[j].split(",")[0];
                                    id2 = o[x].all_osList[j].split(",")[1];

                                    var body_input6 = document.createElement("input");
                                    body_input6.setAttribute("name", "os" + o[x].pid);
                                    body_input6.setAttribute("type", "checkbox");
                                    body_input6.setAttribute("id", id2 + "x");
                                    body_input6.setAttribute("value", id2 + "_" + o[x].pid);


                                    var body_lbl3 = document.createElement("label");
                                    body_lbl3.setAttribute("for", id2 + "x");
                                    body_lbl3.innerHTML = name2 + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

                                    divIN2.appendChild(body_input6);
                                    divIN2.appendChild(body_lbl3);




                                }
                                divOut2.appendChild(divIN2);
                                body_div10.appendChild(divOut2);


                                var body_div11 = document.createElement("div");
                                body_div11.className = "form-group";

                                var body_textarea2 = document.createElement("textarea");
                                body_textarea2.className = "form-control";
                                body_textarea2.setAttribute("type", "textarea");
                                body_textarea2.setAttribute("rows", "6");
                                body_textarea2.setAttribute("id", "brief_des" + o[x].pid);
                                body_textarea2.value = o[x].brief_des;


                                body_div11.appendChild(body_textarea2);
                                body_form.appendChild(body_div11);




                                var body_div12 = document.createElement("div");
                                body_div12.className = "form-group";

                                var body_textarea3 = document.createElement("textarea");
                                body_textarea3.className = "form-control";
                                body_textarea3.setAttribute("type", "textarea");
                                body_textarea3.setAttribute("rows", "3");
                                body_textarea3.setAttribute("id", "features" + o[x].pid);

                                for (var d = 0; d < o[x].features.length; d++) {
                                    if (o[x].features.length - 1 == d) {
                                        body_textarea3.value += o[x].features[d].trim();

                                    } else {

                                        body_textarea3.value += o[x].features[d].trim() + ", \n";

                                    }
                                }


                                body_div12.appendChild(body_textarea3);
                                body_form.appendChild(body_div12);

                                var body_div13 = document.createElement("div");

                                var body_input7 = document.createElement("input");
                                body_input7.setAttribute("name", "return");
                                body_input7.setAttribute("type", "checkbox");
                                body_input7.setAttribute("id", "return_a" + o[x].pid);

                                var body_lbl4 = document.createElement("label");
                                body_lbl4.setAttribute("for", "return_a" + o[x].pid);
                                body_lbl4.innerHTML = "Return Accept";


                                body_div13.appendChild(body_input7);
                                body_div13.appendChild(body_lbl4);


                                var body_div15 = document.createElement("div");
                                body_div15.className = "form-group";

                                var body_input8 = document.createElement("input");
                                body_input8.className = "form-control disabled";
                                body_input8.setAttribute("type", "text");
                                body_input8.setAttribute("disabled", "");
                                body_input8.value = o[x].add_date;

                                body_div15.appendChild(body_input8);
                                body_form.appendChild(body_div15);


                                var body_div16 = document.createElement("div");

                                var body_input9 = document.createElement("input");
                                body_input9.setAttribute("name", "sellTime");
                                body_input9.setAttribute("type", "checkbox");
                                body_input9.setAttribute("id", "no_limit" + o[x].pid);

                                var body_lbl5 = document.createElement("label");
                                body_lbl5.setAttribute("for", "no_limit" + o[x].pid);
                                body_lbl5.innerHTML = "No Limit &nbsp;&nbsp;&nbsp;&nbsp;";


                                body_div16.appendChild(body_input9);
                                body_div16.appendChild(body_lbl5);

                                var body_input10 = document.createElement("input");
                                body_input10.setAttribute("name", "sellTime");
                                body_input10.setAttribute("type", "checkbox");
                                body_input10.setAttribute("id", "one_time" + o[x].pid);

                                var body_lbl6 = document.createElement("label");
                                body_lbl6.setAttribute("for", "one_time" + o[x].pid);
                                body_lbl6.innerHTML = "One Time ";


                                body_div16.appendChild(body_input10);
                                body_div16.appendChild(body_lbl6);


                                var body_div17 = document.createElement("div");
                                body_div17.className = "form-group";

                                var body_in1 = document.createElement("div");
                                body_in1.className = "input-group-prepend";

                                var body_span1 = document.createElement("span");
                                body_span1.innerHTML = "Addtional Price";

                                var body_span2 = document.createElement("span");
                                body_span2.className = "input-group-text";
                                body_span2.setAttribute("id", "basic-addon1");
                                body_span2.innerHTML = "$";

                                var body_input10 = document.createElement("input");
                                body_input10.className = "form-control";
                                body_input10.setAttribute("type", "text");
                                body_input10.setAttribute("id", "addon" + o[x].pid);
                                body_input10.value = o[x].addon;

                                body_in1.appendChild(body_span2);
                                body_in1.appendChild(body_input10);
                                body_div17.appendChild(body_span1);
                                body_div17.appendChild(body_in1);
                                body_form.appendChild(body_div17);



                                var body_div18 = document.createElement("div");
                                body_div18.className = "form-group";

                                var body_in2 = document.createElement("div");
                                body_in2.className = "input-group-prepend";

                                var body_span3 = document.createElement("span");
                                body_span3.innerHTML = "Discount Price";

                                var body_span4 = document.createElement("span");
                                body_span4.className = "input-group-text";
                                body_span4.setAttribute("id", "basic-addon1");
                                body_span4.innerHTML = "$";

                                var body_input11 = document.createElement("input");
                                body_input11.className = "form-control";
                                body_input11.setAttribute("type", "text");
                                body_input11.setAttribute("id", "dis" + o[x].pid);
                                body_input11.value = o[x].dis;

                                body_in2.appendChild(body_span4);
                                body_in2.appendChild(body_input11);
                                body_div18.appendChild(body_span3);
                                body_div18.appendChild(body_in2);
                                body_form.appendChild(body_div18);




                                var body_div19 = document.createElement("div");
                                body_div19.className = "form-group";

                                var body_in3 = document.createElement("div");
                                body_in3.className = "input-group-prepend";

                                var body_span5 = document.createElement("span");
                                body_span5.innerHTML = "Product Price";

                                var body_span6 = document.createElement("span");
                                body_span6.className = "input-group-text";
                                body_span6.setAttribute("id", "basic-addon1");
                                body_span6.innerHTML = "$";

                                var body_input12 = document.createElement("input");
                                body_input12.className = "form-control";
                                body_input12.setAttribute("type", "text");
                                body_input12.setAttribute("id", "price" + o[x].pid);
                                body_input12.value = o[x].price;

                                body_in3.appendChild(body_span6);
                                body_in3.appendChild(body_input12);
                                body_div19.appendChild(body_span5);
                                body_div19.appendChild(body_in3);
                                body_form.appendChild(body_div19);



                                var body_div20 = document.createElement("div");
                                body_div20.className = "form-group";

                                var body_span7 = document.createElement("span");
                                body_span7.innerHTML = "Last Update Date";


                                var body_input13 = document.createElement("input");
                                body_input13.className = "form-control disabled";
                                body_input13.setAttribute("type", "text");
                                body_input13.setAttribute("disabled", "");
                                body_input13.value = o[x].last_updateDate;

                                body_div20.appendChild(body_span7);
                                body_div20.appendChild(body_input13);
                                body_form.appendChild(body_div20);



                                var body_div21 = document.createElement("div");
                                body_div21.className = "form-group";

                                var body_img1 = document.createElement("img");
                                body_img1.className = "img-thumbnail";
                                body_img1.setAttribute("style", "max-height:200px;max-width:250px;min-height:200px;min-width:250px;");
                                body_img1.setAttribute("alt", "Responsive image");
                                body_img1.src = o[x].pimg;

                                body_div21.appendChild(body_img1);



                                var body_img2 = document.createElement("img");
                                body_img2.className = "img-thumbnail";
                                body_img2.setAttribute("style", "max-height:200px;max-width:250px;min-height:200px;min-width:250px;");
                                body_img2.setAttribute("alt", "Responsive image");
                                body_img2.src = o[x].pimg2;

                                body_div21.appendChild(body_img2);


                                var body_img3 = document.createElement("img");
                                body_img3.className = "img-thumbnail";
                                body_img3.setAttribute("style", "max-height:200px;max-width:250px;min-height:200px;min-width:250px;");
                                body_img3.setAttribute("alt", "Responsive image");
                                body_img3.src = o[x].pimg3;

                                body_div21.appendChild(body_img3);

                                body_form.appendChild(body_div21);


                                var body_div22 = document.createElement("div");
                                body_div22.className = "form-group";

                                var body_div23 = document.createElement("div");
                                body_div23.className = "embed-responsive embed-responsive-16by9";

                                var body_iframe = document.createElement("iframe");
                                body_iframe.className = "embed-responsive-item";
                                body_iframe.setAttribute("allowfullscreen", "");
                                body_iframe.src = o[x].video;

                                var body_input14 = document.createElement("input");
                                body_input14.className = "form-control ";
                                body_input14.setAttribute("type", "text");
                                body_input14.setAttribute("id", "videoURL" + o[x].pid);
                                body_input14.value = o[x].video;

                                body_div23.appendChild(body_iframe);
                                body_div22.appendChild(body_div23);
                                body_div22.appendChild(body_input14);
                                body_form.appendChild(body_div22);


                                var body_div24 = document.createElement("div");
                                body_div24.className = "form-group";

                                var body_h1 = document.createElement("h1");
                                body_h1.className = "h1";

                                var body_span8 = document.createElement("span");
                                body_span8.innerHTML = "Product Rate";


                                var star_1 = document.createElement("span");
                                var star_2 = document.createElement("span");
                                var star_3 = document.createElement("span");
                                var star_4 = document.createElement("span");
                                var star_5 = document.createElement("span");
                                var overoll_rate = o[x].overoll_rate;
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

                                body_h1.appendChild(star_1);
                                body_h1.appendChild(star_2);
                                body_h1.appendChild(star_3);
                                body_h1.appendChild(star_4);
                                body_h1.appendChild(star_5);
                                body_div24.appendChild(body_span8);
                                body_div24.appendChild(body_h1);
                                body_form.appendChild(body_div24);

                                var body_div25 = document.createElement("div");
                                body_div25.className = "form-group";


                                var msg_div = document.createElement("div");
                                msg_div.setAttribute("role", "alert");
                                msg_div.setAttribute("id", "alertMsg" + o[x].pid);

                                body_div25.appendChild(msg_div);


                                var body_div26 = document.createElement("div");
                                body_div26.className = "form-group";

                                var body_span9 = document.createElement("span");
                                body_span9.innerHTML = "Software Demo Zip &nbsp;&nbsp;&nbsp;";

                                var body_input15 = document.createElement("input");
                                body_input15.setAttribute("type", "file");
                                body_input15.setAttribute("accept", "application/zip,application/rar");
                                body_input15.setAttribute("id", "demo" + o[x].pid);


                                body_div26.appendChild(body_span9);
                                body_div26.appendChild(body_input15);
                                body_form.appendChild(body_div26);

                                var body_div27 = document.createElement("div");
                                body_div27.className = "form-group";

                                var body_span10 = document.createElement("span");
                                body_span10.innerHTML = "Software Original Zip ";

                                var body_input16 = document.createElement("input");
                                body_input16.setAttribute("type", "file");
                                body_input16.setAttribute("accept", "application/zip,application/rar");
                                body_input16.setAttribute("id", "original" + o[x].pid);


                                body_div27.appendChild(body_span10);
                                body_div27.appendChild(body_input16);
                                body_form.appendChild(body_div27);

                                var body_div28 = document.createElement("div");
                                body_div28.className = "form-group";

                                var body_span11 = document.createElement("span");
                                body_span11.innerHTML = "Software SRS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

                                var body_input17 = document.createElement("input");
                                body_input17.setAttribute("type", "file");
                                body_input17.setAttribute("accept", "application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document");
                                body_input17.setAttribute("id", "srs" + o[x].pid);


                                body_div28.appendChild(body_span11);
                                body_div28.appendChild(body_input17);
                                body_form.appendChild(body_div28);

                                var body_div29 = document.createElement("div");
                                body_div29.className = "form-group";

                                var body_span12 = document.createElement("span");
                                body_span12.innerHTML = "Image 1 &nbsp;";

                                var body_input18 = document.createElement("input");
                                body_input18.setAttribute("type", "file");
                                body_input18.setAttribute("accept", "image/*");
                                body_input18.setAttribute("id", "img1" + o[x].pid);


                                body_div29.appendChild(body_span12);
                                body_div29.appendChild(body_input18);
                                body_form.appendChild(body_div29);


                                var body_div30 = document.createElement("div");
                                body_div30.className = "form-group";

                                var body_span13 = document.createElement("span");
                                body_span13.innerHTML = "Image 2 &nbsp;";

                                var body_input19 = document.createElement("input");
                                body_input19.setAttribute("type", "file");
                                body_input19.setAttribute("accept", "image/*");
                                body_input19.setAttribute("id", "img2" + o[x].pid);


                                body_div30.appendChild(body_span13);
                                body_div30.appendChild(body_input19);
                                body_form.appendChild(body_div30);

                                body_div1.appendChild(body_form);

                                var body_div31 = document.createElement("div");
                                body_div31.className = "form-group";

                                var body_span14 = document.createElement("span");
                                body_span14.innerHTML = "Image 3 &nbsp";

                                var body_input20 = document.createElement("input");
                                body_input20.setAttribute("type", "file");
                                body_input20.setAttribute("accept", "image/*");
                                body_input20.setAttribute("id", "img3" + o[x].pid);


                                body_div31.appendChild(body_span14);
                                body_div31.appendChild(body_input20);
                                body_form.appendChild(body_div31);


                                div55.appendChild(body_div2);
                                div55.appendChild(body_div5);
                                div55.appendChild(body_div6);
                                div55.appendChild(body_div7);
                                div55.appendChild(body_div8);
                                div55.appendChild(body_div9);
                                div55.appendChild(body_div10);
                                div55.appendChild(body_div1);
                                div55.appendChild(body_div13);
                                div55.appendChild(body_div16);
                                div55.appendChild(body_div25);


//                -------------------------------model body--------------------------

                                var div66 = document.createElement("div");
                                div66.className = "modal-footer";

                                var btn22 = document.createElement("button");
                                btn22.className = "btn btn-secondary";
                                btn22.setAttribute("type", "button");
                                btn22.setAttribute("data-dismiss", "modal");
                                btn22.setAttribute("onclick", "window.location='admin_allProducts.jsp';");
                                btn22.innerHTML = "Close";

                                var btn33 = document.createElement("button");
                                btn33.className = "btn btn-info";
                                btn33.setAttribute("type", "button");
                                btn33.setAttribute("onclick", "update('" + o[x].pid + "');");
                                btn33.innerHTML = "Update";






                                div66.appendChild(btn22);
                                div66.appendChild(btn33);
                                div33.appendChild(div44);
                                div33.appendChild(div55);
                                div33.appendChild(div66);
                                div22.appendChild(div33);
                                div11.appendChild(div22);
                                document.getElementById("test").appendChild(div11);





                                if (o[x].return) {
                                    document.getElementById("return_a" + o[x].pid).checked = "true";
                                }


                                var checkboxes_1 = document.querySelectorAll('input[type=checkbox][name=platform' + o[x].pid + ']')
                                for (var k = 0; k < o[x].platform.length; k++) {

                                    var pro_name = o[x].platform[k].split(",")[0];
                                    var pro_id = o[x].platform[k].split(",")[1];

                                    for (var i = 0; i < checkboxes_1.length; i++) {

                                        var lastVal = pro_id + "_" + o[x].pid;
                                        if (lastVal == checkboxes_1[i].value) {
                                            checkboxes_1[i].checked = "true";

                                        }

                                    }
                                }

                                if (o[x].sell) {
                                    document.getElementById("no_limit" + o[x].pid).checked = "true";


                                } else {

                                    document.getElementById("one_time" + o[x].pid).checked = "true";


                                }
                                $('input[type="checkbox"][name=sellTime]').on('change', function() {
                                    $('input[name="' + this.name + '"]').not(this).prop('checked', false);
                                });

                                var checkboxes_2 = document.querySelectorAll('input[type=checkbox][name=os' + o[x].pid + ']')
                                for (var k2 = 0; k2 < o[x].os.length; k2++) {

                                    var pro_name2 = o[x].os[k2].split(",")[0];
                                    var pro_id2 = o[x].os[k2].split(",")[1];
//                                        alert(pro_name2);

                                    for (var i2 = 0; i2 < checkboxes_2.length; i2++) {

                                        var lastVal2 = pro_id2 + "_" + o[x].pid;
                                        if (lastVal2 == checkboxes_2[i2].value) {
//                                           alert(pro_id);
                                            checkboxes_2[i2].checked = "true";

                                        }

                                    }
                                }

//-------------------------------model------------------------------------------

                                var td1 = document.createElement("td");
                                td1.innerHTML = o[x].pid;


                                var div1 = document.createElement("div");
                                div1.className = "photo";

                                var div2 = document.createElement("div");
                                div2.className = "avatar";
                                div2.setAttribute("style", "background-image: url('" + o[x].pimg + "')")

                                div1.appendChild(div2);


                                var td2 = document.createElement("td");
                                td2.appendChild(div1);


                                var td3 = document.createElement("td");
                                td3.innerHTML = o[x].uid;

                                var div3 = document.createElement("div");
                                div3.className = "photo";

                                var div4 = document.createElement("div");
                                div4.className = "avatar";
                                div4.setAttribute("style", "background-image: url('" + o[x].uimg + "')")

                                div3.appendChild(div4);


                                var td4 = document.createElement("td");
                                td4.appendChild(div3);

                                var td5 = document.createElement("td");
                                td5.innerHTML = o[x].title;

                                var td6 = document.createElement("td");
                                td6.innerHTML = o[x].cata;

                                var td7 = document.createElement("td");
                                td7.innerHTML = o[x].add_date;

                                var td9 = document.createElement("td");
                                if (o[x].sell) {
                                    td9.innerHTML = "noLimit";

                                } else {

                                    td9.innerHTML = "oneTime";

                                }

                                var td10 = document.createElement("td");
                                td10.innerHTML = "$" + o[x].price;




                                var td11 = document.createElement("td");

                                if (o[x].status == "active") {

                                    var b1 = document.createElement("b");

                                    var sp1 = document.createElement("span");
                                    sp1.setAttribute("style", "color:#28A745");
                                    sp1.innerHTML = o[x].status;

                                    var btn1 = document.createElement("button");
                                    btn1.className = "btn btn-sm btn-danger btn-block";
                                    btn1.innerHTML = "inactive";
                                    btn1.setAttribute("onclick", "setUserStatus('" + o[x].pid + "', 'inactive')");

                                    var br1 = document.createElement("br");
                                    var br2 = document.createElement("br");

                                    b1.appendChild(sp1)
                                    td11.appendChild(b1);
                                    td11.appendChild(br1);
                                    td11.appendChild(br2);
                                    td11.appendChild(btn1);

                                } else if (o[x].status == "inactive") {

                                    var b2 = document.createElement("b");

                                    var sp2 = document.createElement("span");
                                    sp2.setAttribute("style", "color:#DC3545");
                                    sp2.innerHTML = o[x].status;

                                    var btn2 = document.createElement("button");
                                    btn2.className = "btn btn-sm btn-info btn-block";
                                    btn2.innerHTML = "active";
                                    btn2.setAttribute("onclick", "setUserStatus('" + o[x].pid + "', 'active')");

                                    var br3 = document.createElement("br");
                                    var br4 = document.createElement("br");

                                    b2.appendChild(sp2);
                                    td11.appendChild(b2);
                                    td11.appendChild(br3);
                                    td11.appendChild(br4);
                                    td11.appendChild(btn2);
                                } else if (o[x].status == "pending") {

                                    var b3 = document.createElement("b");

                                    var sp3 = document.createElement("span");
                                    sp3.setAttribute("style", "color:#FFC107 ");
                                    sp3.innerHTML = o[x].status;

                                    var btn3 = document.createElement("button");
                                    btn3.className = "btn btn-sm btn-success btn-block";
                                    btn3.innerHTML = "confirmed";
                                    btn3.setAttribute("onclick", "setUserStatus('" + o[x].pid + "', 'active')");

                                    var br5 = document.createElement("br");
                                    var br6 = document.createElement("br");

                                    var btn4 = document.createElement("button");
                                    btn4.className = "btn btn-sm btn-warning btn-block";
                                    btn4.innerHTML = "&nbsp;Reject&nbsp;";
                                    btn4.setAttribute("onclick", "setUserStatus('" + o[x].pid + "', 'rejected')");
                                    btn4.setAttribute("style", "color:white;");
                                    var br7 = document.createElement("br");
                                    var br8 = document.createElement("br");

                                    b3.appendChild(sp3);
                                    td11.appendChild(b3);
                                    td11.appendChild(br5);
                                    td11.appendChild(br5);
                                    td11.appendChild(br6);
                                    td11.appendChild(btn3);
                                    td11.appendChild(br7);
                                    td11.appendChild(br8);
                                    td11.appendChild(btn4);

                                } else if (o[x].status == "sold") {

                                    var b3 = document.createElement("b");

                                    var sp3 = document.createElement("span");
                                    sp3.setAttribute("style", "color:#007BFF ");
                                    sp3.innerHTML = o[x].status;


                                    var br5 = document.createElement("br");
                                    var br6 = document.createElement("br");

                                    b3.appendChild(sp3);
                                    td11.appendChild(b3);
                                    td11.appendChild(br5);
                                    td11.appendChild(br6);


                                } else if (o[x].status == "rejected") {

                                    var b3 = document.createElement("b");

                                    var sp3 = document.createElement("span");
                                    sp3.setAttribute("style", "color:#E74C3C");
                                    sp3.innerHTML = o[x].status;


                                    var br5 = document.createElement("br");
                                    var br6 = document.createElement("br");

                                    b3.appendChild(sp3);
                                    td11.appendChild(b3);
                                    td11.appendChild(br5);
                                    td11.appendChild(br6);


                                }





                                tr.appendChild(td1);
                                tr.appendChild(td2);
                                tr.appendChild(td3);
                                tr.appendChild(td4);
                                tr.appendChild(td5);
                                tr.appendChild(td6);
                                tr.appendChild(td7);

                                tr.appendChild(td9);
                                tr.appendChild(td10);
                                tr.appendChild(td11);
                                tr.appendChild(td12);

                                var tb = document.getElementById("allProductTable");

                                tb.appendChild(tr);

//


                            }

                        }
                    };
                    req.open("get", "loadAllProductsTable?json_str=" + json_str, true);
                    req.send();
                }
                function setUserStatus(sid, status) {


                    var json = {"mainST": "product", "uid": sid, "status": status};
                    var json_str = JSON.stringify(json);

                    var req = new XMLHttpRequest();
                    req.onreadystatechange = function() {

                        if (req.readyState == 4 && req.status == 200) {

                            var txt = req.responseText;
                            if (txt == 1) {


                                loadAllProductsTable();
                            } else if (txt == 0) {

                            }

                        }
                    };
                    req.open("get", "setUserStatus?json_str=" + json_str, true);
                    req.send();
                }
                function update(pid) {


                    var msg = document.getElementById("alertMsg" + pid);

                    var title = document.getElementById("title" + pid).value;
                    var cata = document.getElementById("cata_select" + pid).value;
                    var langu = document.getElementById("langu" + pid).value;
                    var small_des = document.getElementById("small_des" + pid).value;
                    var sf_type = document.getElementById("sf_type" + pid).value;
                    var brief_des = document.getElementById("brief_des" + pid).value;
                    var features = document.getElementById("features" + pid).value;
                    var addon = document.getElementById("addon" + pid).value;
                    var dis = document.getElementById("dis" + pid).value;
                    var price = document.getElementById("price" + pid).value;
                    var videoURL = document.getElementById("videoURL" + pid).value;



                    var array_platform = []
                    var checkboxes_1 = document.querySelectorAll('input[type=checkbox][name=platform' + pid + ']:checked')

                    for (var i = 0; i < checkboxes_1.length; i++) {
                        array_platform.push(checkboxes_1[i].value.split("_")[0]);
                    }


                    var array_os = []
                    var checkboxes_2 = document.querySelectorAll('input[type=checkbox][name=os' + pid + ']:checked')

                    for (var i = 0; i < checkboxes_2.length; i++) {
                        array_os.push(checkboxes_2[i].value.split("_")[0])
                    }


                    var return_a = document.getElementById("return_a" + pid).checked;

                    var sellTime;
                    if (document.getElementById("one_time" + pid).checked) {
                        sellTime = "oneTime";
                    } else {

                        sellTime = "noLimit";
                    }

                    var demo_zip = document.getElementById("demo" + pid);
                    var original_zip = document.getElementById("original" + pid);
                    var srs = document.getElementById("srs" + pid);
                    var img1 = document.getElementById("img1" + pid);
                    var img2 = document.getElementById("img2" + pid);
                    var img3 = document.getElementById("img3" + pid);


                    var form = new FormData();

                    form.append("demo", demo_zip.files[0]);
                    form.append("original", original_zip.files[0]);
                    form.append("srs", srs.files[0]);
                    form.append("img1", img1.files[0]);
                    form.append("img2", img2.files[0]);
                    form.append("img3", img3.files[0]);


                    var json = {"pid": pid,
                        "title": title,
                        "cata": cata,
                        "langu": langu,
                        "small_des": small_des,
                        "brief_des": brief_des,
                        "sf_type": sf_type,
                        "features": features,
                        "addon": addon,
                        "dis": dis,
                        "price": price,
                        "platform": array_platform,
                        "os": array_os,
                        "return_a": return_a,
                        "sell_time": sellTime,
                        "videoURL": videoURL};

                    var json_str = JSON.stringify(json);

                    var req = new XMLHttpRequest();

                    req.onreadystatechange = function() {

                        if (req.readyState == 4 && req.status == 200) {
                            var txt = req.responseText;

                            if (txt == 1) {
                                msg.innerHTML = "Updated!";
                                msg.className = "alert alert-success";


                            } else if (txt == 0) {
                                msg.innerHTML = "Fill The Details!";
                                msg.className = "alert alert-danger";

                            }
                        }
                    };

                    req.open("post", "updateProduct?json_str=" + json_str, true);
                    req.send(form);
                }
            </script>

    </body>
</html>
