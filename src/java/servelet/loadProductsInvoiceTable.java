package servelet;

import classes.sellerPayments;
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
import pojos.SellerHasPackage;
import pojos.User;

public class loadProductsInvoiceTable extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            System.out.println("ok");
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(InvoiceProduct.class);

//            if (!jsonOBJ.get("name").toString().isEmpty()) {
//
//             
//            }
//
            if (!jsonOBJ.get("inv_id").toString().isEmpty()) {
                c.add(Restrictions.eq("idinvoiceProduct", Integer.parseInt(jsonOBJ.get("inv_id").toString())));
            }
            if (!jsonOBJ.get("status").toString().isEmpty() && !jsonOBJ.get("status").toString().equals("all")) {

                c.add(Restrictions.like("status", jsonOBJ.get("status").toString(), MatchMode.START));//like query eka
            }
            if (!jsonOBJ.get("date").toString().isEmpty() && !jsonOBJ.get("date2").toString().isEmpty()) {

                Date d = new SimpleDateFormat("yyy-MM-dd").parse(jsonOBJ.get("date").toString());
                Date d2 = new SimpleDateFormat("yyy-MM-dd").parse(jsonOBJ.get("date2").toString());
                c.add(Restrictions.between("date", d, d2));
            }
            List<InvoiceProduct> inv_list = c.list();

            JSONArray array = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
            for (InvoiceProduct inv : inv_list) {
                JSONObject o = new JSONObject();//

                o.put("inv_id", inv.getIdinvoiceProduct());
                o.put("date", inv.getDate() + "");
                o.put("time", inv.getTime() + "");
                o.put("sub", inv.getSubTot());
                o.put("addon", inv.getAddonTot());
                o.put("dis", inv.getDisTot());
                o.put("total", inv.getTotal());
                o.put("inv_status", inv.getStatus());

                Criteria c2 = s.createCriteria(InvoiceProductHasItem.class);
                c2.add(Restrictions.eq("invoiceProduct", inv));
                JSONArray array_productList = new JSONArray();//okkoma data gnda ona nis aarray ekk hadanwa
                if (!c2.list().isEmpty()) {

                    List<InvoiceProductHasItem> items = c2.list();
                    for (InvoiceProductHasItem i : items) {
                        JSONObject o2 = new JSONObject();//
                        o2.put("pid", i.getProduct().getIdproduct());
                        o2.put("title", i.getProduct().getTitle());
                        o2.put("sid", i.getProduct().getSeller().getIdseller());
                        o2.put("s_name", i.getProduct().getSeller().getUser().getFirstName() + " " + i.getProduct().getSeller().getUser().getLastName());
                        o2.put("emails", i.getProduct().getSeller().getUser().getEmail());

                        array_productList.add(o2);
                    }

                }
                o.put("product_list", array_productList);
                array.add(o);

            }
            resp.getWriter().write(array.toJSONString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
