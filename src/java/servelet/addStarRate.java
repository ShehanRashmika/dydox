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
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.PRate;
import pojos.Product;
import pojos.User;

public class addStarRate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            User user = (User) req.getSession().getAttribute("user");
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            System.out.println(o.get("rate"));
            System.out.println(o.get("uid"));

            if (user == null) {
                System.out.println("login first");
                resp.getWriter().write("2");
            } else {
                //seller uid
                System.out.println("user loged");
                User u = (User) s.load(User.class, Integer.parseInt(o.get("uid").toString()));
                Product p = (Product) s.load(Product.class, Integer.parseInt(o.get("pid").toString()));
                if (u.getIduser().equals(user.getIduser())) {
                    //same user try to add rate for his product
                    System.out.println("seller and user same");
                    resp.getWriter().write("3");
                } else {

                    Criteria c = s.createCriteria(PRate.class);

                    boolean isOk = false;
                    if (!c.list().isEmpty()) {

                        List<PRate> list = c.list();
                        for (PRate pRate : list) {

                            if (pRate.getUser().getIduser().equals(user.getIduser()) && pRate.getProduct().getIdproduct().equals(p.getIdproduct())) {
                                //alredy rated
                                System.out.println("alredy rated this user'" + user.getIduser() + "' for this product'" + p.getIdproduct() + "'");
                                isOk = false;
                                break;
                            } else {
                                isOk = true;
                            }

                        }
                    } else {
                        isOk = true;
                    }
                    if (isOk) {
                        System.out.println("new one");

                        PRate prate = new PRate();
                        prate.setProduct(p);
                        prate.setRate(Integer.parseInt(o.get("rate").toString()));
                        prate.setUser(user);

                        s.save(prate);

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
