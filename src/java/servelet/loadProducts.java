package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.InvoiceProduct;
import pojos.InvoiceProductHasItem;
import pojos.PRate;
import pojos.Product;
import pojos.ProductHasPlatform;
import pojos.SfCategory;
import pojos.SfPlatform;

public class loadProducts extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            JSONObject json_obj = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(Product.class);
            c.add(Restrictions.eq("status", "active"));

            if (!json_obj.get("cata_id").toString().equals("all")) {
                SfCategory cata = (SfCategory) s.load(SfCategory.class, Integer.parseInt(json_obj.get("cata_id").toString()));

                c.add(Restrictions.eq("sfCategory", cata));

            }
            if (!json_obj.get("cata").toString().equals("all")) {
                SfCategory cata = (SfCategory) s.load(SfCategory.class, Integer.parseInt(json_obj.get("cata").toString()));

                c.add(Restrictions.eq("sfCategory", cata));

            }
            if (!json_obj.get("sf_type").toString().isEmpty()) {

                if (!json_obj.get("sf_type").toString().equals("all")) {

                    c.add(Restrictions.eq("sfType", json_obj.get("sf_type").toString()));

                }
            }

            if (!json_obj.get("sellTime").toString().isEmpty()) {

                if (!json_obj.get("sellTime").toString().equals("all")) {

                    c.add(Restrictions.eq("sellLimit", json_obj.get("sellTime").toString()));

                }
            }

            if (!json_obj.get("sp").toString().isEmpty() && !json_obj.get("ep").toString().isEmpty()) {

                c.add(Restrictions.between("price", Double.parseDouble(json_obj.get("sp").toString()), Double.parseDouble(json_obj.get("ep").toString())));

            }

            if (!json_obj.get("langu").toString().isEmpty() && !json_obj.get("langu").toString().equals("all")) {

                c.add(Restrictions.eq("sfLanguage", json_obj.get("langu").toString()));

            }
              if (json_obj.get("ra").toString().equals("true")) {

                c.add(Restrictions.eq("returnAccept", true));

            }
              if (!json_obj.get("searchBar").toString().isEmpty()) {

                c.add(Restrictions.like("title", json_obj.get("searchBar").toString(),MatchMode.START));

            }

            ArrayList platform_list = (ArrayList) json_obj.get("platform");
            if (!platform_list.isEmpty()) {

                for (int i = 0; i < platform_list.size(); i++) {

                    SfPlatform platform = (SfPlatform) s.load(SfPlatform.class, Integer.parseInt(platform_list.get(i).toString()));
                    System.out.println(platform.getName());
                    Criteria c2 = s.createCriteria(ProductHasPlatform.class);
                    c2.add(Restrictions.eq("sfPlatform", platform));

                    if (!c2.list().isEmpty()) {
                        List<ProductHasPlatform> php = c2.list();
                        for (ProductHasPlatform p : php) {
                            System.out.println(p.getProduct().getTitle() + " " + p.getProduct().getIdproduct());

                            c.add(Restrictions.eq("idproduct", Integer.parseInt("1")));
                        }

                    }

                }

            }
            //c.add(Restrictions.sqlRestriction("order by date"));

            if (!c.list().isEmpty()) {

                List<Product> p_list = c.list();

                JSONArray arr = new JSONArray();

                for (Product p : p_list) {

                    Criteria c3 = s.createCriteria(InvoiceProductHasItem.class);
                    c3.add(Restrictions.eq("product", p));

                    int soldQty = 0;
                    if (!c3.list().isEmpty()) {
                        //sold one

                        List<InvoiceProductHasItem> inv_items = c3.list();
                        for (InvoiceProductHasItem x : inv_items) {

                            Criteria c4 = s.createCriteria(InvoiceProduct.class);
                            c4.add(Restrictions.eq("idinvoiceProduct", x.getInvoiceProduct().getIdinvoiceProduct()));
                            c4.add(Restrictions.eq("status", "done"));
                            if (!c4.list().isEmpty()) {
                                //product and invoice matched with done payments

                                soldQty++;

                            }

                        }
                    }

                    String imgUrl = p.getImg1().replace(getServletContext().getRealPath("/"), "");

                    JSONObject o = new JSONObject();
                    o.put("pid", p.getIdproduct());
                    o.put("image", imgUrl);
                    o.put("title", p.getTitle());
                    o.put("small_des", p.getSmallDes());
                    o.put("price", p.getPrice());
                    o.put("seller", p.getSeller().getUser().getFirstName() + " " + p.getSeller().getUser().getLastName());
                    o.put("cata", p.getSfCategory().getCategoryName());
                    o.put("p_type", p.getSellLimit());
                    o.put("sold_qty", soldQty);

                    Criteria c2 = s.createCriteria(PRate.class);
                    c2.add(Restrictions.eq("product", p));

                    double overoll_rate = 0;

                    if (!c2.list().isEmpty()) {
                        double tot_rates = 0;
                        List<PRate> rates = c2.list();

                        for (PRate pRate : rates) {
                            tot_rates += pRate.getRate();
                        }

                        overoll_rate = (tot_rates / rates.size());
                    }

                    System.out.println(Math.round(overoll_rate));

                    o.put("overoll_rate", Math.round(overoll_rate));

                    //sold qty
                    arr.add(o);

                }
                resp.getWriter().write(arr.toJSONString());
            } else {
                resp.getWriter().write("0");;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

}
