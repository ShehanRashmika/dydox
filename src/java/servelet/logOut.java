package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class logOut extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String status = req.getParameter("status");
            System.out.println(status);
            
            HttpSession s2 = req.getSession();
            s2.invalidate();
            if (status != null) {

                if (status.equals("user")) {
                    resp.sendRedirect("index.jsp");

                }
                
                if (status.equals("admin")) {
                    resp.sendRedirect("admin_login.jsp");

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
