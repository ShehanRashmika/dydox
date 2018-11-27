package listners;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.hibernate.Session;
import org.hibernate.Transaction;
import pojos.User;

public class sessionL implements HttpSessionListener {
    
    @Override
    public void sessionCreated(HttpSessionEvent hse) {
        
        System.out.println("created");
    }
    
    @Override
    public void sessionDestroyed(HttpSessionEvent hse) {
        System.out.println("distroy");
        Session s = util.NewHibernateUtil.getSessionFactory().openSession();
        
        User u = (User) hse.getSession().getAttribute("user");
       
        User user = (User) s.load(User.class, u.getIduser());
        user.setType("offline");
        s.update(user);
        
        Transaction t = s.beginTransaction();
        t.commit();
        HttpSession s2 = hse.getSession();
        s2.invalidate();
        
       
        
        System.out.println("done");
    }
    
}
