package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.SellerPackage;

public class addNewPackage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            if (!o.get("status").toString().isEmpty() && !o.get("name").toString().isEmpty() && !o.get("max").toString().isEmpty() && !o.get("valid").toString().isEmpty() && !o.get("profit").toString().isEmpty() && !o.get("price").toString().isEmpty()) {
                Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                if (o.get("status").toString().equals("add")) {

                    SellerPackage sh = new SellerPackage();

                    sh.setName(o.get("name").toString());
                    sh.setMaxAddTime(Integer.parseInt(o.get("max").toString()));
                    sh.setValidMonths(Integer.parseInt(o.get("valid").toString()));
                    sh.setProfitPercentage(Integer.parseInt(o.get("profit").toString()));
                    sh.setPrice(Double.parseDouble(o.get("price").toString()));

                    s.save(sh);

                    Transaction t = s.beginTransaction();
                    t.commit();
                    resp.getWriter().write("1");
                } else if (o.get("status").toString().equals("update")) {

                    int id = Integer.parseInt(req.getParameter("id"));
                    SellerPackage sp = (SellerPackage) s.load(SellerPackage.class, id);
                    sp.setName(o.get("name").toString());
                    sp.setMaxAddTime(Integer.parseInt(o.get("max").toString()));
                    sp.setValidMonths(Integer.parseInt(o.get("valid").toString()));
                    sp.setProfitPercentage(Integer.parseInt(o.get("profit").toString()));
                    sp.setPrice(Double.parseDouble(o.get("price").toString()));

                    s.update(sp);
                    Transaction t = s.beginTransaction();
                    t.commit();
                    resp.getWriter().write("2");
                }

            } else {
                resp.getWriter().write("0");
            }
        } catch (Exception e) {
        }
    }

}
