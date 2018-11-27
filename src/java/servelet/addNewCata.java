package servelet;

import java.io.IOException;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.SfCategory;

public class addNewCata extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            JSONObject obj = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();

            String name = obj.get("name").toString().toLowerCase();

            if (name != null && !name.equals(" ") && checkAlphabetic(name.replace(" ", ""))) {

                Criteria c = s.createCriteria(SfCategory.class);

                c.add(Restrictions.eq("categoryName", name));

                if (!c.list().isEmpty()) {
                    //found same items

                    resp.getWriter().write("2");

                } else {
                    //no same items

                    SfCategory sf = new SfCategory();
                    sf.setCategoryName(name);

                    s.save(sf);

                    Transaction t = s.beginTransaction();
                    t.commit();

                    resp.getWriter().write("1");
                }

            } else {

                resp.getWriter().write("0");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    public static boolean checkAlphabetic(String input) {
        if (Pattern.matches("[a-zA-Z]+", input.trim())) {
           
                System.out.println("Yep!");
           
                return true;

        } else {
            System.out.println("Nope!");
            return false;
        }

    }
}
