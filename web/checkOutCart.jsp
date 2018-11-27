<%-- 
    Document   : checkOutCart
    Created on : May 28, 2018, 11:06:26 AM
    Author     : Sheha
--%>

<%@page import="pojos.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="document.forms['x'].submit();">
        <%

            User u = (User) request.getSession().getAttribute("user");

            String i2 = (String) request.getSession().getAttribute("invoice_2");
            double tot = Double.parseDouble(i2.split(",")[1]);

            System.out.println(tot);
        %>
        <h1>Payment Gateway</h1>

        <form id="x" action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">

            <!--Identify your business so that you can collect the payments.--> 
            <input type="hidden" name="business" value="dydoxBusiness@gmail.com">

            <!--Specify a Buy Now button.--> 
            <input type="hidden" name="cmd" value="_xclick">

            <!--Specify details about the item that buyers will purchase.--> 
            <input type="hidden" name="item_name" value="">
            <input type="hidden" name="amount" value="<%=tot%>">
            <input type="hidden" name="currency_code" value="USD">


            <input type="hidden" name="return" value="http://localhost:8080/DYDOX.LK/product_payment_success.jsp">
            <input type="hidden" name="cancel_url" value="http://localhost:8080/DYDOX.LK/product_payment_cancel.jsp">



            <!--             Display the payment button. 
                                    <input type="image" name="submit" border="0"
                                           src="https://www.paypalobjects.com/en_US/i/btn/btn_buynow_LG.gif"
                                           alt="Buy Now">-->
            <img alt="" border="0" width="1" height="1"
                 src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" >

        </form>






    </body>
</html>
