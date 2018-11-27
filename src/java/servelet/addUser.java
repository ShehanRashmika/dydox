package servelet;

import classes.Mailer;
import java.io.IOException;
import java.net.URL;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.User;

public class addUser extends HttpServlet {

    public static String code;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();

            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            String fname = o.get("fname").toString();
            String lname = o.get("lname").toString();
            String email = o.get("email").toString();
            String password = o.get("password").toString();
            String sendEmail = o.get("sendEmail").toString();

            Mailer m = new Mailer();

            //   double i = Math.random() * 1000000;
            code = getSaltString();
            System.out.println(code);

            User u = new User();
            u.setFirstName(fname);
            u.setLastName(lname);
            u.setEmail(email);
            u.setPassword(password);
            u.setEmailVerifyCode(code);

            if (sendEmail.equals("true")) {

                u.setStatus("pending");
                boolean b = m.send(email, "Confirm Your Email", "Click here to Confirm Your Email http://localhost:8080/DYDOX.LK/checkEmail?code=" + code, false);
                System.out.println(b);
                if (b) {

                    s.save(u);
                    Transaction t = s.beginTransaction();
                    t.commit();
                    resp.getWriter().write("1");
                } else {
                    resp.getWriter().write("0");
                }
            } else if (sendEmail.equals("false")) {
                u.setStatus("confirmed");
                s.save(u);
                Transaction t = s.beginTransaction();
                t.commit();
                resp.getWriter().write("2");
                System.out.println("done");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public String getSaltString() {
        String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < 15) { // length of the random string.
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        String saltStr = salt.toString();
        return saltStr;

    }
}
