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
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Notifications;
import pojos.Product;
import pojos.Seller;
import pojos.User;

public class setUserStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            if (!o.get("mainST").toString().isEmpty() && !o.get("uid").toString().isEmpty() && !o.get("status").toString().isEmpty()) {
                //uid and status received
                if (o.get("mainST").toString().equals("member")) {

                    if (o.get("uid").toString().equals("all")) {
                        System.out.println("match");

                        Criteria c = s.createCriteria(Seller.class);
                        List<Seller> sellers = c.list();
                        for (Seller sel : sellers) {

                            Seller seller = (Seller) s.load(Seller.class, sel.getIdseller());
                            seller.setStatus(o.get("status").toString());
                            s.update(seller);
                        }
                        resp.getWriter().write("1");
                    } else {

                        Seller seller = (Seller) s.load(Seller.class, Integer.parseInt(o.get("uid").toString()));

                        seller.setStatus(o.get("status").toString());
                        s.update(seller);

                        Notifications n = new Notifications();
                        n.setType("Seller");
                        n.setMessage("Seller Status Updated to " + o.get("status"));
                        n.setUser(seller.getUser());
                        n.setStatus("notRead");
                        s.save(n);

                        resp.getWriter().write("1");
                    }

                } else if (o.get("mainST").toString().equals("user")) {

                    if (o.get("uid").toString().equals("all")) {
                        System.out.println("match");

                        Criteria c = s.createCriteria(User.class);
                        List<User> users = c.list();
                        for (User u : users) {

                            User user = (User) s.load(User.class, u.getIduser());
                            user.setStatus(o.get("status").toString());
                            s.update(user);
                        }
                        resp.getWriter().write("1");
                    } else {

                        User user = (User) s.load(User.class, Integer.parseInt(o.get("uid").toString()));

                        user.setStatus(o.get("status").toString());
                        s.update(user);

                        Notifications n = new Notifications();
                        n.setType("User");
                        n.setMessage("User Status Updated to " + o.get("status"));
                        n.setUser(user);
                        n.setStatus("notRead");
                        s.save(n);

                        resp.getWriter().write("1");
                    }
                } else if (o.get("mainST").toString().equals("product")) {
                    Product p = (Product) s.load(Product.class, Integer.parseInt(o.get("uid").toString()));
                    p.setStatus(o.get("status").toString());
                    s.update(p);

                    Notifications n = new Notifications();
                    n.setType("Product");
                    n.setMessage(p.getTitle() + " Status Updated to " + o.get("status"));
                    n.setUser(p.getSeller().getUser());
                    n.setStatus("notRead");
                    s.save(n);

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
