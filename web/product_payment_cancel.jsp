<%-- 
    Document   : product_payment_cancel
    Created on : May 28, 2018, 6:21:18 PM
    Author     : Sheha
--%>

<%@page import="pojos.User"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="pojos.InvoiceProduct"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
           <title>dydox.lk</title>
    </head>
    <body>
        <h1>Cancel!</h1>
        <%
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            User u = (User) request.getSession().getAttribute("user");
            if (u != null) {
                InvoiceProduct inv = (InvoiceProduct) request.getSession().getAttribute("inv");
                InvoiceProduct i = (InvoiceProduct) s.load(InvoiceProduct.class, inv.getIdinvoiceProduct());

                i.setStatus("cancel");
                s.update(i);

                Transaction t = s.beginTransaction();
                t.commit();
            }

            request.getSession().removeAttribute("inv");
            request.getSession().removeAttribute("invoice_1");
            request.getSession().removeAttribute("invoice_2");

        %>
    </body>
</html>
