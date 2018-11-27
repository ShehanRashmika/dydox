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
import pojos.InvoiceProduct;
import pojos.InvoiceProductHasItem;
import pojos.Product;
import pojos.User;
import pojos.WishList;
import pojos.WishListHasItem;

public class addToWishlist extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            User user = (User) req.getSession().getAttribute("user");
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Product p = (Product) s.load(Product.class, Integer.parseInt(req.getParameter("pid")));

            if (user != null) {
                System.out.println("user logged");

                if (user.getIduser().equals(p.getSeller().getUser().getIduser())) {
                    //user and seller same
                    System.out.println("user and seller same");
                    resp.getWriter().write("6");
                } else {
                    System.out.println("user ok");

                    boolean isBrought = false;

                    Criteria c3 = s.createCriteria(InvoiceProduct.class);
                    c3.add(Restrictions.eq("user", user));
                    c3.add(Restrictions.eq("status", "done"));
                    if (!c3.list().isEmpty()) {
                        //user brought products

                        List<InvoiceProduct> inv = c3.list();

                        for (InvoiceProduct k : inv) {

                            Criteria c4 = s.createCriteria(InvoiceProductHasItem.class);
                            c4.add(Restrictions.eq("invoiceProduct", k));

                            if (!c4.list().isEmpty()) {
                                //have products
                                List<InvoiceProductHasItem> inv_items = c4.list();
                                for (InvoiceProductHasItem invI : inv_items) {

                                    if (p.getIdproduct().equals(invI.getProduct().getIdproduct())) {
                                        //this user alredy brought this product 
                                        isBrought = true;
                                        break;
                                    } else {
                                        //did not brought this product yet
                                        isBrought = false;
                                    }
                                }

                            } else {
                                //no products
                            }

                        }

                    } else {
                        //not brought anything
                        isBrought = false;
                    }

                    if (!isBrought) {

                        Criteria c = s.createCriteria(WishList.class);
                        c.add(Restrictions.eq("user", user));

                        if (!c.list().isEmpty()) {
                            System.out.println("user has wish list");

                            Criteria c2 = s.createCriteria(WishListHasItem.class);

                            c2.add(Restrictions.eq("product", p));
                            c2.add(Restrictions.eq("wishList", (WishList) c.uniqueResult()));

                            if (c2.list().isEmpty()) {
                                //no matching products
                                System.out.println("no matching products");

                                WishList wlist = (WishList) c.uniqueResult();

                                WishListHasItem wlist_items = new WishListHasItem();
                                wlist_items.setWishList(wlist);
                                wlist_items.setProduct(p);

                                s.save(wlist_items);
                                Transaction t = s.beginTransaction();
                                t.commit();

                                resp.getWriter().write("4");
                            } else {
                                //have matching products

                                resp.getWriter().write("3");
                            }
                        } else {
                            System.out.println("user not has wish list");

                            WishList wishL = new WishList();
                            wishL.setUser(user);

                            s.save(wishL);

                            WishListHasItem w_items = new WishListHasItem();
                            w_items.setWishList(wishL);
                            w_items.setProduct(p);

                            s.save(w_items);

                            Transaction t = s.beginTransaction();
                            t.commit();

                            resp.getWriter().write("5");
                        }
                    } else {

                        resp.getWriter().write("7");
                    }
                }
            } else {
                System.out.println("user not logged");
                resp.getWriter().write("1");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
