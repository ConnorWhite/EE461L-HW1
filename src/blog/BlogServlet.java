package blog;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class BlogServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		if(user!=null){
			resp.setContentType("text/plain");
			resp.getWriter().println("Hello," + user.getNickname());
		} else {
			resp.sendRedirect(userService.createLoginURL("/blog.jsp"));
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// fetch data
		Date date = new Date();
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();		
		
		// build greeting
		Key blogKey = KeyFactory.createKey("Blog", "Awesome Blog");
		Entity post = new Entity("Post", blogKey);
		post.setProperty("user", user);
		post.setProperty("date", date);
		post.setProperty("title", title);
		post.setProperty("content", content);

		// store entity
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(post);
		
		resp.sendRedirect("/blog.jsp");
	}
}
