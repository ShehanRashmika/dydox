package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Comments;
import pojos.Notifications;
import pojos.Product;
import pojos.User;

public class addComment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            User user = (User) req.getSession().getAttribute("user");//user

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            if (o.get("comment").equals("") || o.get("comment") == null) {
                resp.getWriter().write("2");
            } else {

                if (user != null) {
                    //user loged
                    User u = (User) s.load(User.class, Integer.parseInt(o.get("uid").toString()));//seller

                    Product p = (Product) s.load(Product.class, Integer.parseInt(o.get("pid").toString()));

                    Comments com = new Comments();
                    com.setDate(new Date());
                    com.setTime(new Date());
                    com.setProduct(p);
                    com.setUser(user);

                    if (user.getIduser().equals(u.getIduser())) {
                        //seller and user same
                        System.out.println("owner");

                        com.setComment(o.get("comment").toString() + "-~&&~-" + "Owner");
                    } else {
                        System.out.println("normal");

                        com.setComment(o.get("comment").toString() + "-~&&~-" + "Normal");

                    }

                    s.save(com);
                    //notification

                    if (!user.getIduser().equals(u.getIduser())) {
                        Notifications n = new Notifications();
                        n.setType("Comments");

                        n.setMessage("<a href='view_more.jsp?pid=" + o.get("pid") + "'>" + user.getFirstName() + " comment on your product!</a>");
                        n.setUser(u);
                        n.setStatus("notRead");

                        s.save(n);
                    }

                    Transaction t = s.beginTransaction();
                    t.commit();

                    resp.getWriter().write("1");

                } else {
                    //user not loged
                    resp.getWriter().write("0");
                }
            }

        } catch (Exception e) {
            resp.getWriter().write("3");
            e.printStackTrace();
        }
    }

}
