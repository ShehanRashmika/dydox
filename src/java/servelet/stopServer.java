package servelet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Timer;
import java.util.TimerTask;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class stopServer extends HttpServlet {

    public static boolean serverState = true;
    public static String serverMsg;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            System.out.println("aawa");
            JSONObject o = (JSONObject) new JSONParser().parse(req.getParameter("json_str"));

            if (!o.get("time").toString().isEmpty() && !o.get("msg").toString().isEmpty()) {

                boolean isInt = false;
                int min = 0;
                try {
                    min = Integer.parseInt(o.get("time").toString());
                    isInt = true;
                } catch (Exception e) {

                    isInt = false;
                    resp.getWriter().write("1");
                }
                if (isInt) {

                    String msg = o.get("msg").toString();
                    stopServer.serverMsg = msg;
                    System.out.println(min);
                    System.out.println(stopServer.serverMsg);
                    stopServer.serverState = false;

                    Timer t = new Timer();
                    TimerTask ts = new TimerTask() {

                        @Override
                        public void run() {
                            stopServer.serverState = true;
                            System.out.println("finish");
                        }
                    };
                    t.schedule(ts, 1000 * 60 * min);
                    System.out.println("ok");
                    resp.getWriter().write("2");
                }
            } else {
                resp.getWriter().write("0");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
