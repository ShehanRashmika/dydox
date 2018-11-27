<%-- 
    Document   : admin_sellerPayments
    Created on : Jun 21, 2018, 8:57:15 PM
    Author     : Sheha
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="pojos.SellerHasPackage"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="pojos.Seller"%>
<%@page import="pojos.Product"%>
<%@page import="org.hibernate.Session"%>
<%@page import="classes.sellerPayments"%>
<%@page import="pojos.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
               <title>dydox.lk</title>
    </head>
    <body onload="document.forms['x'].submit();">
        <%

            Admin u = (Admin) request.getSession().getAttribute("admin");
            if (u != null) {

                int pid = Integer.parseInt(request.getParameter("pid"));
                int sid = Integer.parseInt(request.getParameter("sid"));
//                int inv_id = Integer.parseInt(request.getParameter("inv_id"));

                Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                Product product = (Product) s.load(Product.class, pid);
                Seller seller = (Seller) s.load(Seller.class, sid);

                Criteria c3 = s.createCriteria(SellerHasPackage.class);
                c3.add(Restrictions.eq("seller", seller));
                c3.add(Restrictions.eq("status", "active"));
                double sellerPayment = 0;
                if (!c3.list().isEmpty()) {

                    SellerHasPackage shp = (SellerHasPackage) c3.uniqueResult();
                    double product_price = product.getPrice();
                    double presantage = shp.getSellerPackage().getProfitPercentage();

                    sellerPayment = product_price-(product_price * presantage / 100);

                }

        %>
        <h1>Payment Gateway</h1>


        <form id="x" action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">

            <!-- Identify your business so that you can collect the payments. -->
            <input type="hidden" name="business" value="dydoxBusiness@gmail.com">

            <!-- Specify a Buy Now button. -->
            <input type="hidden" name="cmd" value="_xclick">

            <!-- Specify details about the item that buyers will purchase. -->
            <input type="hidden" name="item_name" value="">
            <input type="hidden" name="amount" value="<%=sellerPayment%>">
            <input type="hidden" name="currency_code" value="USD">


            <input type="hidden" name="return" value="http://localhost:8080/DYDOX.LK/admin_sellerPayments_success.jsp">
            <input type="hidden" name="cancel_url" value="http://localhost:8080/DYDOX.LK/admin_sellerPayments_cancel.jsp">


            <img alt="" border="0" width="1" height="1"
                 src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" >

        </form>
        <%       } else {
                response.sendRedirect("admin_login.jsp");
            }
        %>
    </body>
</html>
