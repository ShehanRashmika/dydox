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
import pojos.SavedSeller;
import pojos.Seller;
import pojos.User;

public class removeSavedSeller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            User u = (User) req.getSession().getAttribute("user");
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            if (u != null) {
                //user logged
                Seller seller = (Seller) s.load(Seller.class, Integer.parseInt(req.getParameter("sid")));

                Criteria c1 = s.createCriteria(SavedSeller.class);
                c1.add(Restrictions.eq("user", u));
                c1.add(Restrictions.eq("seller", seller));

                if (!c1.list().isEmpty()) {

                    SavedSeller ss = (SavedSeller) c1.uniqueResult();
                    s.delete(ss);
                    Transaction t = s.beginTransaction();
                    t.commit();

                }

                resp.getWriter().write("item(s) remove success!");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
