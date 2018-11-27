package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.ReqProject;
import pojos.SfCategory;
import pojos.User;

public class postReqProject extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {

                if (!o.get("title").toString().isEmpty() && !o.get("cata").toString().equals("0") && !o.get("des").toString().isEmpty()) {

                    Session s = util.NewHibernateUtil.getSessionFactory().openSession();

                    ReqProject r = new ReqProject();
                    r.setDate(new Date());
                    r.setDes(o.get("des").toString());
                    SfCategory cata = (SfCategory) s.load(SfCategory.class, Integer.parseInt(o.get("cata").toString()));

                    r.setSfCategory(cata);

                    ArrayList arr = (ArrayList) o.get("platform");

                    if (!arr.isEmpty()) {
                        String platform="";
                        for (int i = 0; i < arr.size(); i++) {
                                
                            platform += arr.get(i).toString()+" ";
                            
                        }
                            r.setSfPlatform(platform);

                    }
                    if (!o.get("wp").toString().isEmpty()) {
                        r.setWishPrice(Double.parseDouble(o.get("wp").toString()));

                    }
                    r.setTitle(o.get("title").toString());
                    r.setUser(user);

                    s.save(r);

                    Transaction t = s.beginTransaction();
                    t.commit();

                    resp.getWriter().write("2");
                } else {
                    resp.getWriter().write("0");
                }
            } else {

                resp.getWriter().write("1");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
