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
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.InvoicePackage;
import pojos.User;

public class loadPackageInvoiceTable extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            System.out.println("ok");
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(InvoicePackage.class);

            if (!jsonOBJ.get("name").toString().isEmpty()) {

                Criteria c3 = s.createCriteria(User.class);
                c3.add(Restrictions.like("firstName", jsonOBJ.get("name").toString(), MatchMode.START));
                if (!c3.list().isEmpty()) {
                    List<User> u = c3.list();
                    for (User user : u) {
                        c.add(Restrictions.eq("user", user));//like query eka

                    }
                }
            }

            if (!jsonOBJ.get("uid").toString().isEmpty()) {

                Criteria c3 = s.createCriteria(User.class);
                c3.add(Restrictions.eq("iduser", Integer.parseInt(jsonOBJ.get("uid").toString())));
                if (!c3.list().isEmpty()) {

                    c.add(Restrictions.eq("user", (User) c3.uniqueResult()));//like query eka

                }
            }

            if (!jsonOBJ.get("status").toString().isEmpty() && !jsonOBJ.get("status").toString().equals("all")) {

                c.add(Restrictions.like("status", jsonOBJ.get("status").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("date").toString().isEmpty()) {

                Date d = new SimpleDateFormat("yyy-MM-dd").parse(jsonOBJ.get("date").toString());
                c.add(Restrictions.eq("date", d));
            }
            List<InvoicePackage> inv_list = c.list();

            JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
            for (InvoicePackage inv : inv_list) {
                JSONObject o = new JSONObject();//
                
                o.put("inv_id", inv.getIdinvoicePackage());
                o.put("date", inv.getDate()+"");
                o.put("uid", inv.getUser().getIduser());
                o.put("u_name", inv.getUser().getFirstName()+" "+inv.getUser().getLastName());
                o.put("inv_status", inv.getStatus());
                array.add(o);

            }
            resp.getWriter().write(array.toJSONString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
