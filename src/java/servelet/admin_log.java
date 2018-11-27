package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Admin;

public class admin_log extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            
            System.out.println(o.get("email"));
            System.out.println(o.get("password"));

            if (!o.get("email").toString().isEmpty() && !o.get("password").toString().isEmpty()) {
                System.out.println("email and password ok");
                Criteria c = s.createCriteria(Admin.class);
                c.add(Restrictions.eq("email", o.get("email").toString()));
                c.add(Restrictions.eq("password", o.get("password").toString()));
                c.add(Restrictions.eq("status","approved"));

                if (!c.list().isEmpty()) {
                    //admin found

                    req.getSession().setAttribute("admin", (Admin)c.uniqueResult());
                    resp.getWriter().write("1");

                } else {
                    resp.getWriter().write("0");

                }
            } else {
                resp.getWriter().write("2");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
