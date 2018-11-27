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
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Cart;
import pojos.CartHasItem;
import pojos.Product;
import pojos.User;

public class log extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(User.class);

            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            c.add(Restrictions.eq("email", o.get("email")));
            c.add(Restrictions.eq("password", o.get("password")));
            c.add(Restrictions.eq("status", "confirmed"));

            if (!c.list().isEmpty()) {
                System.out.println("user found");

                User user = (User) c.uniqueResult();

                user.setType("online");
                s.update(user);
                Transaction t = s.beginTransaction();
                t.commit();

                req.getSession().setAttribute("user", user);

                if (req.getSession().getAttribute("cart") != null) {
                    //user has cart
                    System.out.println("session cart found");
                    ArrayList<sessionCartItem> arr = (ArrayList) req.getSession().getAttribute("cart");

                    if (arr.isEmpty()) {
                        //cart is empty
                        System.out.println("array is empty");

                    } else {
                        //cart has item
                        System.out.println("array has item");
                        boolean isUser = false;

                        Iterator<sessionCartItem> it = (Iterator<sessionCartItem>) arr.iterator();
                        while (it.hasNext()) {

                            sessionCartItem sci = it.next();

                            if (sci.getProduct().getSeller().getUser().getIduser().equals(user.getIduser())) {
                                //user and seller same
                                System.out.println("user and seller is same in pid - " + sci.getProduct().getIdproduct());
                                it.remove();
                            } else {

                            }

                        }

                        Criteria c1 = s.createCriteria(Cart.class);
                        c1.add(Restrictions.eq("user", user));

                        if (c1.list().isEmpty()) {
                            //no db cart
                            System.out.println("no db cart");

                            //insert new cart
                            Cart cart = new Cart();
                            cart.setUser(user);
                            s.save(cart);

                            //insert new item from session cart to new cart has item
                            for (sessionCartItem ct : arr) {
                                //get session cart item one by one
                                CartHasItem cart_item = new CartHasItem();
                                cart_item.setCart(cart);
                                cart_item.setProduct(ct.getProduct());
                                s.save(cart_item);
                            }
                            Transaction t2 = s.beginTransaction();
                            t2.commit();

                        } else {
                            //have db cart
                            System.out.println("have db cart");

                            Cart cart = (Cart) c1.uniqueResult();
                            Criteria c2 = s.createCriteria(CartHasItem.class);
                            c2.add(Restrictions.eq("cart", cart));

                            if (c2.list().isEmpty()) {
                                //db cart empty
                                System.out.println("db cart empty");

                                for (sessionCartItem ct : arr) {
                                    //get session cart item one by one
                                    CartHasItem cart_item = new CartHasItem();
                                    cart_item.setCart(cart);
                                    cart_item.setProduct(ct.getProduct());
                                    s.save(cart_item);
                                }
                                Transaction t3 = s.beginTransaction();
                                t3.commit();

                            } else {
                                //db cart has item
                                System.out.println("db cart has item");

                                List<CartHasItem> list = c2.list();

                                for (sessionCartItem sci : arr) {
                                    //get session cart item one by one
                                    boolean isFound = false;

                                    for (CartHasItem chi : list) {
                                        //get cart item one by one

                                        if (sci.getProduct().getIdproduct().equals(chi.getProduct().getIdproduct())) {
                                            //session item found in db
                                            System.out.println("session cart item found in db cart");
                                            isFound = true;

                                        }

                                    }
                                    if (!isFound) {
                                        System.out.println("new cart item");
                                        CartHasItem cart_item = new CartHasItem();
                                        cart_item.setCart(cart);
                                        cart_item.setProduct(sci.getProduct());
                                        s.save(cart_item);
                                    }

                                }

                                Transaction t4 = s.beginTransaction();
                                t4.commit();

                            }
                        }

                    }

                } else {
                    //no session cart
                    System.out.println("no session cart");

                }

                if (req.getSession().getAttribute("page") != null) {
                    String page = req.getSession().getAttribute("page").toString().split(",")[0];
                    String pid = req.getSession().getAttribute("page").toString().split(",")[1];
                    System.out.println(page);
                    System.out.println(pid);

                    if (page.equals("member_area.jsp")) {
                        System.out.println("try to log to member area");
                        resp.getWriter().write("2");

                    } else if (page.equals("view_more.jsp")) {
                        System.out.println("try to log to view more pid is" + pid);
                        resp.getWriter().write("3," + pid);

                    } else if (page.equals("cart.jsp")) {
                        System.out.println("try to log to cart");

                        resp.getWriter().write("4");
                    } else if (page.equals("product_view.jsp")) {
                        System.out.println("try to log to pView");

                        resp.getWriter().write("5");
                    }else if (page.equals("req_projects.jsp")) {
                        System.out.println("try to log to reqP");

                        resp.getWriter().write("7");
                    }

                    req.getSession().removeAttribute("page");
                } else {

                    System.out.println("ok");
                    resp.getWriter().write("1");
                }

            } else {
                System.out.println("user not found");
                Criteria in = s.createCriteria(User.class);

                in.add(Restrictions.eq("email", o.get("email")));
                in.add(Restrictions.eq("password", o.get("password")));
                in.add(Restrictions.eq("status", "inactive"));

                if (!in.list().isEmpty()) {

                    resp.getWriter().write("6");

                } else {
                    resp.getWriter().write("0");

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
