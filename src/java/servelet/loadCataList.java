package servelet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import pojos.SfCategory;

public class loadCataList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(SfCategory.class);
            List<SfCategory> list = c.list();

            JSONArray arr = new JSONArray();
            for (SfCategory sf : list) {

                JSONObject o = new JSONObject();
                o.put("id",sf.getIdsfCategory());
                o.put("name", sf.getCategoryName());
                arr.add(o);
            }

            resp.getWriter().write(arr.toJSONString());

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
