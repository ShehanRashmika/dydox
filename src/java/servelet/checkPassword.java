package servelet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.User;

public class checkPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            
            Session s =  util.NewHibernateUtil.getSessionFactory().openSession();
            
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            System.out.println(o.get("cp").toString());
            if (!o.get("cp").toString().isEmpty()) {
                
                Criteria c = s.createCriteria(User.class);
                c.add(Restrictions.eq("password", o.get("cp").toString()));
                
                if (c.list().isEmpty()) {
                    
                    resp.getWriter().write("1");
                }else{
                
                    resp.getWriter().write("2");
                }
                
            } else {
                resp.getWriter().write("0");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
