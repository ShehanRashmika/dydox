package servelet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import reports.bean_productInvoice;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import reports.bean_packageInvoice;

public class jasper_packageInvoice extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            System.out.println("okkkkfsfs");
            String json_str = req.getParameter("json_str");
            System.out.println(json_str);
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(json_str);

            JSONArray arr_1 = (JSONArray) jsonOBJ.get("inv_id");
            JSONArray arr_2 = (JSONArray) jsonOBJ.get("date");
            JSONArray arr_3 = (JSONArray) jsonOBJ.get("uid");
            JSONArray arr_4 = (JSONArray) jsonOBJ.get("user");
            JSONArray arr_5 = (JSONArray) jsonOBJ.get("status");
       
            InputStream i = getClass().getResourceAsStream("/reports/package_Invoice.jrxml");//viewJasperReport.class
            JasperReport compileReport = JasperCompileManager.compileReport(i);

            Map<String, Object> m = new HashMap<>();

            ArrayList<bean_packageInvoice> a = new ArrayList<>();

            for (int j = 0; j < arr_1.size(); j++) {

                bean_packageInvoice b = new bean_packageInvoice();//bean class object
                b.setINV_ID(arr_1.get(j).toString());
                b.setDATE(arr_2.get(j).toString());
                b.setUID(arr_3.get(j).toString());
                b.setUSER(arr_4.get(j).toString());
                b.setSTATUS(arr_5.get(j).toString());

                a.add(b);
            }

            JRBeanCollectionDataSource bean_coll = new JRBeanCollectionDataSource(a);

            byte[] pdf_data = JasperRunManager.runReportToPdf(compileReport, m, bean_coll);

            String project_path = req.getSession().getServletContext().getRealPath("/");
            String save_path = "reports/packageInvoice/" +new SimpleDateFormat("yyy-MM-dd").format(new Date())+" "+ System.currentTimeMillis() + ".pdf";
            String full_path = project_path + save_path;

            File f = new File(full_path);//System.currenttime
            FileOutputStream fo = new FileOutputStream(f);
            fo.write(pdf_data);
            fo.flush();
            fo.close();

            resp.getWriter().write(save_path);
        } catch (Exception ex) {
            ex.printStackTrace();

        }

    }

}
