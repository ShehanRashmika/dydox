package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import netscape.javascript.JSObject;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import pojos.SellerHasPackage;
import pojos.SellerPackage;

public class loadPackgeDetails extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            int id = Integer.parseInt(req.getParameter("select"));
            System.out.println(id);
            Session s =  util.NewHibernateUtil.getSessionFactory().openSession();
           
            SellerPackage shp = (SellerPackage) s.load(SellerPackage.class, id);
            
            JSONObject o =  new JSONObject();
            o.put("name", shp.getName());
            o.put("max", shp.getMaxAddTime());
            o.put("valid", shp.getValidMonths());
            o.put("profit", shp.getProfitPercentage());
            o.put("price", shp.getPrice());
            
            System.out.println(shp.getName());
            resp.getWriter().write(o.toJSONString());
        } catch (Exception e) {

            e.printStackTrace();
        }
    }

}
