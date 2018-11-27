<%-- 
    Document   : package_payment_cancel
    Created on : Apr 13, 2018, 7:39:56 PM
    Author     : Sheha
--%>

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
    </head>
    <body>
        <h1>Canceled</h1>

        <%

            User u = (User) request.getSession().getAttribute("user");
            InvoicePackage p = (InvoicePackage) request.getSession().getAttribute("package");
            SellerHasPackage sh = (SellerHasPackage) request.getSession().getAttribute("shp");

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();

            InvoicePackage inv = (InvoicePackage) s.load(InvoicePackage.class, p.getIdinvoicePackage());
            SellerHasPackage shp = (SellerHasPackage) s.load(SellerHasPackage.class, sh.getSellerHasPackageId());

            inv.setStatus("done");
            shp.setStatus("inactive");

            s.update(inv);
            s.update(shp);

            Transaction t = s.beginTransaction();
            t.commit();

            request.getSession().removeAttribute("package");
            request.getSession().removeAttribute("shp");


        %>
    </body>
</html>
