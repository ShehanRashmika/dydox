package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.User;

public class updatePassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            User user = (User) req.getSession().getAttribute("user");

            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            System.out.println(o.get("pass1").toString());
            System.out.println(o.get("pass2").toString());
            if (!o.get("pass1").toString().isEmpty() && !o.get("pass2").toString().isEmpty()) {

                if (o.get("pass1").toString().equals(o.get("pass2").toString())) {

                    User u = (User) s.load(User.class, user.getIduser());
                    u.setPassword(o.get("pass2").toString());

                    Transaction t = s.beginTransaction();
                    t.commit();
                    resp.getWriter().write("2");

                } else {
                    resp.getWriter().write("1");

                }

            } else {
                System.out.println("empty");
                resp.getWriter().write("0");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
