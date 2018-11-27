<%-- 
    Document   : admin_index
    Created on : Jun 14, 2018, 7:51:01 PM
    Author     : Sheha
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="pojos.Product"%>
<%@page import="pojos.SellerHasPackage"%>
<%@page import="pojos.InvoiceProductHasItem"%>
<%@page import="pojos.InvoicePackage"%>
<%@page import="pojos.InvoiceProduct"%>
<%@page import="java.util.List"%>
<%@page import="pojos.Seller"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="pojos.User"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="pojos.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                 <title>dydox.lk</title>
        <meta name="description" content="Sufee Admin - HTML5 Admin Template">
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

        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>

    </head>
    <body>
        <%

            Admin a = (Admin) request.getSession().getAttribute("admin");
            if (a != null) {
                //admin logged
                Session s = util.NewHibernateUtil.getSessionFactory().openSession();

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
                            <h1>Dashboard</h1>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="page-header float-right">
                        <div class="page-title">
                            <ol class="breadcrumb text-right">
                                <li class="active">Dashboard</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>


            <div class="col-sm-12 mb-4">
                <div class="card-group">
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-users"></i>
                            </div>

                            <div class="h4 mb-0">
                                <%                                        Criteria c = s.createCriteria(User.class);
                                    c.setProjection(Projections.count("iduser"));
                                    long all_count = (Long) c.uniqueResult();
                                %>
                                <span class="count"><%=all_count%></span>
                            </div>

                            <small class="text-muted text-uppercase font-weight-bold">All Users</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-1" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-user-o"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c2 = s.createCriteria(User.class);
                                    c2.add(Restrictions.eq("status", "confirmed"));
                                    c2.setProjection(Projections.count("iduser"));
                                    long active_count = (Long) c2.uniqueResult();
                                %>
                                <span class="count"><%=active_count%></span>
                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Active Users</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-2" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-user-times"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c3 = s.createCriteria(User.class);
                                    c3.add(Restrictions.eq("status", "inactive"));
                                    c3.setProjection(Projections.count("iduser"));
                                    long inactive_count = (Long) c3.uniqueResult();
                                %>
                                <span class="count"><%=inactive_count%></span>
                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Inactive Users</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-3" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-question-circle"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c4 = s.createCriteria(User.class);
                                    c4.add(Restrictions.eq("status", "pending"));
                                    c4.setProjection(Projections.count("iduser"));
                                    long pending_count = (Long) c4.uniqueResult();
                                %>
                                <span class="count"><%=pending_count%></span>
                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Pending Users</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-4" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-check-circle-o"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c5 = s.createCriteria(User.class);
                                    c5.add(Restrictions.eq("type", "online"));
                                    c5.setProjection(Projections.count("iduser"));
                                    long online_count = (Long) c5.uniqueResult();
                                %>
                                <span class="count"><%=online_count%></span>

                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Online Users</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-5" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-window-close"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c6 = s.createCriteria(User.class);
                                    c6.add(Restrictions.eq("type", "offline"));
                                    c6.setProjection(Projections.count("iduser"));
                                    long offline_count = (Long) c6.uniqueResult();
                                %>
                                <span class="count"><%=offline_count%></span>

                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Offline Users</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-1" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="stat-widget-one">
                            <div class="stat-icon dib"><i class="fa fa-laptop text-success border-success"></i></div>
                            <div class="stat-content dib">
                                <%

                                    Criteria c14 = s.createCriteria(InvoiceProduct.class);
                                    c14.add(Restrictions.eq("status", "done"));
                                    c14.setProjection(Projections.sum("total"));
                                    double products_sum = (Double) c14.uniqueResult();

                                %>
                                <div class="stat-text">Product Income</div>
                                <div class="stat-digit">$<%=products_sum%></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="stat-widget-one">
                            <div class="stat-icon dib"><i class="fa fa-table text-primary border-primary"></i></div>
                            <div class="stat-content dib">
                                <%
                                    Criteria c15 = s.createCriteria(InvoicePackage.class);
                                    c15.add(Restrictions.eq("status", "done"));
                                    double package_sum = 0;
                                    if (!c15.list().isEmpty()) {
                                        List<InvoicePackage> inv = c15.list();

                                        for (InvoicePackage i : inv) {
                                            package_sum += i.getSellerHasPackage().getSellerPackage().getPrice();
                                        }
                                    }
                                %>
                                <div class="stat-text">Package Income</div>
                                <div class="stat-digit">$<%=package_sum%></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="stat-widget-one">
                            <div class="stat-icon dib"><i class="fa fa-sort-amount-desc text-warning border-warning"></i></div>
                            <div class="stat-content dib">
                                <%

                                    double tot_cost = 0;
                                    Criteria c16 = s.createCriteria(InvoiceProduct.class);
                                    c16.add(Restrictions.eq("status", "done"));

                                    if (!c16.list().isEmpty()) {

                                        List<InvoiceProduct> inv = c16.list();

                                        for (InvoiceProduct i : inv) {
                                            Criteria c17 = s.createCriteria(InvoiceProductHasItem.class);
                                            c17.add(Restrictions.eq("invoiceProduct", i));
                                            //status add

                                            if (!c17.list().isEmpty()) {

                                                List<InvoiceProductHasItem> items = c17.list();
                                                for (InvoiceProductHasItem item : items) {

                                                    Seller seller = (Seller) s.load(Seller.class, item.getProduct().getSeller().getIdseller());

                                                    Criteria c18 = s.createCriteria(SellerHasPackage.class);
                                                    c18.add(Restrictions.eq("seller", seller));
                                                    c18.add(Restrictions.eq("status", "active"));
                                                    double sellerPayment = 0;
                                                    if (!c18.list().isEmpty()) {

                                                        SellerHasPackage shp = (SellerHasPackage) c18.uniqueResult();
                                                        double product_price = item.getProduct().getPrice();
                                                        double presantage = shp.getSellerPackage().getProfitPercentage();

                                                        sellerPayment = product_price - (product_price * presantage / 100);

                                                        tot_cost += sellerPayment;

                                                    }

                                                }

                                            }
                                        }

                                    }
                                %>
                                <div class="stat-text">Seller Cost</div>
                                <div class="stat-digit">$<%=tot_cost%></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <div class="card-body">
                        <div class="stat-widget-one">
                            <div class="stat-icon dib"><i class="ti-money text-danger border-danger"></i></div>
                            <div class="stat-content dib">
                                <%
                                    double profit = (products_sum + package_sum) - tot_cost;
                                %>
                                <div class="stat-text">Total Profit</div>
                                <div class="stat-digit">$<%=profit%></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div class="col-sm-12 mb-4">
                <div class="card-group">
                    <div class="card col-lg-2 col-md-6 no-padding bg-flat-color-1">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-laptop text-light"></i>
                            </div>

                            <div class="h4 mb-0 text-light">
                                <%

                                    Criteria c17 = s.createCriteria(Product.class);
                                    c17.setProjection(Projections.count("idproduct"));
                                    long allP_count = (Long) c17.uniqueResult();
                                %>
                                <span class="count"><%=allP_count%></span>
                            </div>
                            <small class="text-uppercase font-weight-bold text-light">All Products</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-light" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-lg-2 col-md-6 no-padding no-shadow">
                        <div class="card-body bg-flat-color-2">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-check-square-o text-light"></i>
                            </div>
                            <div class="h4 mb-0 text-light">
                                <%

                                    Criteria c18 = s.createCriteria(Product.class);
                                    c18.add(Restrictions.eq("status", "active"));
                                    c18.setProjection(Projections.count("idproduct"));
                                    long activeP_count = (Long) c18.uniqueResult();
                                %>
                                <span class="count"><%=activeP_count%></span>
                            </div>
                            <small class="text-uppercase font-weight-bold text-light">Active Products</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-light" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-lg-2 col-md-6 no-padding no-shadow">
                        <div class="card-body bg-flat-color-3">
                            <div class="h1 text-right mb-4">
                                <i class="fa fa-times-rectangle-o text-light"></i>
                            </div>
                            <div class="h4 mb-0 text-light">
                                <%

                                    Criteria c19 = s.createCriteria(Product.class);
                                    c19.add(Restrictions.eq("status", "inactive"));
                                    c19.setProjection(Projections.count("idproduct"));
                                    long inactiveP_count = (Long) c19.uniqueResult();
                                %>
                                <span class="count"><%=inactiveP_count%></span>
                            </div>
                            <small class="text-light text-uppercase font-weight-bold">Inactive Products</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-light" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-lg-2 col-md-6 no-padding no-shadow">
                        <div class="card-body bg-flat-color-5">
                            <div class="h1 text-right text-light mb-4">
                                <i class="fa fa-hourglass-half"></i>
                            </div>
                            <div class="h4 mb-0 text-light">
                                <%

                                    Criteria c20 = s.createCriteria(Product.class);
                                    c20.add(Restrictions.eq("status", "pending"));
                                    c20.setProjection(Projections.count("idproduct"));
                                    long pendingP_count = (Long) c20.uniqueResult();
                                %>
                                <span class="count"><%=pendingP_count%></span>
                            </div>
                            <small class="text-uppercase font-weight-bold text-light">Pending Products</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-light" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-lg-2 col-md-6 no-padding no-shadow">
                        <div class="card-body bg-flat-color-4">
                            <div class="h1 text-light text-right mb-4">
                                <i class="fa fa-shopping-basket"></i>
                            </div>
                            <div class="h4 mb-0 text-light">
                                <%

                                    Criteria c21 = s.createCriteria(Product.class);
                                    c21.add(Restrictions.eq("status", "rejected"));
                                    c21.setProjection(Projections.count("idproduct"));
                                    long rejectP_count = (Long) c21.uniqueResult();
                                %>
                                <span class="count"><%=rejectP_count%></span>
                            </div>
                            <small class="text-light text-uppercase font-weight-bold">Rejected Products</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-light" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-lg-2 col-md-6 no-padding no-shadow">
                        <div class="card-body bg-flat-color-1">
                            <div class="h1 text-light text-right mb-4">
                                <i class="fa fa-rocket"></i>
                            </div>
                            <div class="h4 mb-0 text-light">
                                <%

                                    Criteria c22 = s.createCriteria(Product.class);
                                    c22.add(Restrictions.eq("status", "sold"));
                                    c22.setProjection(Projections.count("idproduct"));
                                    long soldP_count = (Long) c22.uniqueResult();
                                %>
                                <span class="count"><%=soldP_count%></span>
                            </div>
                            <small class="text-light text-uppercase font-weight-bold">Sold Products</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-light" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                </div>

            </div>


            <div class="col-sm-12 mb-4">
                <div class="card-group">
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-users"></i>
                            </div>

                            <div class="h4 mb-0">
                                <%                                    Criteria c7 = s.createCriteria(Seller.class);
                                    c7.setProjection(Projections.count("idseller"));
                                    long allM_count = (Long) c7.uniqueResult();
                                %>
                                <span class="count"><%=allM_count%></span>
                            </div>

                            <small class="text-muted text-uppercase font-weight-bold">All Members</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-1" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-user-o"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c8 = s.createCriteria(Seller.class);
                                    c8.add(Restrictions.eq("status", "approved"));
                                    c8.setProjection(Projections.count("idseller"));
                                    long activeM_count = (Long) c8.uniqueResult();
                                %>
                                <span class="count"><%=activeM_count%></span>
                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Active Members</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-2" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-user-times"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c9 = s.createCriteria(Seller.class);
                                    c9.add(Restrictions.eq("status", "inactive"));
                                    c9.setProjection(Projections.count("idseller"));
                                    long inactiveM_count = (Long) c9.uniqueResult();
                                %>
                                <span class="count"><%=inactiveM_count%></span>
                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Inactive Members</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-3" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-question-circle"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c10 = s.createCriteria(Seller.class);
                                    c10.add(Restrictions.eq("status", "pending"));
                                    c10.setProjection(Projections.count("idseller"));
                                    long pendingM_count = (Long) c10.uniqueResult();
                                %>
                                <span class="count"><%=pendingM_count%></span>
                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Pending Members</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-4" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-check-circle-o"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c11 = s.createCriteria(Seller.class);
                                    long onlineM_count = 0;
                                    if (!c11.list().isEmpty()) {
                                        List<Seller> slist = c11.list();
                                        for (Seller i : slist) {

                                            if (i.getUser().getType().equals("online")) {
                                                onlineM_count++;
                                            }
                                        }
                                    }

                                %>
                                <span class="count"><%=onlineM_count%></span>

                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Online Members</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-5" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                    <div class="card col-md-6 no-padding ">
                        <div class="card-body">
                            <div class="h1 text-muted text-right mb-4">
                                <i class="fa fa-window-close"></i>
                            </div>
                            <div class="h4 mb-0">
                                <%
                                    Criteria c13 = s.createCriteria(Seller.class);
                                    long offlineM_count = 0;
                                    if (!c13.list().isEmpty()) {
                                        List<Seller> slist = c13.list();
                                        for (Seller i : slist) {
                                            if (i.getUser().getType().equals("offline")) {
                                                offlineM_count++;
                                            }
                                        }
                                    }

                                %>
                                <span class="count"><%=offlineM_count%></span>

                            </div>
                            <small class="text-muted text-uppercase font-weight-bold">Offline Members</small>
                            <div class="progress progress-xs mt-3 mb-0 bg-flat-color-1" style="width: 40%; height: 5px;"></div>
                        </div>
                    </div>
                </div>
            </div>




        </div><!-- /#right-panel -->

        <!-- Right Panel -->

        <script src="admin/assets/js/vendor/jquery-2.1.4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
        <script src="admin/assets/js/plugins.js"></script>
        <script src="admin/assets/js/main.js"></script>


        <script src="admin/assets/js/lib/chart-js/Chart.bundle.js"></script>
        <script src="admin/assets/js/dashboard.js"></script>
        <script src="admin/assets/js/widgets.js"></script>
        <script src="admin/assets/js/lib/vector-map/jquery.vmap.js"></script>
        <script src="admin/assets/js/lib/vector-map/jquery.vmap.min.js"></script>
        <script src="admin/assets/js/lib/vector-map/jquery.vmap.sampledata.js"></script>
        <script src="admin/assets/js/lib/vector-map/country/jquery.vmap.world.js"></script>
        <script>
            (function($) {
                "use strict";

                jQuery('#vmap').vectorMap({
                    map: 'world_en',
                    backgroundColor: null,
                    color: '#ffffff',
                    hoverOpacity: 0.7,
                    selectedColor: '#1de9b6',
                    enableZoom: true,
                    showTooltip: true,
                    values: sample_data,
                    scaleColors: ['#1de9b6', '#03a9f5'],
                    normalizeFunction: 'polynomial'
                });
            })(jQuery);
        </script>

        <%            } else {
                response.sendRedirect("admin_login.jsp");
            }

        %>
    </body>
</html>
