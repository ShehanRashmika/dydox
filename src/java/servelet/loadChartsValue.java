package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import pojos.InvoicePackage;
import pojos.InvoiceProduct;
import pojos.InvoiceProductHasItem;
import pojos.Product;
import pojos.Seller;
import pojos.SellerHasPackage;
import pojos.User;

public class loadChartsValue extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            
            String status = req.getParameter("status");
            System.out.println(status);
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            if (status.equals("pie1")) {
                Criteria c = s.createCriteria(InvoiceProduct.class);
                c.add(Restrictions.eq("status", "done"));
                c.setProjection(Projections.sum("total"));
                double totalProduct = (Double) c.uniqueResult();
                System.out.println("Total = " + totalProduct);
                
                Criteria c4 = s.createCriteria(InvoicePackage.class);
                c4.add(Restrictions.eq("status", "done"));
                
                List<InvoicePackage> inv_list2 = c4.list();
                
                double tot_income_package = 0;
                for (InvoicePackage inv : inv_list2) {
                    
                    tot_income_package += inv.getSellerHasPackage().getSellerPackage().getPrice();
                    
                }
                
                double tot_cost = 0;
                Criteria c1 = s.createCriteria(InvoiceProduct.class);
                c1.add(Restrictions.eq("status", "done"));
                JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
                if (!c1.list().isEmpty()) {
                    
                    List<InvoiceProduct> inv = c1.list();
                    
                    for (InvoiceProduct i : inv) {
                        Criteria c2 = s.createCriteria(InvoiceProductHasItem.class);
                        c2.add(Restrictions.eq("invoiceProduct", i));
                        //status add

                        if (!c2.list().isEmpty()) {
                            
                            List<InvoiceProductHasItem> items = c2.list();
                            for (InvoiceProductHasItem item : items) {
                                
                                Seller seller = (Seller) s.load(Seller.class, item.getProduct().getSeller().getIdseller());
                                
                                Criteria c3 = s.createCriteria(SellerHasPackage.class);
                                c3.add(Restrictions.eq("seller", seller));
                                c3.add(Restrictions.eq("status", "active"));
                                double sellerPayment = 0;
                                if (!c3.list().isEmpty()) {
                                    System.out.println(item.getProduct().getIdproduct());
                                    SellerHasPackage shp = (SellerHasPackage) c3.uniqueResult();
                                    double product_price = item.getProduct().getPrice();
                                    double presantage = shp.getSellerPackage().getProfitPercentage();
                                    
                                    sellerPayment = product_price - (product_price * presantage / 100);
                                    
                                    tot_cost += sellerPayment;
                                    
                                }
                                
                            }
                            
                        }
                    }
                    
                }
                double profit = (totalProduct + tot_income_package) - tot_cost;
                resp.getWriter().write(totalProduct + "," + tot_income_package + "," + tot_cost + "," + profit);
            } else if (status.equals("bar1")) {
                
                Criteria c = s.createCriteria(InvoiceProduct.class);
                c.add(Restrictions.eq("status", "done"));
                
                if (!c.list().isEmpty()) {
                    
                    List<InvoiceProduct> inv = c.list();
                    
                    String last_date = "";
                    JSONArray arr = new JSONArray();
                    for (InvoiceProduct i : inv) {
                        JSONObject o = new JSONObject();
                        o.put("date", i.getDate() + "");
                        o.put("total", i.getTotal().toString());
                        System.out.println(i.getDate().toString());
                        arr.add(o);
                        
                    }
                    resp.getWriter().write(arr.toJSONString());
                }
                
            } else if (status.equals("bar2")) {
                
                Criteria c4 = s.createCriteria(InvoicePackage.class);
                c4.add(Restrictions.eq("status", "done"));
                
                List<InvoicePackage> inv_list2 = c4.list();
                
                JSONArray arr = new JSONArray();
                for (InvoicePackage inv : inv_list2) {
                    JSONObject o = new JSONObject();
                    o.put("date", inv.getDate() + "");
                    o.put("total", inv.getSellerHasPackage().getSellerPackage().getPrice());
                    arr.add(o);
                }
                resp.getWriter().write(arr.toJSONString());
            } else if (status.equals("bar3")) {
                
                Criteria c = s.createCriteria(User.class);
                
                if (!c.list().isEmpty()) {
                    
                    List<User> user = c.list();
                    JSONArray arr = new JSONArray();
                    for (User u : user) {
                        Criteria c1 = s.createCriteria(InvoiceProduct.class);
                        c1.add(Restrictions.eq("user", u));
                        c1.add(Restrictions.eq("status", "done"));
                        if (!c1.list().isEmpty()) {
                            List<InvoiceProduct> inv = c1.list();
                            double userTot = 0;
                            for (InvoiceProduct inv_list : inv) {
                                
                                userTot += inv_list.getTotal();
                            }
                            JSONObject o = new JSONObject();
                            o.put("uid", u.getIduser());
                            o.put("total", userTot);
                            arr.add(o);
                            
                        }
                        
                    }
                    resp.getWriter().write(arr.toJSONString());
                }
                
            } else if (status.equals("pie2")) {
                
                Criteria c = s.createCriteria(Product.class);
                c.add(Restrictions.eq("status", "active"));
                c.setProjection(Projections.count("idproduct"));
                long active_count = (Long) c.uniqueResult();
                
                Criteria c2 = s.createCriteria(Product.class);
                c2.add(Restrictions.eq("status", "inactive"));
                c2.setProjection(Projections.count("idproduct"));
                long inactive_count = (Long) c2.uniqueResult();
                
                Criteria c3 = s.createCriteria(Product.class);
                c3.add(Restrictions.eq("status", "pending"));
                c3.setProjection(Projections.count("idproduct"));
                long pending_count = (Long) c3.uniqueResult();
                
                Criteria c4 = s.createCriteria(Product.class);
                c4.add(Restrictions.eq("status", "rejected"));
                c4.setProjection(Projections.count("idproduct"));
                long reject_count = (Long) c4.uniqueResult();
                
                Criteria c5 = s.createCriteria(Product.class);
                c5.add(Restrictions.eq("status", "sold"));
                c5.setProjection(Projections.count("idproduct"));
                long sold_count = (Long) c5.uniqueResult();
                
                resp.getWriter().write(active_count + "," + inactive_count + "," + pending_count + "," + reject_count + "," + sold_count);
                
            } else if (status.equals("pie3")) {
                Criteria c = s.createCriteria(User.class);
                c.add(Restrictions.eq("status", "confirmed"));
                c.setProjection(Projections.count("iduser"));
                long confirmed_count = (Long) c.uniqueResult();
                
                Criteria c2 = s.createCriteria(User.class);
                c2.add(Restrictions.eq("status", "inactive"));
                c2.setProjection(Projections.count("iduser"));
                long inactive_count = (Long) c2.uniqueResult();
                
                Criteria c3 = s.createCriteria(User.class);
                c3.add(Restrictions.eq("status", "pending"));
                c3.setProjection(Projections.count("iduser"));
                long pending_count = (Long) c3.uniqueResult();
                
                System.out.println("con "+confirmed_count);
                System.out.println("in "+inactive_count);
                System.out.println("pen "+pending_count);
                resp.getWriter().write(confirmed_count + "," + inactive_count + "," + pending_count);
                
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
