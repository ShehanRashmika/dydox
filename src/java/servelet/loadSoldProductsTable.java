package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.InvoiceProduct;
import pojos.InvoiceProductHasItem;
import pojos.User;

public class loadSoldProductsTable extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            System.out.println("hee2");
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(InvoiceProduct.class);
            
            

            if (!jsonOBJ.get("name").toString().isEmpty()) {

                Criteria c3 = s.createCriteria(User.class);
                c3.add(Restrictions.like("firstName", jsonOBJ.get("name").toString(), MatchMode.START));
                if (!c3.list().isEmpty()) {
                    List<User> u = c3.list();
                    for (User user : u) {
                        c.add(Restrictions.eq("user", user));//like query eka

                    }
                }
            }
            
            if (!jsonOBJ.get("uid").toString().isEmpty()) {

                Criteria c3 = s.createCriteria(User.class);
                c3.add(Restrictions.eq("iduser", Integer.parseInt(jsonOBJ.get("uid").toString())));
                if (!c3.list().isEmpty()) {
                 
                 
                        c.add(Restrictions.eq("user", (User)c3.uniqueResult()));//like query eka

                    
                }
            }
            
            if (!jsonOBJ.get("status").toString().isEmpty() && !jsonOBJ.get("status").toString().equals("all")) {

                c.add(Restrictions.like("status", jsonOBJ.get("status").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("date").toString().isEmpty()) {

                Date d =new SimpleDateFormat("yyy-MM-dd").parse(jsonOBJ.get("date").toString());
                c.add(Restrictions.eq("date", d));
            }
            if (!c.list().isEmpty()) {
                List<InvoiceProduct> list = c.list();

                JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
                for (InvoiceProduct i : list) {

                    Criteria c2 = s.createCriteria(InvoiceProductHasItem.class);
                    c2.add(Restrictions.eq("invoiceProduct", i));
                    if (!c2.list().isEmpty()) {

                        List<InvoiceProductHasItem> iphi = c2.list();
                        for (InvoiceProductHasItem ipi : iphi) {

                            JSONObject o = new JSONObject();
                            String imgUrl = "";
                            if (ipi.getProduct().getImg1() != null) {
                                imgUrl = ipi.getProduct().getImg1().replace(getServletContext().getRealPath("/"), "");

                            }

                            o.put("pid", ipi.getProduct().getIdproduct());
                            o.put("pimg", imgUrl);
                            o.put("title", ipi.getProduct().getTitle());
                            o.put("inv", i.getIdinvoiceProduct());
                            o.put("sold_date", i.getDate() + "");
                            o.put("sid", ipi.getProduct().getSeller().getIdseller());
                            o.put("s_name", ipi.getProduct().getSeller().getUser().getFirstName() + " " + ipi.getProduct().getSeller().getUser().getLastName());
                            o.put("uid", ipi.getInvoiceProduct().getUser().getIduser());
                            o.put("u_name", ipi.getInvoiceProduct().getUser().getFirstName() + " " + ipi.getInvoiceProduct().getUser().getLastName());
                            o.put("u_email", ipi.getInvoiceProduct().getUser().getEmail());
                            o.put("inv_status", i.getStatus());
                            System.out.println(i.getIdinvoiceProduct());

                            array.add(o);
                        }

                    } else {

                    }
                }
                resp.getWriter().write(array.toJSONString());

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
