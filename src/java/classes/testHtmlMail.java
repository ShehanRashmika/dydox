/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package classes;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Sheha
 */
public class testHtmlMail {
    
    public static void main(String[] args) {
          try {
            final String sender_email = "dydox.lk@gmail.com";
            final String pw = "javaLove";

            String receiver_mail = "rashmikaperera8@gmail.com";
            String sub = "TEST";
            
            
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

            Session session = Session.getInstance(props, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(sender_email, pw);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender_email));
            //InternetAddress[] address = {new InternetAddress(receiver_mail)};
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiver_mail));
            message.setSubject(sub);
            // message.setSentDate(new Date());

     
            message.setContent("<!DOCTYPE html>\n" +
"\n" +
"<html>\n" +
"    <head>\n" +
"        <title>TODO supply a title</title>\n" +
"        <meta charset=\"UTF-8\">\n" +
"        <meta name=\"viewport\" content=\"width=device-width\">\n" +
"        <style>\n" +
"            @font-face {\n" +
"                font-family: SourceSansPro;\n" +
"                src: url(SourceSansPro-Regular.ttf);\n" +
"            }\n" +
"\n" +
"            .clearfix:after {\n" +
"                content: \"\";\n" +
"                display: table;\n" +
"                clear: both;\n" +
"            }\n" +
"\n" +
"            a {\n" +
"                color: #0087C3;\n" +
"                text-decoration: none;\n" +
"            }\n" +
"\n" +
"            body {\n" +
"                position: relative;\n" +
"                width: 21cm;  \n" +
"                height: 29.7cm; \n" +
"                margin: 0 auto; \n" +
"                color: #555555;\n" +
"                background: #FFFFFF; \n" +
"                font-family: Arial, sans-serif; \n" +
"                font-size: 14px; \n" +
"                font-family: SourceSansPro;\n" +
"            }\n" +
"\n" +
"            header {\n" +
"                padding: 10px 0;\n" +
"                margin-bottom: 20px;\n" +
"                border-bottom: 1px solid #AAAAAA;\n" +
"            }\n" +
"\n" +
"            #logo {\n" +
"                float: left;\n" +
"                margin-top: 8px;\n" +
"            }\n" +
"\n" +
"            #logo img {\n" +
"                height: 70px;\n" +
"            }\n" +
"\n" +
"            #company {\n" +
"                float: right;\n" +
"                text-align: right;\n" +
"            }\n" +
"\n" +
"\n" +
"            #details {\n" +
"                margin-bottom: 50px;\n" +
"            }\n" +
"\n" +
"            #client {\n" +
"                padding-left: 6px;\n" +
"                border-left: 6px solid #0087C3;\n" +
"                float: left;\n" +
"            }\n" +
"\n" +
"            #client .to {\n" +
"                color: #777777;\n" +
"            }\n" +
"\n" +
"            h2.name {\n" +
"                font-size: 1.4em;\n" +
"                font-weight: normal;\n" +
"                margin: 0;\n" +
"            }\n" +
"\n" +
"            #invoice {\n" +
"                float: right;\n" +
"                text-align: right;\n" +
"            }\n" +
"\n" +
"            #invoice h1 {\n" +
"                color: #0087C3;\n" +
"                font-size: 2.4em;\n" +
"                line-height: 1em;\n" +
"                font-weight: normal;\n" +
"                margin: 0  0 10px 0;\n" +
"            }\n" +
"\n" +
"            #invoice .date {\n" +
"                font-size: 1.1em;\n" +
"                color: #777777;\n" +
"            }\n" +
"\n" +
"            table {\n" +
"                width: 100%;\n" +
"                border-collapse: collapse;\n" +
"                border-spacing: 0;\n" +
"                margin-bottom: 20px;\n" +
"            }\n" +
"\n" +
"            table th,\n" +
"            table td {\n" +
"                padding: 20px;\n" +
"                background: #EEEEEE;\n" +
"                text-align: center;\n" +
"                border-bottom: 1px solid #FFFFFF;\n" +
"            }\n" +
"\n" +
"            table th {\n" +
"                white-space: nowrap;        \n" +
"                font-weight: normal;\n" +
"            }\n" +
"\n" +
"            table td {\n" +
"                text-align: right;\n" +
"            }\n" +
"\n" +
"            table td h3{\n" +
"                color: #57B223;\n" +
"                font-size: 1.2em;\n" +
"                font-weight: normal;\n" +
"                margin: 0 0 0.2em 0;\n" +
"            }\n" +
"\n" +
"            table .no {\n" +
"                color: #FFFFFF;\n" +
"                font-size: 1.6em;\n" +
"                background: #57B223;\n" +
"            }\n" +
"\n" +
"            table .desc {\n" +
"                text-align: left;\n" +
"            }\n" +
"\n" +
"            table .unit {\n" +
"                background: #DDDDDD;\n" +
"            }\n" +
"\n" +
"            table .qty {\n" +
"            }\n" +
"\n" +
"            table .total {\n" +
"                background: #57B223;\n" +
"                color: #FFFFFF;\n" +
"            }\n" +
"\n" +
"            table td.unit,\n" +
"            table td.qty,\n" +
"            table td.total {\n" +
"                font-size: 1.2em;\n" +
"            }\n" +
"\n" +
"            table tbody tr:last-child td {\n" +
"                border: none;\n" +
"            }\n" +
"\n" +
"            table tfoot td {\n" +
"                padding: 10px 20px;\n" +
"                background: #FFFFFF;\n" +
"                border-bottom: none;\n" +
"                font-size: 1.2em;\n" +
"                white-space: nowrap; \n" +
"                border-top: 1px solid #AAAAAA; \n" +
"            }\n" +
"\n" +
"            table tfoot tr:first-child td {\n" +
"                border-top: none; \n" +
"            }\n" +
"\n" +
"            table tfoot tr:last-child td {\n" +
"                color: #57B223;\n" +
"                font-size: 1.4em;\n" +
"                border-top: 1px solid #57B223; \n" +
"\n" +
"            }\n" +
"\n" +
"            table tfoot tr td:first-child {\n" +
"                border: none;\n" +
"            }\n" +
"\n" +
"            #thanks{\n" +
"                font-size: 2em;\n" +
"                margin-bottom: 50px;\n" +
"            }\n" +
"\n" +
"            #notices{\n" +
"                padding-left: 6px;\n" +
"                border-left: 6px solid #0087C3;  \n" +
"            }\n" +
"\n" +
"            #notices .notice {\n" +
"                font-size: 1.2em;\n" +
"            }\n" +
"\n" +
"            footer {\n" +
"                color: #777777;\n" +
"                width: 100%;\n" +
"                height: 30px;\n" +
"                position: absolute;\n" +
"                bottom: 0;\n" +
"                border-top: 1px solid #AAAAAA;\n" +
"                padding: 8px 0;\n" +
"                text-align: center;\n" +
"            }\n" +
"\n" +
"\n" +
"\n" +
"        </style>\n" +
"    </head>\n" +
"    <body>\n" +
"        <header class=\"clearfix\">\n" +
"            <div id=\"logo\">\n" +
"                <img src=\"images/head_4.png\">\n" +
"            </div>\n" +
"            <div id=\"company\">\n" +
"                <h2 class=\"name\">Company Name</h2>\n" +
"                <div>455 Foggy Heights, AZ 85004, US</div>\n" +
"                <div>(602) 519-0450</div>\n" +
"                <div><a href=\"mailto:company@example.com\">company@example.com</a></div>\n" +
"            </div>\n" +
"\n" +
"        </header>\n" +
"    <main>\n" +
"        <div id=\"details\" class=\"clearfix\">\n" +
"            <div id=\"client\">\n" +
"                <div class=\"to\">INVOICE TO:</div>\n" +
"                <h2 class=\"name\">John Doe</h2>\n" +
"                <div class=\"address\">796 Silver Harbour, TX 79273, US</div>\n" +
"                <div class=\"email\"><a href=\"mailto:john@example.com\">john@example.com</a></div>\n" +
"            </div>\n" +
"            <div id=\"invoice\">\n" +
"                <h1>INVOICE 3-2-1</h1>\n" +
"                <div class=\"date\">Date of Invoice: 01/06/2014</div>\n" +
"                <div class=\"date\">Due Date: 30/06/2014</div>\n" +
"            </div>\n" +
"        </div>\n" +
"        <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n" +
"            <thead>\n" +
"                <tr>\n" +
"                    <th class=\"no\">#</th>\n" +
"                    <th class=\"desc\">DESCRIPTION</th>\n" +
"                    <th class=\"unit\">UNIT PRICE</th>\n" +
"                    <th class=\"qty\">QUANTITY</th>\n" +
"                    <th class=\"total\">TOTAL</th>\n" +
"                </tr>\n" +
"            </thead>\n" +
"            <tbody>\n" +
"                <tr>\n" +
"                    <td class=\"no\">01</td>\n" +
"                    <td class=\"desc\"><h3>Website Design</h3>Creating a recognizable design solution based on the company's existing visual identity</td>\n" +
"                    <td class=\"unit\">$40.00</td>\n" +
"                    <td class=\"qty\">30</td>\n" +
"                    <td class=\"total\">$1,200.00</td>\n" +
"                </tr>\n" +
"                <tr>\n" +
"                    <td class=\"no\">02</td>\n" +
"                    <td class=\"desc\"><h3>Website Development</h3>Developing a Content Management System-based Website</td>\n" +
"                    <td class=\"unit\">$40.00</td>\n" +
"                    <td class=\"qty\">80</td>\n" +
"                    <td class=\"total\">$3,200.00</td>\n" +
"                </tr>\n" +
"                <tr>\n" +
"                    <td class=\"no\">03</td>\n" +
"                    <td class=\"desc\"><h3>Search Engines Optimization</h3>Optimize the site for search engines (SEO)</td>\n" +
"                    <td class=\"unit\">$40.00</td>\n" +
"                    <td class=\"qty\">20</td>\n" +
"                    <td class=\"total\">$800.00</td>\n" +
"                </tr>\n" +
"            </tbody>\n" +
"            <tfoot>\n" +
"                <tr>\n" +
"                    <td colspan=\"2\"></td>\n" +
"                    <td colspan=\"2\">SUBTOTAL</td>\n" +
"                    <td>$5,200.00</td>\n" +
"                </tr>\n" +
"                <tr>\n" +
"                    <td colspan=\"2\"></td>\n" +
"                    <td colspan=\"2\">TAX 25%</td>\n" +
"                    <td>$1,300.00</td>\n" +
"                </tr>\n" +
"                <tr>\n" +
"                    <td colspan=\"2\"></td>\n" +
"                    <td colspan=\"2\">GRAND TOTAL</td>\n" +
"                    <td>$6,500.00</td>\n" +
"                </tr>\n" +
"            </tfoot>\n" +
"        </table>\n" +
"        <div id=\"thanks\">Thank you!</div>\n" +
"        <div id=\"notices\">\n" +
"            <div>NOTICE:</div>\n" +
"            <div class=\"notice\">A finance charge of 1.5% will be made on unpaid balances after 30 days.</div>\n" +
"        </div>\n" +
"    </main>\n" +
"    <footer>\n" +
"        Invoice was created on a computer and is valid without the signature and seal.\n" +
"    </footer>\n" +
"</body>\n" +
"</html>\n" +
"","text/html;charset=utf-8");
           
            
            
            Transport.send(message);

         
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
