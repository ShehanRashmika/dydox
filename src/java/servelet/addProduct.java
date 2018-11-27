package servelet;

import java.io.File;
import java.io.IOException;
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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Admin;
import pojos.Disandaddon;
import pojos.Product;
import pojos.ProductHasPlatform;
import pojos.ProductHasSupportOs;
import pojos.Seller;
import pojos.SellerHasPackage;
import pojos.SfCategory;
import pojos.SfPlatform;
import pojos.SupportOs;
import pojos.User;

public class addProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            System.out.println("sss");
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();

            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            User user = (User) req.getSession().getAttribute("user");

            if (user != null) {
                //user loged
                System.out.println("user loged");

                Criteria c = s.createCriteria(Seller.class);
                c.add(Restrictions.eq("user", user));

                if (!c.list().isEmpty()) {
                    //user is a seller
                    System.out.println("user is seller");

                    c.add(Restrictions.eq("status", "approved"));

                    if (!c.list().isEmpty()) {
                        //seller is approved
                        System.out.println("user is approved");

                        Seller seller = (Seller) c.uniqueResult();

                        Criteria c2 = s.createCriteria(SellerHasPackage.class);
                        c2.add(Restrictions.eq("seller", seller));
                        c2.add(Restrictions.eq("status", "active"));

                        if (!c2.list().isEmpty()) {
                            //seller has active package
                            System.out.println("seller have active packages");

                            SellerHasPackage shp = (SellerHasPackage) c2.uniqueResult();
                            int remainin_add = shp.getRemainingAddTime();

                            if (remainin_add != 0) {
                                //can add
                                System.out.println("seller can add");

                                Product p = new Product();
                                p.setSfType(o.get("sf_type").toString());
                                p.setSfLanguage(o.get("languages").toString());

                                SfCategory sf_cata = (SfCategory) s.load(SfCategory.class, Integer.parseInt(o.get("soft_cata").toString()));
                                p.setSfCategory(sf_cata);

                                p.setTitle(o.get("title").toString());
                                p.setSmallDes(o.get("small_des").toString());
                                p.setBriefDes(o.get("brief_des").toString());

                                p.setFeatures(o.get("features").toString());

                                p.setVideo(req.getParameter("video"));
                                
                                boolean return_a = o.get("return_a").toString().equals("true") ? true : false;
                                p.setReturnAccept(return_a);

                                p.setAddDate(new Date());
                                p.setPrice(Double.parseDouble(o.get("price").toString()));
                                p.setStatus("pending");
                                p.setSellLimit(o.get("sellType").toString());
                                p.setSeller(seller);
                                Admin admin = (Admin) s.load(Admin.class, Integer.parseInt("1"));
                                p.setAdmin(admin);

                                DiskFileItemFactory df = new DiskFileItemFactory();
                                ServletFileUpload su = new ServletFileUpload(df);

                                List<FileItem> items = su.parseRequest(req);

                                for (FileItem f : items) {
                                    if (!f.isFormField()) {
                                        //file
                                        System.out.println("file found");
                                        System.out.println(f.getName());
                                        System.out.println(f.getFieldName());
                                        String path = getServletContext().getRealPath("/") + "product_folder/";

                                        //images
                                        if (f.getName().toLowerCase().contains(".png")) {

                                            path += "images/" + System.currentTimeMillis() + ".png";

                                        } else if (f.getName().toLowerCase().contains(".jpg")) {
                                            path += "images/" + System.currentTimeMillis() + ".jpg";

                                        } else if (f.getName().toLowerCase().contains(".jpeg")) {
                                            path += "images/" + System.currentTimeMillis() + ".jpeg";

                                        } //doc
                                        else if (f.getName().toLowerCase().contains(".docx")) {
                                            path += "doc/" + System.currentTimeMillis() + ".docx";

                                        } else if (f.getName().toLowerCase().contains(".pdf")) {
                                            path += "doc/" + System.currentTimeMillis() + ".pdf";

                                        } else if (f.getName().toLowerCase().contains(".pptx")) {
                                            path += "doc/" + System.currentTimeMillis() + ".pptx";

                                        } //zip
                                        else if (f.getName().toLowerCase().contains(".rar")) {
                                            path += "zip/" + System.currentTimeMillis() + ".rar";

                                        } else if (f.getName().toLowerCase().contains(".zip")) {
                                            path += "zip/" + System.currentTimeMillis() + ".zip";

                                        }

                                        if (f.getFieldName().equals("image1")) {
                                            p.setImg1(path);
                                        } else if (f.getFieldName().equals("image2")) {
                                            p.setImg2(path);
                                        } else if (f.getFieldName().equals("image3")) {
                                            p.setImg3(path);
                                        } else if (f.getFieldName().equals("demo")) {
                                            p.setDemoZip(path);
                                        } else if (f.getFieldName().equals("original")) {
                                            p.setOrginalZip(path);
                                        } else if (f.getFieldName().equals("srs")) {
                                            p.setSrs(path);
                                        }
                                        File file = new File(path);
                                        f.write(file);

                                    } else {
                                        //text

                                    }
                                    s.save(p);

                                }

                                ArrayList arr_platform = (ArrayList) o.get("sf_platform");
                                for (int i = 0; i < arr_platform.size(); i++) {
                                    //save platform
                                    ProductHasPlatform php = new ProductHasPlatform();
                                    php.setProduct(p);
                                    SfPlatform platform_obj = (SfPlatform) s.load(SfPlatform.class, Integer.parseInt(arr_platform.get(i).toString()));
                                    php.setSfPlatform(platform_obj);
                                    s.save(php);

                                }
                                ArrayList arr_os = (ArrayList) o.get("sf_os");
                                for (int i = 0; i < arr_os.size(); i++) {
                                    //save os
                                    ProductHasSupportOs phs = new ProductHasSupportOs();
                                    phs.setProduct(p);
                                    SupportOs os_obj = (SupportOs) s.load(SupportOs.class, Integer.parseInt(arr_os.get(i).toString()));
                                    phs.setSupportOs(os_obj);
                                    s.save(phs);

                                }

                                shp.setRemainingAddTime(shp.getRemainingAddTime() - 1);
                                s.update(shp);
                                if (shp.getRemainingAddTime() == 0) {
                                    shp.setStatus("inactive");
                                }
                                s.update(shp);

                                
                                Disandaddon  prices = new Disandaddon();
                                prices.setAddon(Double.parseDouble(o.get("addon").toString()));
                                prices.setDiscount(Double.parseDouble(o.get("dis").toString()));
                                prices.setLastUpdateDate(new Date());
                                prices.setProduct(p);
                                
                                s.save(prices);
                                
                                Transaction t = s.beginTransaction();
                                t.commit();

                                resp.getWriter().write("1," + shp.getRemainingAddTime());
                            } else {
                                //can't add
                                System.out.println("seller can't add");
                                resp.getWriter().write("Oops! Your remaining add time is 0.get new package  <a href='member_area.jsp'>here</a>");
                            }

                        } else {
                            //seller has no active packages
                            System.out.println("seller has no active packages");
                            resp.getWriter().write("You haven't active packages! get new package<a href='member_area.jsp' style='color:blue;'><u>click here</u></a>");
                        }

                    } else {
                        //seller is not approved
                        System.out.println("seller is not approved");
                        resp.getWriter().write("You are not approved seller!");
                    }

                } else {
                    //user is not seller
                    System.out.println("user is not a seller");
                    resp.getWriter().write("You are not seller!");
                }

            } else {
                //user not logged
                System.out.println("user not logged");
                resp.getWriter().write("Login first!");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

    }

}
