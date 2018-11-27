package servelet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class savePage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String page = req.getParameter("page");
            String pid = req.getParameter("pid");
            System.out.println("i wanna go to " + page);
            if (req.getSession().getAttribute("user") == null) {
                //not login
                req.getSession().setAttribute("page", page + "," + pid);
                resp.sendRedirect("index.jsp");
            } else {
                //login
                System.out.println("alredy login");
                resp.sendRedirect("checkOutCart.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
