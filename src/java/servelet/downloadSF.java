package servelet;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.Product;

public class downloadSF extends HttpServlet {

    File file;
    String ext;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
//            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));
//            String id = o.get("id").toString();
//            String filee = o.get("file").toString();
//            String file_name = o.get("file_name").toString();

            String id = req.getParameter("id").toString();
            String filee = req.getParameter("file").toString();
            String file_name = req.getParameter("file_name");
            System.out.println(id);
            System.out.println(filee);
            System.out.println(file_name);

            Session s = util.NewHibernateUtil.getSessionFactory().openSession();
            Product f = (Product) s.load(Product.class, Integer.parseInt(id));
            System.out.println(f.getSrs());

            if (filee.equals("srs")) {
                System.out.println("srs");
                file = new File(f.getSrs());
                file_name += "_SRS";
                System.out.println(f.getSrs());
                System.out.println(f.getSrs().split("\\.")[2]);
                if (f.getSrs().split("\\.")[2].equals("pdf")) {
                    ext = "pdf";

                } else {
                    ext = "docx";
                }

            } else if (filee.equals("demo")) {
                System.out.println("demo");
                file = new File(f.getDemoZip());
                file_name += "_DEMO";
                ext = "zip";
            } else if (filee.equals("original")) {
                System.out.println("srs");
                file_name += "_ORIGINAL";
                file = new File(f.getOrginalZip());
                ext = "zip";
            }
            ServletOutputStream sos = resp.getOutputStream();

            resp.setContentType("application/" + ext);

            resp.setDateHeader("Expires", 0);
            resp.addHeader("Content-Disposition", "attachment;filename=" + file_name + "." + ext);
            resp.setContentLength((int) file.length());

            FileInputStream fos = new FileInputStream(file);
            BufferedInputStream bis = new BufferedInputStream(fos);

            int x;
            while ((x = bis.read()) != -1) {
                sos.write(x);
            }
            sos.flush();
            sos.close();
            System.out.println("ok");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
