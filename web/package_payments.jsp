<%-- 
    Document   : package_payments
    Created on : Apr 13, 2018, 7:33:01 PM
    Author     : Sheha
--%>

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
    <body onload="document.forms['x'].submit();">
        <%

            User u = (User) request.getSession().getAttribute("user");
            InvoicePackage p = (InvoicePackage) request.getSession().getAttribute("package");

        %>
        <h1>Payment Gateway</h1>



<!--        <form id="x" method="post" action="https://sandbox.payhere.lk/pay/checkout">   
            <input type="hidden" name="merchant_id" value="1210251">
            <input type="hidden" name="return_url" value="http://localhost:8080/DYDOX.LK/package_payment_success.jsp">
            <input type="hidden" name="cancel_url" value="http://localhost:8080/DYDOX.LK/package_payment_cancel.jsp">
            <input type="hidden" name="notify_url" value="http://sample.com/notify">  

            <input type="hidden" type="text" name="order_id" value="ItemNo12345">
            <input type="hidden" type="text" name="items" value="<%=p.getSellerHasPackage().getSellerPackage().getName()%>"><br>
            <input type="hidden" type="text" name="currency" value="USD">
            <input type="hidden" name="amount" value="<%=p.getSellerHasPackage().getSellerPackage().getPrice()%>">  

            <input type="hidden" type="text" name="first_name" value="<%=u.getFirstName()%>">
            <input type="hidden" type="text" name="last_name" value="Perera"><br>
            <input type="hidden" type="text" name="email" value="<%=u.getEmail()%>">
            <input type="hidden" type="text" name="phone" value="0771234567"><br>
            <input type="hidden" type="text" name="address" value="No.1, Galle Road">
            <input type="hidden" type="text" name="city" value="Colombo">
            <input type="hidden" name="country" value="Sri Lanka"><br><br> 
            <input type="hidden"  type="submit" value="Buy Now">   
        </form> 


-->


        <form id="x" action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">

            <!-- Identify your business so that you can collect the payments. -->
            <input type="hidden" name="business" value="dydoxBusiness@gmail.com">

            <!-- Specify a Buy Now button. -->
            <input type="hidden" name="cmd" value="_xclick">

            <!-- Specify details about the item that buyers will purchase. -->
            <input type="hidden" name="item_name" value="<%=p.getSellerHasPackage().getSellerPackage().getName()%>">
            <input type="hidden" name="amount" value="<%=p.getSellerHasPackage().getSellerPackage().getPrice()%>">
            <input type="hidden" name="currency_code" value="USD">


            <input type="hidden" name="return" value="http://localhost:8080/DYDOX.LK/package_payment_success.jsp">
            <input type="hidden" name="cancel_url" value="http://localhost:8080/DYDOX.LK/package_payment_cancel.jsp">



            <!-- Display the payment button. -->
<!--            <input type="image" name="submit" border="0"
                   src="https://www.paypalobjects.com/en_US/i/btn/btn_buynow_LG.gif"
                   alt="Buy Now">-->
            <img alt="" border="0" width="1" height="1"
                 src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" >

        </form>
    </body>
</html>
