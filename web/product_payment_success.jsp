<%@page import="pojos.Notifications"%>
<%@page import="pojos.Product"%>
<%@page import="pojos.Disandaddon"%>
<%@page import="pojos.InvoiceProductHasItem"%>
<%@page import="classes.Mailer"%>
<%@page import="java.util.List"%>
<%@page import="pojos.CartHasItem"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="pojos.Cart"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="pojos.User"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="pojos.InvoiceProduct"%>
<%-- 
    Document   : product_payment_success
    Created on : May 28, 2018, 6:20:56 PM
    Author     : Sheha
--%>

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

    <body style="background-color: #E9ECEF" onload="loadInvoice();">
        <div style="border: 2px solid #57B223;padding: 20px;background-color: white;">
            <%

                Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                User u = (User) request.getSession().getAttribute("user");
                InvoiceProduct inv = (InvoiceProduct) request.getSession().getAttribute("inv");
                InvoiceProduct i = (InvoiceProduct) s.load(InvoiceProduct.class, inv.getIdinvoiceProduct());

                if (u != null) {
                    System.out.println("user ok");

                    i.setStatus("done");
                    s.update(i);

                    Criteria c0 = s.createCriteria(InvoiceProductHasItem.class);
                    c0.add(Restrictions.eq("invoiceProduct", i));
                    if (!c0.list().isEmpty()) {
                        List<InvoiceProductHasItem> iphi = c0.list();
                        for (InvoiceProductHasItem x : iphi) {

                            if (x.getProduct().getSellLimit().equals("oneTime")) {
                                Product p = (Product) s.load(Product.class, x.getProduct().getIdproduct());
                                p.setStatus("sold");
                                s.update(p);
                            }
                        }
                    }

                    Criteria c = s.createCriteria(Cart.class);
                    c.add(Restrictions.eq("user", u));

                    if (!c.list().isEmpty()) {
                        System.out.println("user has cart");

                        Criteria c2 = s.createCriteria(CartHasItem.class);
                        c2.add(Restrictions.eq("cart", (Cart) c.uniqueResult()));
                        if (!c2.list().isEmpty()) {
                            System.out.println("cart has items");

                            List<CartHasItem> list = c2.list();

                            for (CartHasItem chi : list) {
                                CartHasItem it = (CartHasItem) s.load(CartHasItem.class, chi.getIdcartHasItem());
                                s.delete(it);

                            }
                        }
                    }

                    Notifications n = new Notifications();
                    n.setType("Payments");
                    n.setMessage("Your Product Payments $" + i.getTotal()+ " is Success! Goto Purchase History and Download Your Softwares!");
                    n.setUser(u);
                    n.setStatus("notRead");
                    s.save(n);

                    Transaction t = s.beginTransaction();
                    t.commit();
                }

                request.getSession().removeAttribute("inv");
                request.getSession().removeAttribute("invoice_1");
                request.getSession().removeAttribute("invoice_2");

            %>

            <header class="clearfix">
                <div id="logo">
                    <img src="images/head_4.png">
                </div>
                <div id="company">
                    <h2 class="name">DYDOX.LK</h2>
                    <div>455 Foggy Heights, AZ 85004, US</div>
                    <div>(602) 519-0450</div>
                    <div><a href="dydox.lk@gmail.com">dydox.lk@gmail.com</a></div>
                </div>

            </header>
            <main>
                <div id="details" class="clearfix">
                    <div id="client">
                        <div class="to">INVOICE TO:</div>
                        <h2 class="name"><%=u.getFirstName()%> <%=u.getLastName()%></h2>
                        <div class="address"><%=u.getStreet()%>, <%=u.getCity()%>, <%=u.getCountry()%></div>
                        <div class="email"><a href="mailto:<%=u.getEmail()%>"><%=u.getEmail()%></a></div>
                    </div>
                    <div id="invoice">
                        <h1 id="inv_id">INVOICE <%=i.getIdinvoiceProduct()%></h1>
                        <div class="date" >Date of Invoice: <span id="inv_date"><%=i.getDate()%> <%=i.getTime()%></span></div>
                        <!--<div class="date">Due Date: 30/06/2014</div>-->
                    </div>
                </div>
                <table border="0" cellspacing="0" cellpadding="0">
                    <thead>
                        <tr>
                            <th class="no">#</th>
                            <th class="desc">DESCRIPTION</th>
                            <th class="unit">ADDITIONAL PRICE</th>
                            <th class="qty">DISCOUNT PRICE</th>
                            <th class="total">TOTAL</th>
                        </tr>
                    </thead>
                    <tbody id="productINVTable">

                        <%                    Criteria c3 = s.createCriteria(InvoiceProductHasItem.class);
                            c3.add(Restrictions.eq("invoiceProduct", i));
                            if (!c3.list().isEmpty()) {
                                List<InvoiceProductHasItem> listItems = c3.list();
                                for (InvoiceProductHasItem t : listItems) {
                                    String imgUrl = t.getProduct().getImg1().replace(request.getServletContext().getRealPath("/"), "");

                                    Criteria c4 = s.createCriteria(Disandaddon.class);
                                    c4.add(Restrictions.eq("product", t.getProduct()));

                                    double addon = 0;
                                    double dis = 0;

                                    if (!c4.list().isEmpty()) {

                                        Disandaddon d = (Disandaddon) c4.uniqueResult();

                                        addon = d.getAddon();
                                        dis = d.getDiscount();
                                    }
                        %>

                        <tr>
                            <td class="no">
                    <center><%=t.getProduct().getIdproduct()%></center>
                    <div class="photo"> <div class="avatar" style="background-image: url(<%=imgUrl%>)" ></div> </div>
                    </td>
                    <td class="desc"><%=t.getProduct().getTitle()%> (<%=t.getProduct().getSfCategory().getCategoryName()%>)</td>
                    <td class="unit">$<%=addon%></td>
                    <td class="qty">$<%=dis%></td>
                    <td class="total">$<%=t.getProduct().getPrice()%></td>

                    </tr>



                    <%
                            }
                        }


                    %>


                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2"></td>
                            <td colspan="2">SUB TOTAL</td>
                            <td id="inv_subTot">$<%=i.getSubTot()%></td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                            <td colspan="2">TOTAL ADDITIONAL</td>
                            <td id="inv_addonTot">$<%=i.getAddonTot()%></td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                            <td colspan="2">TOTAL DISCOUNT</td>
                            <td id="inv_disTot">$<%=i.getDisTot()%></td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                            <td colspan="2">GRAND TOTAL</td>
                            <td id="inv_tot">$<%=i.getTotal()%></td>
                        </tr>
                    </tfoot>
                </table>
                <center>
                    <div id="thanks">Thank you <%=u.getFirstName()%>!</div>
                </center>

                <div id="notices">
                    <div>NOTICE:</div>
                    <div class="notice">A finance charge of 1.5% will be made on unpaid balances after 30 days.</div>
                </div>
                <br>
                <div id="notices">
                    <div>NOTICE:</div>
                    <div class="notice">A finance charge of 1.5% will be made on unpaid balances after 30 days.</div>
                </div>

            </main>
        </div>
        <footer>
            Invoice was created on a computer and is valid without the signature and seal.
        </footer>
        <br>
        <div id="msg" role="alert"></div>
        <br>
        <button class="btn btn-danger btn-block" onclick="downloadInvoice();">DOWNLOAD INVOICE</button>
        <br>
        <a class="btn btn-success btn-block" href="userZone.jsp?tab=tab_b" style="text-decoration: none;">PURCHASE HISTORY</a>
        <br>
        <a class="btn btn-info btn-block" href="product_view.jsp">CONTINUE SHOPPING</a>
        <br>
        <script type="text/javascript">
            function downloadInvoice() {
                //inv id,date,subtot,addon,dis,final

                var inv_id = document.getElementById("inv_id").innerHTML;
                var inv_date = document.getElementById("inv_date").innerHTML;
                var inv_subTot = document.getElementById("inv_subTot").innerHTML;
                var inv_addonTot = document.getElementById("inv_addonTot").innerHTML;
                var inv_disTot = document.getElementById("inv_disTot").innerHTML;
                var inv_tot = document.getElementById("inv_tot").innerHTML;

                var tbl = document.getElementById("productINVTable");

                var arr_1 = [];//des
                var arr_2 = [];//addon
                var arr_3 = [];//dis
                var arr_4 = [];//total

                var row_count = tbl.rows.length;

                for (var x = 0; x < row_count; x++) {

                    var row = tbl.rows[x];
                    arr_1.push(row.cells[1].innerHTML);
                    arr_2.push(row.cells[2].innerHTML);
                    arr_3.push(row.cells[3].innerHTML);
                    arr_4.push(row.cells[4].innerHTML);




                }

                var json_obj = {"inv_id": inv_id, "inv_date": inv_date, "inv_subTot": inv_subTot, "inv_addonTot": inv_addonTot, "inv_disTot": inv_disTot, "inv_tot": inv_tot, "des": arr_1, "addon": arr_2, "dis": arr_3, "tot": arr_4, "x": "1", "status": "download"};
                var json_str = JSON.stringify(json_obj);


                window.location = "productInvoiceDwonload?json_str=" + json_str;

            }

            function loadInvoice() {
                //inv id,date,subtot,addon,dis,final

                var inv_id = document.getElementById("inv_id").innerHTML;
                var inv_date = document.getElementById("inv_date").innerHTML;
                var inv_subTot = document.getElementById("inv_subTot").innerHTML;
                var inv_addonTot = document.getElementById("inv_addonTot").innerHTML;
                var inv_disTot = document.getElementById("inv_disTot").innerHTML;
                var inv_tot = document.getElementById("inv_tot").innerHTML;

                var msg = document.getElementById("msg");

                var tbl = document.getElementById("productINVTable");

                var arr_1 = [];//des
                var arr_2 = [];//addon
                var arr_3 = [];//dis
                var arr_4 = [];//total

                var row_count = tbl.rows.length;

                for (var x = 0; x < row_count; x++) {

                    var row = tbl.rows[x];
                    arr_1.push(row.cells[1].innerHTML);
                    arr_2.push(row.cells[2].innerHTML);
                    arr_3.push(row.cells[3].innerHTML);
                    arr_4.push(row.cells[4].innerHTML);




                }

                var json_obj = {"inv_id": inv_id, "inv_date": inv_date, "inv_subTot": inv_subTot, "inv_addonTot": inv_addonTot, "inv_disTot": inv_disTot, "inv_tot": inv_tot, "des": arr_1, "addon": arr_2, "dis": arr_3, "tot": arr_4, "x": "1", "status": "load"};
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
                req.open("get", "productInvoiceDwonload?json_str=" + json_str, true);
                req.send();


            }
        </script>
    </body>
</html>
