<%-- 
    Document   : package_payment_success
    Created on : Apr 13, 2018, 7:39:40 PM
    Author     : Sheha
--%>
<%@page import="pojos.Notifications"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="pojos.SellerHasPackage"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="pojos.User"%>
<%@page import="pojos.InvoicePackage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>dydox.lk</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="css/style_invoice.css" >
        <style type="text/css">

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
        </style>

    </head>
    <body onload="loadInvoice();">
        <%
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();

            User u = (User) request.getSession().getAttribute("user");
            InvoicePackage p = (InvoicePackage) request.getSession().getAttribute("package");
            SellerHasPackage sh = (SellerHasPackage) request.getSession().getAttribute("shp");
System.out.println(p.getIdinvoicePackage());
            InvoicePackage inv = (InvoicePackage) s.load(InvoicePackage.class, p.getIdinvoicePackage());
            SellerHasPackage shp = (SellerHasPackage) s.load(SellerHasPackage.class, sh.getSellerHasPackageId());

            inv.setStatus("done");
            shp.setStatus("active");

            s.update(inv);
            s.update(shp);

            Notifications n = new Notifications();
            n.setType("Payments");
            n.setMessage("Your Package Payments $" + shp.getSellerPackage().getPrice() + " is Success! Waiting for Admin Approvel!");
            n.setUser(u);
            n.setStatus("notRead");
            s.save(n);

            Transaction t = s.beginTransaction();
            t.commit();

            request.getSession().removeAttribute("package");
            request.getSession().removeAttribute("shp");
        %>
        <BR>
        <BR>

        <div class="content mt-3">
            <div class="animated fadeIn">
                <div class="row">

                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">PACKAGE INVOICE</strong>
                            </div>
                            <div class="card-body">


                                <table id="bootstrap-data-table" class="table table-striped table-bordered ">
                                    <thead>
                                        <tr>
                                            <th>Invoice ID</th>
                                            <th>Date</th>
                                            <th>User</th>
                                            <th>Package</th>
                                            <th>Price</th>

                                        </tr>
                                    </thead>
                                    <tbody id="packageInvoiceTable">

                                        <%
                                            Criteria c2 = s.createCriteria(InvoicePackage.class);
                                            c2.add(Restrictions.eq("user", u));
                                            c2.add(Restrictions.eq("status", "done"));
                                            if (!c2.list().isEmpty()) {
                                                List<InvoicePackage> list = c2.list();
                                                for (InvoicePackage k : list) {
                                                    System.out.println("inv pack "+k.getIdinvoicePackage());
                                        %>

                                        <tr>
                                            <td><%=k.getIdinvoicePackage()%></td>
                                            <td><%=k.getDate()%></td>
                                            <td><%=k.getUser().getFirstName()%> <%=k.getUser().getLastName()%></td>
                                            <td><%=k.getSellerHasPackage().getSellerPackage().getName()%></td>
                                            <td><%=k.getSellerHasPackage().getSellerPackage().getPrice()%></td>
                                        </tr>
                                        <%
                                                }
                                            }

                                        %>

                                    </tbody>
                                </table>
                                <div class="row">
                                    <br>
                                    <div id="msg" role="alert"></div>
                                    <br>
                                    <button class="btn btn-info btn-block" onclick="downloadInvoice();">DOWNLOAD INVOICE</button>
                                    <a class="btn btn-success btn-block" href="memberZone.jsp">MEMBER ZONE</a>
                                    <a class="btn btn-warning btn-block" href="product_view.jsp">CONTINUE SHOPPING</a>
                                    <img id="loadPrint">
                                </div> 
                            </div>
                        </div>
                    </div>


                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

        <script type="text/javascript">
            function downloadInvoice() {

                var tbl = document.getElementById("packageInvoiceTable");

                var arr_1 = [];
                var arr_2 = [];
                var arr_3 = [];
                var arr_4 = [];
                var arr_5 = [];

                var row_count = tbl.rows.length;

                for (var x = 0; x < row_count; x++) {

                    var row = tbl.rows[x];
                    arr_1.push(row.cells[0].innerHTML);
                    arr_2.push(row.cells[1].innerHTML);
                    arr_3.push(row.cells[2].innerHTML);
                    arr_4.push(row.cells[3].innerHTML);
                    arr_5.push(row.cells[4].innerHTML);




                }

                var json_obj = {"inv_id": arr_1, "date": arr_2, "user": arr_3, "package": arr_4, "price": arr_5, "x": "1", "status": "download"};
                var json_str = JSON.stringify(json_obj);


                window.location = "packageInvoiceDwonload?json_str=" + json_str;

            }

            function loadInvoice() {
                //inv id,date,subtot,addon,dis,final

                var msg = document.getElementById("msg");

                var tbl = document.getElementById("packageInvoiceTable");

                var arr_1 = [];
                var arr_2 = [];
                var arr_3 = [];
                var arr_4 = [];
                var arr_5 = [];

                var row_count = tbl.rows.length;

                for (var x = 0; x < row_count; x++) {

                    var row = tbl.rows[x];
                    arr_1.push(row.cells[0].innerHTML);
                    arr_2.push(row.cells[1].innerHTML);
                    arr_3.push(row.cells[2].innerHTML);
                    arr_4.push(row.cells[3].innerHTML);
                    arr_5.push(row.cells[4].innerHTML);




                }

                var json_obj = {"inv_id": arr_1, "date": arr_2, "user": arr_3, "package": arr_4, "price": arr_5, "x": "1", "status": "load"};
                var json_str = JSON.stringify(json_obj);



                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.readyState == 4 && req.status == 200) {
                        if (req.responseText == 1) {
                            msg.innerHTML = "Invoice Send By Email!";
                            msg.className = "alert alert-success";
                        } else {
                            msg.innerHTML = "Invoice not Send By Email!";
                            msg.className = "alert alert-danger";

                        }
                    }
                };
                req.open("get", "packageInvoiceDwonload?json_str=" + json_str, true);
                req.send();


            }
        </script>
    </body>
</html>
