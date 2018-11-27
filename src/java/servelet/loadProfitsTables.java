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
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.InvoicePackage;
import pojos.InvoiceProduct;
import pojos.InvoiceProductHasItem;
import pojos.Seller;
import pojos.SellerHasPackage;

public class loadProfitsTables extends HttpServlet {

    double tot_income_package;
    double tot_income_product;
    double tot_cost;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            System.out.println("ok");
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            if (!jsonOBJ.get("status").toString().isEmpty()) {

                if (jsonOBJ.get("status").toString().equals("package")) {
                    Criteria c = s.createCriteria(InvoicePackage.class);
                    c.add(Restrictions.eq("status", "done"));
                    if (!jsonOBJ.get("date").toString().isEmpty() && !jsonOBJ.get("date2").toString().isEmpty()) {

                        Date d = new SimpleDateFormat("yyy-MM-dd").parse(jsonOBJ.get("date").toString());
                        Date d2 = new SimpleDateFormat("yyy-MM-dd").parse(jsonOBJ.get("date2").toString());
                        c.add(Restrictions.between("date", d, d2));

                    }
                    List<InvoicePackage> inv_list = c.list();

                    JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
                    tot_income_package = 0;
                    for (InvoicePackage inv : inv_list) {
                        JSONObject o = new JSONObject();//

                        o.put("pack_date", inv.getDate() + "");
                        o.put("pack_amount", inv.getSellerHasPackage().getSellerPackage().getPrice());
                        tot_income_package += inv.getSellerHasPackage().getSellerPackage().getPrice();
                        array.add(o);

                    }
                    resp.getWriter().write(array.toJSONString());
                } else if (jsonOBJ.get("status").toString().equals("product")) {
                    Criteria c = s.createCriteria(InvoiceProduct.class);
                    c.add(Restrictions.eq("status", "done"));
                    if (!jsonOBJ.get("date3").toString().isEmpty() && !jsonOBJ.get("date4").toString().isEmpty()) {

                        Date d = new SimpleDateFormat("yyy-MM-dd").parse(jsonOBJ.get("date3").toString());
                        Date d2 = new SimpleDateFormat("yyy-MM-dd").parse(jsonOBJ.get("date4").toString());
                        c.add(Restrictions.between("date", d, d2));

                    }
                    List<InvoiceProduct> inv_list = c.list();

                    JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
                    tot_income_product = 0;
                    for (InvoiceProduct inv : inv_list) {
                        JSONObject o = new JSONObject();//

                        o.put("pro_date", inv.getDate() + "");
                        o.put("pro_time", inv.getTime() + "");
                        o.put("pro_amount", inv.getTotal());
                        tot_income_product += inv.getTotal();
                        array.add(o);

                    }
                    resp.getWriter().write(array.toJSONString());

                } else if (jsonOBJ.get("status").toString().equals("seller_cost")) {
                    Criteria c1 = s.createCriteria(InvoiceProduct.class);
                    c1.add(Restrictions.eq("status", "done"));
                    JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
                    if (!c1.list().isEmpty()) {

                        List<InvoiceProduct> inv = c1.list();
                        tot_cost = 0;
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
                                        JSONObject o = new JSONObject();//

                                        o.put("sid", item.getProduct().getSeller().getIdseller());
                                        o.put("seller_cost", sellerPayment);
                                        tot_cost += sellerPayment;

                                        array.add(o);
                                    }

                                }

                            }
                        }

                    }
                    resp.getWriter().write(array.toJSONString());

                } else if (jsonOBJ.get("status").toString().equals("totals")) {
                    double tot_income = tot_income_product + tot_income_package;
                    double profit = tot_income-tot_cost;
                    resp.getWriter().write(tot_income + "," + tot_cost+","+profit);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
