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
import pojos.Seller;
import pojos.SellerHasPackage;
import pojos.User;

public class loadMemberDataTable extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            System.out.println("ok");
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(Seller.class);

            if (!jsonOBJ.get("name").toString().isEmpty()) {

                Criteria c2 = s.createCriteria(User.class);
                c2.add(Restrictions.like("firstName", jsonOBJ.get("name").toString(),MatchMode.START));

                if (!c2.list().isEmpty()) {
                    List<User> u_list = c2.list();
                    for (User user : u_list) {
                        c.add(Restrictions.like("user", user));

                    }
                }

            }
            if (!jsonOBJ.get("last").toString().isEmpty()) {

                Criteria c2 = s.createCriteria(User.class);
                c2.add(Restrictions.like("lastName", jsonOBJ.get("last").toString(),MatchMode.START));

                if (!c2.list().isEmpty()) {
                    List<User> u_list = c2.list();
                    for (User user : u_list) {
                        c.add(Restrictions.like("user", user));

                    }
                }

            }
            if (!jsonOBJ.get("id").toString().isEmpty()) {
                System.out.println(jsonOBJ.get("id").toString());
                c.add(Restrictions.eq("idseller", Integer.parseInt(jsonOBJ.get("id").toString())));
            }
            if (!jsonOBJ.get("status").toString().isEmpty() && !jsonOBJ.get("status").toString().equals("all")) {

                c.add(Restrictions.like("status", jsonOBJ.get("status").toString(), MatchMode.START));//like query eka
            }
            List<Seller> seller_list = c.list();

            JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
            for (Seller sellers : seller_list) {
                String imgUrl = "";
                JSONObject o = new JSONObject();//
                if (sellers.getUser().getImgUrl() != null) {
                    imgUrl = sellers.getUser().getImgUrl().replace(getServletContext().getRealPath("/"), "");

                }

                Criteria c1 = s.createCriteria(SellerHasPackage.class);
                c1.add(Restrictions.eq("seller", sellers));
                c1.add(Restrictions.eq("status", "active"));

                String packagee = "";
                int remining = 0;
                if (!c1.list().isEmpty()) {

                    SellerHasPackage shp = (SellerHasPackage) c1.uniqueResult();
                    packagee = shp.getSellerPackage().getName();
                    remining = shp.getRemainingAddTime();

                }
                o.put("sid", sellers.getIdseller());
                o.put("uid", sellers.getUser().getIduser());
                o.put("img", imgUrl);
                o.put("fname", sellers.getUser().getFirstName());
                o.put("lname", sellers.getUser().getLastName());
                o.put("mobile", sellers.getUser().getMobile());
                o.put("email", sellers.getUser().getEmail());
                o.put("package", packagee);
                o.put("remaining", remining);
                o.put("status", sellers.getStatus());
                array.add(o);

            }
            resp.getWriter().write(array.toJSONString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
