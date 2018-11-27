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
import pojos.User;

public class loadUserDataTable extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            System.out.println("hee");
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(User.class);

            if (!jsonOBJ.get("name").toString().isEmpty()) {

                c.add(Restrictions.like("firstName", jsonOBJ.get("name").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("last").toString().isEmpty()) {

                c.add(Restrictions.like("lastName", jsonOBJ.get("last").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("status").toString().isEmpty() && !jsonOBJ.get("status").toString().equals("all")) {

                c.add(Restrictions.like("status", jsonOBJ.get("status").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("id").toString().isEmpty()) {

                c.add(Restrictions.eq("iduser", Integer.parseInt(jsonOBJ.get("id").toString())));
            }

            if (!c.list().isEmpty()) {
                List<User> list = c.list();

                JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa

                for (User user : list) {
                    JSONObject o = new JSONObject();//
                    String imgUrl = "";
                    if (user.getImgUrl() != null) {
                        imgUrl = user.getImgUrl().replace(getServletContext().getRealPath("/"), "");

                    }
                    o.put("id", user.getIduser());
                    o.put("img", imgUrl);
                    o.put("fname", user.getFirstName());
                    o.put("lname", user.getLastName());
                    o.put("street", user.getStreet());
                    o.put("zip", user.getZip());
                    o.put("city", user.getCity());
                    o.put("country", user.getCountry());
                    o.put("mobile", user.getMobile());
                    o.put("email", user.getEmail());
                    o.put("status", user.getStatus());
//                    System.out.println(user.getIduser());
//                    System.out.println(imgUrl);
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
