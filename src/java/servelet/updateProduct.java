package servelet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Disandaddon;
import pojos.Notifications;
import pojos.Product;
import pojos.ProductHasPlatform;
import pojos.ProductHasSupportOs;
import pojos.SfCategory;
import pojos.SfPlatform;
import pojos.SupportOs;

public class updateProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            System.out.println("in the update");

            if (!o.get("pid").toString().isEmpty() && !o.get("title").toString().isEmpty()
                    && !o.get("langu").toString().isEmpty() && !o.get("cata").toString().isEmpty() && !o.get("small_des").toString().isEmpty()
                    && !o.get("sf_type").toString().isEmpty() && !o.get("brief_des").toString().isEmpty() && !o.get("features").toString().isEmpty()
                    && !o.get("addon").toString().isEmpty() && !o.get("dis").toString().isEmpty() && !o.get("price").toString().isEmpty() && !o.get("videoURL").toString().isEmpty()) {

                Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                Product p = (Product) s.load(Product.class, Integer.parseInt(o.get("pid").toString()));

                p.setTitle(o.get("title").toString());
                p.setSfType(o.get("sf_type").toString());
                p.setSfLanguage(o.get("langu").toString());
                p.setSmallDes(o.get("small_des").toString());
                p.setBriefDes(o.get("brief_des").toString());
                p.setFeatures(o.get("features").toString());
                p.setPrice(Double.parseDouble(o.get("price").toString()));
                boolean return_a = o.get("return_a").toString().equals("true") ? true : false;
                p.setReturnAccept(return_a);
                p.setSellLimit(o.get("sell_time").toString());
                p.setVideo(o.get("videoURL").toString());

                SfCategory cata = (SfCategory) s.load(SfCategory.class, Integer.parseInt(o.get("cata").toString()));
                p.setSfCategory(cata);

                DiskFileItemFactory df = new DiskFileItemFactory();
                ServletFileUpload su = new ServletFileUpload(df);

                List<FileItem> items = su.parseRequest(req);

                for (FileItem f : items) {
                    if (!f.isFormField()) {
                        //file found
                        System.out.println("file found");
                        String path = getServletContext().getRealPath("/") + "product_folder/";
                        if (f.getFieldName().equals("demo")) {
                            path += "zip/" + System.currentTimeMillis() + ".rar";
                            p.setDemoZip(path);
                        } else if (f.getFieldName().equals("original")) {
                            path += "zip/" + System.currentTimeMillis() + ".rar";
                            p.setOrginalZip(path);
                        } else if (f.getFieldName().equals("srs")) {
                            String ext = "docx";
                            if (f.getName().split("\\.")[1].equals("pdf")) {
                                ext = "pdf";
                            } else {
                                ext = "docx";
                            }
                            path += "doc/" + System.currentTimeMillis() + "." + ext;
                            p.setSrs(path);
                        } else if (f.getFieldName().equals("img1")) {
                            path += "images/" + System.currentTimeMillis() + ".png";
                            p.setImg1(path);
                        } else if (f.getFieldName().equals("img2")) {
                            path += "images/" + System.currentTimeMillis() + ".png";
                            p.setImg2(path);
                        } else if (f.getFieldName().equals("img3")) {
                            path += "images/" + System.currentTimeMillis() + ".png";
                            p.setImg3(path);
                        }
                        File file = new File(path);
                        f.write(file);

                        System.out.println(path);

                    }
                }

                s.update(p);

                Criteria c = s.createCriteria(Disandaddon.class);
                c.add(Restrictions.eq("product", p));

                if (!c.list().isEmpty()) {

                    Disandaddon d = (Disandaddon) c.uniqueResult();
                    Disandaddon du = (Disandaddon) s.load(Disandaddon.class, d.getIddisAndAddon());

                    du.setAddon(Double.parseDouble(o.get("addon").toString()));
                    du.setDiscount(Double.parseDouble(o.get("dis").toString()));
                    du.setLastUpdateDate(new Date());
                    s.update(du);
                }

                Criteria c2 = s.createCriteria(ProductHasPlatform.class);
                c2.add(Restrictions.eq("product", p));

                if (!c2.list().isEmpty()) {

                    List<ProductHasPlatform> p_list = c2.list();
                    for (ProductHasPlatform php : p_list) {

                        ProductHasPlatform x = (ProductHasPlatform) s.load(ProductHasPlatform.class, php.getIdproductHasPlatform());
                        s.delete(x);

                    }
                }

                ArrayList arr_platform = (ArrayList) o.get("platform");
                for (int i = 0; i < arr_platform.size(); i++) {
                    //save platform

                    ProductHasPlatform php = new ProductHasPlatform();
                    php.setProduct(p);
                    SfPlatform platform_obj = (SfPlatform) s.load(SfPlatform.class, Integer.parseInt(arr_platform.get(i).toString()));
                    php.setSfPlatform(platform_obj);
                    s.save(php);

                }

                Criteria c3 = s.createCriteria(ProductHasSupportOs.class);
                c3.add(Restrictions.eq("product", p));

                if (!c3.list().isEmpty()) {

                    List<ProductHasSupportOs> p_list = c3.list();
                    for (ProductHasSupportOs php : p_list) {

                        ProductHasSupportOs x = (ProductHasSupportOs) s.load(ProductHasSupportOs.class, php.getIdproductHasSupportOs());
                        s.delete(x);

                    }
                }

                ArrayList arr_os = (ArrayList) o.get("os");
                for (int i = 0; i < arr_os.size(); i++) {
                    //save os
                    ProductHasSupportOs phs = new ProductHasSupportOs();
                    phs.setProduct(p);
                    SupportOs os_obj = (SupportOs) s.load(SupportOs.class, Integer.parseInt(arr_os.get(i).toString()));
                    phs.setSupportOs(os_obj);
                    s.save(phs);

                }

                Notifications n = new Notifications();
                n.setType("Product");
                n.setMessage(p.getTitle() + " Updated by Admin");
                n.setUser(p.getSeller().getUser());
                n.setStatus("notRead");
                s.save(n);

                Transaction t = s.beginTransaction();
                t.commit();
                resp.getWriter().write("1");

            } else {
                resp.getWriter().write("0");
                System.out.println("nulllllll");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
