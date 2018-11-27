package servelet;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import pojos.User;

public class updateUserDetails extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            System.out.println("serverr yo");
            Session s = util.NewHibernateUtil.getSessionFactory().openSession();

            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            User u = (User) s.load(User.class, Integer.parseInt(o.get("uid").toString()));

            if (!o.get("fname").toString().isEmpty() &&!o.get("lname").toString().isEmpty()) {

                u.setFirstName(o.get("fname").toString());
                u.setLastName(o.get("lname").toString());
                u.setStreet(o.get("street").toString());
                u.setCity(o.get("city").toString());
                u.setZip(o.get("zip").toString());
                u.setCountry(o.get("country").toString());
                u.setMobile(o.get("mobile").toString());

                DiskFileItemFactory df = new DiskFileItemFactory();
                ServletFileUpload su = new ServletFileUpload(df);

                List<FileItem> items = su.parseRequest(req);
                for (FileItem f : items) {
                    if (!f.isFormField()) {
                        System.out.println("image found");
                        System.out.println(f.getName());
                        System.out.println(f.getFieldName());
                        String path = getServletContext().getRealPath("/") + "user_images/";

                        if (f.getName().toLowerCase().contains(".png") || f.getName().toLowerCase().contains(".jpg") || f.getName().toLowerCase().contains(".jpeg")) {

                            path += System.currentTimeMillis() + ".png";
                            u.setImgUrl(path);

                            File file = new File(path);
                            f.write(file);
                        }

                    }
                }

                s.update(u);
                Transaction t = s.beginTransaction();
                t.commit();

                resp.getWriter().write("1");

            } else {
                //fname lname not fill
                resp.getWriter().write("0");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
