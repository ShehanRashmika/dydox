package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import pojos.Cart;
import pojos.CartHasItem;
import pojos.InvoiceProduct;
import pojos.InvoiceProductHasItem;
import pojos.User;

public class checkOutCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        Session s = util.NewHibernateUtil.getSessionFactory().openSession();

        if (user != null) {
            //loged
            String i1 = (String) req.getSession().getAttribute("invoice_1");
            String i2 = (String) req.getSession().getAttribute("invoice_2");

            double subTot = Double.parseDouble(i1.split(",")[0]);
            double addonTot = Double.parseDouble(i1.split(",")[1]);

            double disTot = Double.parseDouble(i2.split(",")[0]);
            double Tot = Double.parseDouble(i2.split(",")[1]);

            System.out.println(subTot);
            System.out.println(addonTot);
            System.out.println(disTot);
            System.out.println(Tot);

            Criteria c = s.createCriteria(Cart.class);
            c.add(Restrictions.eq("user", user));
            if (!c.list().isEmpty()) {
                Criteria c2 = s.createCriteria(CartHasItem.class);
                c2.add(Restrictions.eq("cart", (Cart) c.uniqueResult()));

                if (!c2.list().isEmpty()) {
                    System.out.println("cart has items");

                    InvoiceProduct inv = new InvoiceProduct();
                    inv.setDate(new Date());
                    inv.setTime(new Date());
                    inv.setSubTot(subTot);
                    inv.setAddonTot(addonTot);
                    inv.setDisTot(disTot);
                    inv.setTotal(Tot);
                    inv.setStatus("pending");
                    inv.setUser(user);

                    s.save(inv);

                    List<CartHasItem> item_list = c2.list();

                    for (CartHasItem chi : item_list) {
                        InvoiceProductHasItem items = new InvoiceProductHasItem();
                        items.setInvoiceProduct(inv);
                        items.setProduct(chi.getProduct());
                        s.save(items);
                        System.out.println(chi.getProduct().getIdproduct()+ " ok");
                    }

                    Transaction t = s.beginTransaction();
                    t.commit();
                    
                    req.getSession().setAttribute("inv", inv);
                    resp.sendRedirect("checkOutCart.jsp");
                    
                    System.out.println("all done in checkOut servlet");
                } else {

                    resp.sendRedirect("cart.jsp");
                }
            } else {
                resp.sendRedirect("cart.jsp");

            }

        } else {
            //not loged
            req.getSession().setAttribute("page", "cart.jsp,0");
            resp.sendRedirect("index.jsp");
        }

    }

}
