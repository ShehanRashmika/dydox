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

public class jasper_productInvoice extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            System.out.println("okkkk");
            String json_str = req.getParameter("json_str");
            System.out.println(json_str);
            JSONObject jsonOBJ = (JSONObject) new JSONParser().parse(json_str);

            JSONArray arr_1 = (JSONArray) jsonOBJ.get("inv_id");
            JSONArray arr_2 = (JSONArray) jsonOBJ.get("date");
            JSONArray arr_3 = (JSONArray) jsonOBJ.get("time");
            JSONArray arr_4 = (JSONArray) jsonOBJ.get("sub_tot");
            JSONArray arr_5 = (JSONArray) jsonOBJ.get("addon");
            JSONArray arr_6 = (JSONArray) jsonOBJ.get("dis");
            JSONArray arr_7 = (JSONArray) jsonOBJ.get("tot");
            JSONArray arr_8 = (JSONArray) jsonOBJ.get("status");

            InputStream i = getClass().getResourceAsStream("/reports/product_invoices.jrxml");//viewJasperReport.class
            JasperReport compileReport = JasperCompileManager.compileReport(i);

            Map<String, Object> m = new HashMap<>();

            ArrayList<bean_productInvoice> a = new ArrayList<>();

            for (int j = 0; j < arr_1.size(); j++) {

                bean_productInvoice b = new bean_productInvoice();//bean class object
                b.setINV_ID(arr_1.get(j).toString());
                b.setDATE(arr_2.get(j).toString());
                b.setTIME(arr_3.get(j).toString());
                b.setSUB_TOTAL(arr_4.get(j).toString());
                b.setADDITIONAL(arr_5.get(j).toString());
                b.setDISCOUNT(arr_6.get(j).toString());
                b.setTOTAL(arr_7.get(j).toString());
                b.setSTATUS(arr_8.get(j).toString());
                System.out.println(arr_1.get(j).toString());
                System.out.println(arr_8.get(j).toString());
                a.add(b);
            }

            JRBeanCollectionDataSource bean_coll = new JRBeanCollectionDataSource(a);

            byte[] pdf_data = JasperRunManager.runReportToPdf(compileReport, m, bean_coll);

            String project_path = req.getSession().getServletContext().getRealPath("/");
            String save_path = "reports/productInvoice/" +new SimpleDateFormat("yyy-MM-dd").format(new Date())+" "+ System.currentTimeMillis() + ".pdf";
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
