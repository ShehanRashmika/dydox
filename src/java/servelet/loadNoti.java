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
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import pojos.Notifications;
import pojos.User;

public class loadNoti extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        try {
            
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            User u = (User) req.getSession().getAttribute("user");
            if (u != null) {
                
                Criteria c2 = s.createCriteria(Notifications.class);
                c2.add(Restrictions.eq("user", u));
                c2.add(Restrictions.eq("status", "notRead"));
                int count = 0;
                
                JSONArray arr = new JSONArray();
                if (!c2.list().isEmpty()) {
                    List<Notifications> list = c2.list();
                    count = list.size();
                    for (Notifications n : list) {
                        
                        JSONObject o = new JSONObject();
                        o.put("nid", n.getIdnotifications());
//                        o.put("size", count);
                        o.put("header", n.getType());
                        o.put("msg", n.getMessage());
                        
                        arr.add(o);
                        
                    }
                    System.out.println(arr);
                    
                    resp.getWriter().write(arr.toJSONString() + "~-&-~" + count);
                } else {
                 
                    resp.getWriter().write(arr.toJSONString() + "~-&-~" + '0');
                    
                }
            } else {
                resp.getWriter().write("0");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
