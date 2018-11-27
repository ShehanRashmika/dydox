package servelet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import pojos.InvoicePackage;
import pojos.Seller;
import pojos.SellerHasPackage;
import pojos.SellerPackage;
import pojos.User;

public class sendMemReq extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(SellerPackage.class);
            User user = (User) req.getSession().getAttribute("user");

            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            String p = o.get("package").toString();
            String email = o.get("email").toString();

            c.add(Restrictions.eq("name", p));

            if (!c.list().isEmpty()) {
                SellerPackage spackage = (SellerPackage) c.uniqueResult();

                if (user.getEmail().equals(email)) {
                    Criteria c2 = s.createCriteria(Seller.class);

                    c2.add(Restrictions.eq("user", user));

                    if (!c2.list().isEmpty()) {
                        //alredy have seller account
                        System.out.println("alredy have seller acount");
                        c2.add(Restrictions.eq("status", "pending"));

                        if (!c2.list().isEmpty()) {
                            //account is pending
                            System.out.println("account is pending");
                            resp.getWriter().write("4");
                        } else {
                            //account is approved
                            System.out.println("account is approved");
                            Criteria c4 = s.createCriteria(Seller.class);
                            c4.add(Restrictions.eq("user", user));
                            c4.add(Restrictions.eq("status", "approved"));

                            Seller seller = (Seller) c4.uniqueResult();

                            Criteria c3 = s.createCriteria(SellerHasPackage.class);
                            c3.add(Restrictions.eq("seller", seller));

                            List<SellerHasPackage> shp_list = c3.list();

                            int all_addTime = 0;
                            boolean isNewOne = false;

                            for (SellerHasPackage sh : shp_list) {

                                all_addTime += sh.getRemainingAddTime();

//                                if (spackage.getIdpackage() == sh.getSellerPackage().getIdpackage()) {
//                                    // u alredy got this package
//                                    resp.getWriter().write("8");
//                                } else {
//                                    //new package
//                                    isNewOne = true;
//                                }
                            }

                            //if (isNewOne) {

                                System.out.println(all_addTime);
                                if (all_addTime == 0) {
                                    // can get new package
                                    System.out.println("can get new package");

                                    SellerHasPackage shp = new SellerHasPackage();
                                    shp.setSeller(seller);
                                    shp.setSellerPackage(spackage);
                                    shp.setRemainingAddTime(spackage.getMaxAddTime());

                                    if (spackage.getName().equals("Free")) {

                                        resp.getWriter().write("5");
                                        shp.setStatus("active");
                                        s.save(shp);
                                    } else {

                                        shp.setStatus("inactive");
                                        s.save(shp);

                                        InvoicePackage inv = new InvoicePackage();

                                        SimpleDateFormat sdf = new SimpleDateFormat("yyy-mm-dd");
                                        Date date = sdf.parse(sdf.format(new Date()));
                                        System.out.println(new Date());
                                        inv.setDate(new Date());
                                        inv.setUser(user);
                                        inv.setSellerHasPackage(shp);
                                        inv.setStatus("pending");

                                        s.save(inv);

                                        req.getSession().setAttribute("package", inv);
                                        req.getSession().setAttribute("shp", shp);

                                        resp.getWriter().write("6");
                                    }

                                    Transaction t = s.beginTransaction();
                                    t.commit();

                                } else {
                                    //cant get new package alredy have package
                                    System.out.println("alredy have package");
                                    resp.getWriter().write("3");
                                }

                            }

                       // }

                    } else {
                        //new seller
                        System.out.println("new seller");
                        Seller seller = new Seller();
                        seller.setUser(user);
                        seller.setStatus("pending");

                        s.save(seller);

                        SellerHasPackage shp = new SellerHasPackage();
                        shp.setSeller(seller);
                        shp.setSellerPackage(spackage);
                        shp.setRemainingAddTime(spackage.getMaxAddTime());

                        if (spackage.getName().equals("Free")) {
                            shp.setStatus("active");
                            System.out.println("free");
                            resp.getWriter().write("5");
                            s.save(shp);
                        } else{

                            shp.setStatus("inactive");
                            s.save(shp);

                            System.out.println("siver or gold");

                            InvoicePackage inv = new InvoicePackage();

                            SimpleDateFormat sdf = new SimpleDateFormat("yyy-mm-dd");
                            Date date = sdf.parse(sdf.format(new Date()));
                            System.out.println(date);
                            inv.setDate(new Date());
                            inv.setUser(user);
                            inv.setSellerHasPackage(shp);
                            inv.setStatus("pending");

                            s.save(inv);

                            req.getSession().setAttribute("package", inv);
                            req.getSession().setAttribute("shp", shp);
                            resp.getWriter().write("6");

                        }

                        Transaction t = s.beginTransaction();
                        t.commit();

                    }

                } else {
                    //email wrong
                    System.out.println("wrong emails");
                    resp.getWriter().write("1");
                }

            } else {
                //wrong packages
                System.out.println("wrong packages");
                resp.getWriter().write("2");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
