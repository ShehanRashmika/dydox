package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import pojos.Comments;
import pojos.PRate;
import pojos.Product;

public class loadComments extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(Comments.class);
            Product p = (Product) s.load(Product.class, Integer.parseInt(req.getParameter("pid").toString()));
            c.add(Restrictions.eq("product", p));

           c.addOrder(Order.desc("date"));
           c.addOrder(Order.desc("time"));

            if (!c.list().isEmpty()) {

                List<Comments> list = c.list();
                JSONArray arr = new JSONArray();
                for (Comments com : list) {
                    String user_img = "";
                    if (com.getUser().getImgUrl() != null) {

                        user_img = com.getUser().getImgUrl().replace(getServletContext().getRealPath("/"), "");
                    } else {
                        user_img = "images/blank.png";
                    }
                    
                    String comment = com.getComment().split("-~&&~-")[0];
                    String owner = com.getComment().split("-~&&~-")[1];
                    
                    JSONObject o = new JSONObject();
                    o.put("user_image", user_img);
                    o.put("comment",comment);
                    o.put("owner",owner);
                    o.put("date", com.getDate() + "");
                    o.put("time", com.getTime() + "");
                    o.put("user_name", com.getUser().getFirstName());
                    
                    arr.add(o);
                    
                    System.out.println(user_img);
                    System.out.println(comment);
                    System.out.println(owner);

                }
             
                resp.getWriter().write(arr.toJSONString());
            } else {
                //no comments

                resp.getWriter().write("2");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
