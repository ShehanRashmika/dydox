package servelet;

import classes.Mailer;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.User;
import reports.bean_packageInvoice;
import reports.bean_productINVUser;

public class productInvoiceDwonload extends HttpServlet {

   

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            System.out.println("pINV");
            User u = (User) req.getSession().getAttribute("user");

            String json_str = req.getParameter("json_str");
            System.out.println(json_str);
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(json_str);

            JSONArray arr_1 = (JSONArray) jsonOBJ.get("des");
            JSONArray arr_2 = (JSONArray) jsonOBJ.get("addon");
            JSONArray arr_3 = (JSONArray) jsonOBJ.get("dis");
            JSONArray arr_4 = (JSONArray) jsonOBJ.get("tot");

            String x = jsonOBJ.get("x").toString();

            InputStream i = getClass().getResourceAsStream("/reports/product_invoiceUser.jrxml");//viewJasperReport.class
            JasperReport compileReport = JasperCompileManager.compileReport(i);

            Map<String, Object> m = new HashMap<>();
            m.put("inv_id", jsonOBJ.get("inv_id"));
            m.put("inv_date", jsonOBJ.get("inv_date"));
            m.put("user_name", u.getFirstName() + " " + u.getLastName());
            m.put("user_email", u.getEmail());
            m.put("inv_subTot", jsonOBJ.get("inv_subTot"));
            m.put("inv_addonTot", jsonOBJ.get("inv_addonTot"));
            m.put("inv_disTot", jsonOBJ.get("inv_disTot"));
            m.put("inv_tot", jsonOBJ.get("inv_tot"));

            ArrayList<bean_productINVUser> a = new ArrayList<>();

            for (int j = 0; j < arr_1.size(); j++) {

                bean_productINVUser b = new bean_productINVUser();//bean class object
                b.setDESCRIPTION(arr_1.get(j).toString());
                b.setADDTIONAL(arr_2.get(j).toString());
                b.setDISCOUNT(arr_3.get(j).toString());
                b.setSUB_TOTAL(arr_4.get(j).toString());

                a.add(b);
            }

            JRBeanCollectionDataSource bean_coll = new JRBeanCollectionDataSource(a);

            byte[] pdf_data = JasperRunManager.runReportToPdf(compileReport, m, bean_coll);

            if (jsonOBJ.get("status").toString().equals("download")) {

                ServletOutputStream out = resp.getOutputStream();
                out.write(pdf_data);
                if (!x.isEmpty()) {
                    System.out.println("sss");
                    resp.setContentType("application/pdf");
                    resp.setHeader("Content-Disposition", "attachment;filename=invoice.pdf");
                } else {

                    resp.setContentType("application/pdf");
                    resp.setHeader("Content-Disposition", "inline");
                }
                out.flush();
                out.close();
            } else if (jsonOBJ.get("status").toString().equals("load")) {

                String project_path = req.getSession().getServletContext().getRealPath("/");
                String save_path = "reports/productInvoice/" + new SimpleDateFormat("yyy-MM-dd").format(new Date()) + " " + System.currentTimeMillis() + ".pdf";
                String full_path = project_path + save_path;

                File f = new File(full_path);//System.currenttime
                FileOutputStream fo = new FileOutputStream(f);
                fo.write(pdf_data);
                fo.flush();
                fo.close();

               

                Mailer mail = new Mailer();
                boolean send = mail.send(u.getEmail(), "Invoice", full_path, true);
                if (send) {
                    System.out.println("mail sent!");
                    resp.getWriter().write("1");
                }else{
                    resp.getWriter().write("0");
                
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace();

        }

    }

}
