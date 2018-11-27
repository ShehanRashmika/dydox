package servelet;

import classes.sessionCartItem;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import pojos.Cart;
import pojos.CartHasItem;

public class loadCartCount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            if (req.getSession().getAttribute("user") == null) {
                // not loged
                if (req.getSession().getAttribute("cart") == null) {
                    //have cart
                    resp.getWriter().write("0");

                } else {
                    ArrayList<sessionCartItem> arr = (ArrayList<sessionCartItem>) req.getSession().getAttribute("cart");
                    System.out.println("session cart size is" + arr.size());
                    String s = String.valueOf(arr.size());
                    resp.getWriter().write(s);

                }
            } else {
                // logged

                Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                Transaction t = s.beginTransaction();
                t.commit();
                Criteria c = s.createCriteria(Cart.class);
                c.add(Restrictions.eq("user", req.getSession().getAttribute("user")));

                        int count = 0;
                if (!c.list().isEmpty()) {
                    //cart found
                    Criteria c2 = s.createCriteria(CartHasItem.class);
                    c2.add(Restrictions.eq("cart", c.uniqueResult()));

                    if (!c2.list().isEmpty()) {
                        //cart item found

                        List<CartHasItem> list = c2.list();
                        System.out.println("db cart size" + list.size());
                        for (CartHasItem cartHasItem : list) {
                            count++;
                        }
                        String s2 = String.valueOf(list.size());


                    } else {
                        //no items in the cart
//                        resp.getWriter().write("0");
                    }
                } else {
                    //no cart for user
//                    resp.getWriter().write("0");
                }
                        resp.getWriter().write(String.valueOf(count));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
