package servelet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import pojos.User;

public class checkEmail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(User.class);

            c.add(Restrictions.eq("emailVerifyCode", req.getParameter("code")));
            
            
            if (!c.list().isEmpty()) {
                //found user
                System.out.println("found user");
                User user = (User) c.uniqueResult();
                User update_u = (User) s.load(User.class, user.getIduser());

                    System.out.println("updated");
                    
                    update_u.setStatus("confirmed");
                    s.update(update_u);

                    resp.sendRedirect("index.jsp?email=success");

                    Transaction t = s.beginTransaction();
                    t.commit();

              
            } else {
                //not found user
                System.out.println("no user");
                resp.sendRedirect("index.jsp?email=Unsuccess");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
