package servelet;

import java.io.IOException;
import java.io.PrintWriter;
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

public class saveSeller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            System.out.println("server");
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            int sid = Integer.parseInt(req.getParameter("sid"));
            User u = (User) req.getSession().getAttribute("user");
            Seller seller = (Seller) s.load(Seller.class, sid);

            if (u != null) {

                if (u.getIduser().equals(seller.getUser().getIduser())) {
                    //user and seller same
                    System.out.println("seller and user same");
                    resp.getWriter().write("1");
                } else {
                    System.out.println("seller and user diffrent");

                    Criteria c = s.createCriteria(SavedSeller.class);
                    c.add(Restrictions.eq("user", u));
                    c.add(Restrictions.eq("seller", seller));

                    if (c.list().isEmpty()) {
                        //no repeted
                        System.out.println("okk");
                        SavedSeller ss = new SavedSeller();
                        ss.setSeller(seller);
                        ss.setUser(u);

                        s.save(ss);

                        Transaction t = s.beginTransaction();
                        t.commit();

                        resp.getWriter().write("3");

                    } else {
                        //alredry have
                        System.out.println("alredy added");
                        resp.getWriter().write("2");

                    }

                }

            } else {
                resp.getWriter().write("0");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
