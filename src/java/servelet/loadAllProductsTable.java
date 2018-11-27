package servelet;

import java.io.IOException;
import java.io.PrintWriter;
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
import pojos.Disandaddon;
import pojos.PRate;
import pojos.Product;
import pojos.ProductHasPlatform;
import pojos.ProductHasSupportOs;
import pojos.SfCategory;
import pojos.SfPlatform;
import pojos.SupportOs;
import pojos.User;

public class loadAllProductsTable extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            System.out.println("hee");
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(Product.class);

            if (!jsonOBJ.get("title").toString().isEmpty()) {

                c.add(Restrictions.like("title", jsonOBJ.get("title").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("cata").toString().isEmpty() && !jsonOBJ.get("cata").toString().equals("0")) {
                System.out.println(jsonOBJ.get("cata").toString());
                SfCategory cata = (SfCategory) s.load(SfCategory.class, Integer.parseInt(jsonOBJ.get("cata").toString()));

                c.add(Restrictions.eq("sfCategory", cata));
            }
            if (!jsonOBJ.get("status").toString().isEmpty() && !jsonOBJ.get("status").toString().equals("all")) {

                c.add(Restrictions.like("status", jsonOBJ.get("status").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("id").toString().isEmpty()) {

                c.add(Restrictions.eq("idproduct", Integer.parseInt(jsonOBJ.get("id").toString())));
            }

            if (!c.list().isEmpty()) {
                List<Product> list = c.list();

                JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa

                for (Product p : list) {
                    JSONObject o = new JSONObject();//
                    String PimgUrl = "";
                    String PimgUrl2 = "";
                    String PimgUrl3 = "";
                    if (p.getImg1() != null) {
                        PimgUrl = p.getImg1().replace(getServletContext().getRealPath("/"), "");
                        PimgUrl2 = p.getImg2().replace(getServletContext().getRealPath("/"), "");
                        PimgUrl3 = p.getImg3().replace(getServletContext().getRealPath("/"), "");

                    }
                    String UimgUrl = "";
                    if (p.getSeller().getUser().getImgUrl() != null) {
                        UimgUrl = p.getSeller().getUser().getImgUrl().replace(getServletContext().getRealPath("/"), "");

                    }

                    boolean sellLimit = p.getSellLimit().equals("noLimit") ? true : false;

                    o.put("pid", p.getIdproduct());
                    o.put("pimg", PimgUrl);
                    o.put("pimg2", PimgUrl2);
                    o.put("pimg3", PimgUrl3);
                    o.put("uid", p.getSeller().getUser().getIduser());
                    o.put("uimg", UimgUrl);
                    o.put("title", p.getTitle());
                    o.put("cata", p.getSfCategory().getCategoryName()+","+p.getSfCategory().getIdsfCategory());
                    o.put("add_date", p.getAddDate() + "");
                    o.put("sell", sellLimit);
                    o.put("price", p.getPrice());
                    o.put("status", p.getStatus());
                    

                    Criteria c2 = s.createCriteria(ProductHasPlatform.class);
                    c2.add(Restrictions.eq("product", p));

                    JSONArray packages_list = new JSONArray();
                    if (!c2.list().isEmpty()) {

                        List<ProductHasPlatform> php = c2.list();

                        for (ProductHasPlatform ph : php) {
                            System.out.println(ph.getProduct().getIdproduct() + "" + ph.getSfPlatform().getName());

                            packages_list.add(ph.getSfPlatform().getName() + "," + ph.getSfPlatform().getIdsfPlatform());

                        }

                    }

                    Criteria c3 = s.createCriteria(ProductHasSupportOs.class);
                    c3.add(Restrictions.eq("product", p));

                    JSONArray os_list = new JSONArray();
                    if (!c3.list().isEmpty()) {

                        List<ProductHasSupportOs> php = c3.list();

                        for (ProductHasSupportOs ph : php) {
                            System.out.println(ph.getProduct().getIdproduct() + "" + ph.getSupportOs().getName());

                            os_list.add(ph.getSupportOs().getName() + "," + ph.getSupportOs().getIdsupportOs());

                        }

                    }
                    JSONArray allCata_list = new JSONArray();
                    Criteria c4 = s.createCriteria(SfCategory.class);
                    if (!c4.list().isEmpty()) {
                        List<SfCategory> cata_list = c4.list();
                        for (SfCategory j : cata_list) {
                            allCata_list.add(j.getCategoryName() + "," + j.getIdsfCategory());
                        }
                    }

                    JSONArray allPlatform_list = new JSONArray();
                    Criteria c5 = s.createCriteria(SfPlatform.class);
                    if (!c5.list().isEmpty()) {
                        List<SfPlatform> platform_list = c5.list();
                        for (SfPlatform j : platform_list) {
                            allPlatform_list.add(j.getName() + "," + j.getIdsfPlatform());
                        }
                    }

                    JSONArray allOs_list = new JSONArray();
                    Criteria c6 = s.createCriteria(SupportOs.class);
                    if (!c6.list().isEmpty()) {
                        List<SupportOs> all_os_list = c6.list();
                        for (SupportOs j : all_os_list) {
                            allOs_list.add(j.getName() + "," + j.getIdsupportOs());
                        }
                    }

                    JSONArray features_list = new JSONArray();
                    String[] v = p.getFeatures().toString().split(",");
                    for (int i = 0; i < v.length; i++) {
                        System.out.println(v[i]);
                        features_list.add(v[i]);
                    }

                    Criteria c7 = s.createCriteria(Disandaddon.class);
                    c7.add(Restrictions.eq("product", p));

                    double dis = 0;
                    double addon = 0;
                    String lastUDate = "";

                    if (!c7.list().isEmpty()) {
                        Disandaddon disA = (Disandaddon) c7.uniqueResult();
                        lastUDate = disA.getLastUpdateDate() + "";
                        addon = disA.getAddon();
                        dis = disA.getDiscount();
                    }

                    String ve = p.getVideo().replace("https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/");
                    String link = ve.split("&")[0];
                    
                    Criteria c8 = s.createCriteria(PRate.class);
                    c8.add(Restrictions.eq("product", p));

                    double overoll_rate = 0;

                    if (!c8.list().isEmpty()) {
                        double tot_rates = 0;
                        List<PRate> rates = c8.list();

                        for (PRate pRate : rates) {
                            tot_rates += pRate.getRate();
                        }

                        overoll_rate = (tot_rates / rates.size());
                    }

                    System.out.println(Math.round(overoll_rate));

                   String demo =""; 
                     if (p.getDemoZip() != null) {
                        demo = p.getDemoZip().replace(getServletContext().getRealPath("/"), "");

                    }
                   

                    o.put("overoll_rate", Math.round(overoll_rate));
                    o.put("all_cataList", allCata_list);
                    o.put("all_platformList", allPlatform_list);
                    o.put("all_osList", allOs_list);
                    o.put("os", os_list);
                    o.put("platform", packages_list);
                    o.put("langu", p.getSfLanguage());
                    o.put("sf_type", p.getSfType());
                    o.put("small_des", p.getSmallDes());
                    o.put("brief_des", p.getBriefDes());
                    o.put("features", features_list);
                    o.put("return", p.getReturnAccept());
                    o.put("addon", addon);
                    o.put("dis", dis);
                    o.put("last_updateDate", lastUDate);
                    o.put("video", link);
                    o.put("demo", demo);
                    System.out.println(p.getIdproduct());
                    array.add(o);
                }
//            System.out.println(array);
                resp.getWriter().write(array.toJSONString());
            } else {

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
