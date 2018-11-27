package servelet;

import classes.sessionCartItem;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
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

public class removeItem extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int pid = Integer.parseInt(req.getParameter("pid"));
            System.out.println(pid);
            if (req.getSession().getAttribute("user") != null) {
                //user logged

                Session s = util.NewHibernateUtil.getSessionFactory().openSession();

                Criteria c1 = s.createCriteria(Cart.class);
                c1.add(Restrictions.eq("user", req.getSession().getAttribute("user")));
                Cart cart = (Cart) c1.uniqueResult();

                Criteria c = s.createCriteria(CartHasItem.class);
                c.add(Restrictions.eq("cart", cart));

                List<CartHasItem> cart_item = c.list();
                for (CartHasItem cartHasItem : cart_item) {
                    System.out.println(cartHasItem.getProduct().getIdproduct());

                    if (cartHasItem.getProduct().getIdproduct().equals(pid)) {
                        CartHasItem chi = (CartHasItem) s.load(CartHasItem.class, cartHasItem.getIdcartHasItem());
                        s.delete(chi);
                        Transaction t = s.beginTransaction();
                        t.commit();
                    } else {

                    }

                }

                resp.getWriter().write("item(s) remove success!");

            } else {
                //user not logged

                if (req.getSession().getAttribute("cart") != null) {
                    //cart set
                    System.out.println("cart set");

                    ArrayList<sessionCartItem> arr = (ArrayList<sessionCartItem>) req.getSession().getAttribute("cart");
                    Iterator<sessionCartItem> it = (Iterator<sessionCartItem>) arr.iterator();
                    while (it.hasNext()) {
                        sessionCartItem p = it.next();
                        if (p.getProduct().getIdproduct() == pid) {
                            it.remove();
                            resp.getWriter().write("1");
                        }
                    }

                } else {
                    //cart not set
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
