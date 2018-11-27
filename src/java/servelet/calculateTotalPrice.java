package servelet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Seller;
import pojos.SellerHasPackage;
import pojos.SellerPackage;
import pojos.User;

public class calculateTotalPrice extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            User user = (User) req.getSession().getAttribute("user");
           
            boolean isDouble = false;
            double price = 0;
            try {
                price = Double.parseDouble(o.get("price").toString());

                isDouble = true;
            } catch (Exception e) {
                isDouble = false;
            }

            if (o.get("price").toString().equals("") || !isDouble) {
                //no value
                System.out.println("null or invalid");
                resp.getWriter().write("0");

            } else {
                //value enter
                if (o.get("type").toString().equals("price")) {
                    if (price <= 0) {
                        resp.getWriter().write("0");

                    } else {

                        Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                        Criteria c = s.createCriteria(Seller.class);
                        c.add(Restrictions.eq("user", user));

                        if (!c.list().isEmpty()) {
                            //found seller
                            Seller seller = (Seller) c.uniqueResult();
                            Criteria c2 = s.createCriteria(SellerHasPackage.class);

                            c2.add(Restrictions.eq("seller", seller));
                            c2.add(Restrictions.eq("status", "active"));

                            if (!c2.list().isEmpty()) {
                                //found active
                                SellerHasPackage shp = (SellerHasPackage) c2.uniqueResult();

                                double package_pr = Double.parseDouble(shp.getSellerPackage().getProfitPercentage().toString());

                                double tot = price - (price * package_pr / 100);

                                resp.getWriter().write("3," + tot);

                            } else {
                                //no active packages
                                resp.getWriter().write("2");
                            }
                        } else {
                            //no seller
                            resp.getWriter().write("1");
                        }

                    }

                }else if (o.get("type").toString().equals("addon") || o.get("type").toString().equals("dis")) {
                    
                    if (price<0) {
                        System.out.println("before 0");
                        resp.getWriter().write("0");
                    }else{
                        resp.getWriter().write("4");
                    }
                  
                }
            

        }

    }
    catch (Exception e

    
        ) {
            e.printStackTrace();
    }

}

}
