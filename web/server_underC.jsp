<%-- 
    Document   : server_underC
    Created on : Jun 23, 2018, 3:50:36 AM
    Author     : Sheha
--%>

<%@page import="servelet.stopServer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Under Constructions</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body { text-align: center; padding: 150px; }
            h1 { font-size: 50px; }
            body { font: 20px Helvetica, sans-serif; color: #333; }
            article { display: block; text-align: left; width: 650px; margin: 0 auto; }
            a { color: #dc8100; text-decoration: none; }
            a:hover { color: #333; text-decoration: none; }
        </style>

    </head>
    <body style="background-color: #E9ECEF;">
    <center>
        
        <img src="images/uc_4.png" style="margin-top: -140px;">

        <article style="margin-left: 30%;">
             <h1>We&rsquo;ll be back soon!</h1>
            <div>
                <p><%=stopServer.serverMsg%></p>
                <p>-Administrator-</p>
            </div>
        </article>
    </center>
    </body>
</html>
