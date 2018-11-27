package classes;

import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import servelet.productInvoiceDwonload;

public class Mailer {

    public boolean send(String to, String subject, String msgg, boolean isHtml) {

        try {
            final String sender_email = "dydox.lk@gmail.com";
            final String pw = "javaLove";
//            final String sender_email = "hotelroyalsapphire@gmail.com";
//            final String pw = "hotel123#";

            String receiver_mail = to;
            String sub = subject;
            String msg = msgg;

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

            if (isHtml) {
            
                System.out.println("file found "+msgg);
                MimeBodyPart messageBodyPart
                        = new MimeBodyPart();
                //fill message  
                messageBodyPart.setText("Please Download Your Invoice.It will helps to good understanding!");
                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(messageBodyPart);
                // Part two is attachment  
                messageBodyPart = new MimeBodyPart();
                DataSource source
                        = new FileDataSource(msgg);
                messageBodyPart.setDataHandler(
                        new DataHandler(source));
                messageBodyPart.setFileName(msgg);
                multipart.addBodyPart(messageBodyPart);
                // Put parts in message  
                message.setContent(multipart);

//                message.setContent(msg, "text/html;charset=utf-8");
            } else {

                message.setText(msg);

            }

            Transport.send(message);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }
}
