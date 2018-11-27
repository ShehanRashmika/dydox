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
import pojos.WishList;
import pojos.WishListHasItem;

public class removeWishListItem extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int pid = Integer.parseInt(req.getParameter("pid"));
            System.out.println(pid);
            if (req.getSession().getAttribute("user") != null) {
                //user logged

                Session s = util.NewHibernateUtil.getSessionFactory().openSession();

                Criteria c1 = s.createCriteria(WishList.class);
                c1.add(Restrictions.eq("user", req.getSession().getAttribute("user")));
                WishList wlist = (WishList) c1.uniqueResult();

                Criteria c = s.createCriteria(WishListHasItem.class);
                c.add(Restrictions.eq("wishList", wlist));

                List<WishListHasItem> w_item = c.list();
                for (WishListHasItem whi : w_item) {
                    System.out.println(whi.getProduct().getIdproduct());

                   if (whi.getProduct().getIdproduct().equals(pid)) {
                        WishListHasItem chi = (WishListHasItem) s.load(WishListHasItem.class, whi.getIdwishListHasItem());
                        s.delete(chi);
                        Transaction t = s.beginTransaction();
                        t.commit();
                    } else {

                    }

                }

                resp.getWriter().write("item(s) remove success!");

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
