package servelet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.SRate;
import pojos.Seller;
import pojos.User;

public class addStarRateSeller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            User user = (User) req.getSession().getAttribute("user");//user
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            System.out.println(o.get("rate"));
            System.out.println(o.get("uid"));

            User u = (User) s.load(User.class, Integer.parseInt(o.get("uid").toString()));//seller
            Criteria c2 = s.createCriteria(Seller.class);
            c2.add(Restrictions.eq("user", u));
            c2.add(Restrictions.eq("status", "approved"));
            Seller seller = (Seller) c2.uniqueResult();
            if (user == null) {
                System.out.println("login first");
                resp.getWriter().write("2");
            } else {
                //seller loged
                System.out.println("user loged");
                if (u.getIduser().equals(user.getIduser())) {
                    //same user try to add rate for his product
                    System.out.println("seller and user same");
                    resp.getWriter().write("3");
                } else {

                    Criteria c = s.createCriteria(SRate.class);

                    boolean isOk = false;
                    if (!c.list().isEmpty()) {
                        System.out.println("have");

                        List<SRate> list = c.list();
                        for (SRate sRate : list) {
                            System.out.println(sRate.getIdsRate());

                            if (sRate.getUser().getIduser().equals(user.getIduser()) && sRate.getSeller().getIdseller().equals(seller.getIdseller())) {
                                //alredy rated
                                System.out.println("alredy rated this user'" + user.getIduser() + "' for this seller'" + seller.getIdseller() + "'");
                                isOk = false;
                                break;

                            } else {
                                System.out.println("new one");
                                isOk = true;
                            }

                        }
                    } else {
                        System.out.println("empty");
                        isOk = true;
                    }
                    if (isOk) {
                        System.out.println("new one");

                        SRate srate = new SRate();
                        srate.setRate(Integer.parseInt(o.get("rate").toString()));
                        srate.setUser(user);

                        srate.setSeller(seller);

                        s.save(srate);

                        Transaction t = s.beginTransaction();
                        t.commit();

                        resp.getWriter().write("1");
                    } else {
                        //alredy rated
                        System.out.println("alredy rated");
                        resp.getWriter().write("4");
                    }

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
