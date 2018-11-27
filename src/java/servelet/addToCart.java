package servelet;

import classes.sessionCartItem;
import java.io.IOException;
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
import pojos.InvoiceProduct;
import pojos.InvoiceProductHasItem;
import pojos.Product;
import pojos.User;

public class addToCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*
        
                
      
        
         */
        try {
            System.out.println("in the server");
            User user = (User) req.getSession().getAttribute("user");
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Product p = (Product) s.load(Product.class, Integer.parseInt(req.getParameter("pid")));
            if (user != null) {
                System.out.println("ok");
                System.out.println("user loged added to db cart");

                if (user.getIduser().equals(p.getSeller().getUser().getIduser())) {
                    //user and seller same
                    resp.getWriter().write("6");
                } else {
                    //user and seller diffrent

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

                        Criteria c = s.createCriteria(Cart.class);
                        c.add(Restrictions.eq("user", user));
                        if (c.list().isEmpty()) {
                            //user has no cart
                            System.out.println("user has no cart");

                            Cart cart = new Cart();
                            cart.setUser(user);

                            s.save(cart);

                            CartHasItem cart_item = new CartHasItem();
                            cart_item.setCart(cart);
                            cart_item.setProduct(p);

                            s.save(cart_item);

                            Transaction t = s.beginTransaction();
                            t.commit();

                            resp.getWriter().write("5");

                        } else {
                            //user has cart
                            System.out.println("user has cart");

                            Criteria c2 = s.createCriteria(CartHasItem.class);

                            c2.add(Restrictions.eq("product", p));
                            c2.add(Restrictions.eq("cart", (Cart) c.uniqueResult()));

                            if (c2.list().isEmpty()) {
                                //no matching products
                                System.out.println("no matching products in cart");

                                Cart cart = (Cart) c.uniqueResult();

                                CartHasItem cart_item_2 = new CartHasItem();
                                cart_item_2.setCart(cart);
                                cart_item_2.setProduct(p);

                                s.save(cart_item_2);
                                Transaction t = s.beginTransaction();
                                t.commit();

                                resp.getWriter().write("4");
                            } else {
                                //have matching products

                                resp.getWriter().write("3");
                            }
                        }
                    } else {
                        //alredy brought
                        resp.getWriter().write("7");
                    }
                }

            } else {
                System.out.println("user not loged added to session cart");

                if (req.getSession().getAttribute("cart") != null) {
                    System.out.println("alredy have session cart");

                    boolean isItemFound = false;
                    ArrayList<sessionCartItem> arr = (ArrayList<sessionCartItem>) req.getSession().getAttribute("cart");
                    for (sessionCartItem sci : arr) {
                        //read arraylist one by one   

                        if (sci.getProduct().getIdproduct().equals(p.getIdproduct())) {
                            //item found in session cart...update qty
                            System.out.println("item found");

                            resp.getWriter().write("3");

                            isItemFound = true;
                            break;
                        } else {
                            //item not found..add new one
                        }
                    }

                    if (!isItemFound) {
                        //item not in session cart..add new one
                        System.out.println("new item");
                        sessionCartItem sci = new sessionCartItem();
                        sci.setProduct(p);

                        arr.add(sci);
                        resp.getWriter().write("2");
                    }
                } else {
                    System.out.println("new session cart");

                    ArrayList<sessionCartItem> arr = new ArrayList<>();

                    sessionCartItem sci = new sessionCartItem();
                    sci.setProduct(p);
                    arr.add(sci);

                    req.getSession().setAttribute("cart", arr);
                    resp.getWriter().write("1");
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
