
package servelet;

import java.io.IOException;
import java.io.PrintWriter;
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
import pojos.InvoicePackage;
import pojos.SellerHasPackage;
import pojos.User;

public class loadSellerHasPackageTable extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
            System.out.println("hee");
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(SellerHasPackage.class);

//            if (!jsonOBJ.get("name").toString().isEmpty()) {
//
//                c.add(Restrictions.like("firstName", jsonOBJ.get("name").toString(), MatchMode.START));//like query eka
//            }
//            if (!jsonOBJ.get("last").toString().isEmpty()) {
//
//                c.add(Restrictions.like("lastName", jsonOBJ.get("last").toString(), MatchMode.START));//like query eka
//            }
            if (!jsonOBJ.get("status").toString().isEmpty() && !jsonOBJ.get("status").toString().equals("all")) {

                c.add(Restrictions.like("status", jsonOBJ.get("status").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("id").toString().isEmpty()) {

                c.add(Restrictions.eq("iduser", Integer.parseInt(jsonOBJ.get("id").toString())));
            }

            if (!c.list().isEmpty()) {
                List<SellerHasPackage> list = c.list();

                JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa

                for (SellerHasPackage shp : list) {
                    JSONObject o = new JSONObject();//
                    String imgUrl = "";
                    if (shp.getSeller().getUser().getImgUrl() != null) {
                        imgUrl = shp.getSeller().getUser().getImgUrl().replace(getServletContext().getRealPath("/"), "");

                    }
                    o.put("sid", shp.getSeller().getIdseller());
                    o.put("img", imgUrl);
                    o.put("package", shp.getSellerPackage().getName());
                    o.put("rem", shp.getRemainingAddTime());
                    
                    Criteria c2 = s.createCriteria(InvoicePackage.class);
                    c2.add(Restrictions.eq("sellerHasPackage", shp));
                    String date = "";
                    String inv_status = "";
                    if (!c2.list().isEmpty()) {
                        InvoicePackage inv = (InvoicePackage)c2.uniqueResult();
                        date  = inv.getDate()+"";
                        inv_status  = inv.getStatus();
                    }
                    o.put("inv_date",date);
                    o.put("inv_status",inv_status);
                    o.put("status", shp.getStatus());
                
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
