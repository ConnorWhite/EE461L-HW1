package compose;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.FetchOptions;

public class ComposeServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		FetchOptions.Builder.
		System.out.println(req.getParameterMap());
		resp.sendRedirect("/compose.jsp");
	}
}