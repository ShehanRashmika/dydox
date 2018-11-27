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
import pojos.Admin;

public class updateAndAddAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            System.out.println("ok bitch");
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            if (!o.get("status").toString().isEmpty() && !o.get("fname").toString().isEmpty() && !o.get("lname").toString().isEmpty() && !o.get("mobile").toString().isEmpty() && !o.get("email").toString().isEmpty() && !o.get("password").toString().isEmpty()) {
                Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                if (o.get("status").toString().equals("update")) {
                    Admin a = (Admin) req.getSession().getAttribute("admin");
                    Admin admin = (Admin) s.load(Admin.class, a.getIdadmin());

                    admin.setFname(o.get("fname").toString());
                    admin.setLname(o.get("lname").toString());
                    admin.setEmail(o.get("email").toString());
                    admin.setMobile(o.get("mobile").toString());
                    admin.setPassword(o.get("password").toString());

                    s.update(admin);

                    resp.getWriter().write("1");

                } else if (o.get("status").toString().equals("save")) {

                    Admin admin = new Admin();

                    admin.setFname(o.get("fname").toString());
                    admin.setLname(o.get("lname").toString());
                    admin.setEmail(o.get("email").toString());
                    admin.setMobile(o.get("mobile").toString());
                    admin.setPassword(o.get("password").toString());
                    admin.setStatus("approved");

                    s.save(admin);

                    resp.getWriter().write("1");

                }

                Transaction t = s.beginTransaction();
                t.commit();
            } else {
                resp.getWriter().write("0");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
