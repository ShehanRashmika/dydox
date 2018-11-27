package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import pojos.Notifications;
import pojos.User;

public class updateNotiStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            String nid = req.getParameter("nid");
            System.out.println(nid);
            User u = (User) req.getSession().getAttribute("user");
            
            if (nid.equals("all")) {
                System.out.println("close all");
                Criteria c = s.createCriteria(Notifications.class);
                c.add(Restrictions.eq("user", u));
                
                List<Notifications> list = c.list();
                for (Notifications n : list) {

                    n.setStatus("read");
                    s.update(n);

                }
                resp.getWriter().write("1");

            } else {
                System.out.println("close one");
                Notifications noti = (Notifications) s.load(Notifications.class, Integer.parseInt(nid));
                noti.setStatus("read");
                s.update(noti);
                resp.getWriter().write("1");

            }

            Transaction t = s.beginTransaction();
            t.commit();
            System.out.println("updated!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
