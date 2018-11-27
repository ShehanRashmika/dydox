
package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Notifications;
import pojos.User;

public class sendNoti extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            if (!o.get("sub").toString().isEmpty() && !o.get("noti").toString().isEmpty()) {
                
                ArrayList arr = (ArrayList) o.get("uid");
                
                if (!arr.isEmpty()) {
                    
                    Session s = util.NewHibernateUtil.getSessionFactory().openSession();
                    
                    for (int i = 0; i < arr.size(); i++) {
                        
                        User u = (User) s.load(User.class, Integer.parseInt(arr.get(i).toString()));
                        
                        Notifications n = new Notifications();
                        n.setType(o.get("sub").toString());
                        n.setMessage(o.get("noti").toString());
                        n.setUser(u);
                        n.setStatus("notRead");
                        
                        s.save(n);
                        
                    }
                    Transaction t =  s.beginTransaction();
                    t.commit();
                    
                    
                    
                    resp.getWriter().write("2");
                } else {
                    resp.getWriter().write("1");
                }
                
            } else {
                resp.getWriter().write("0");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
