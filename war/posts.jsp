<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<% 	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key blogKey = KeyFactory.createKey("Blog", "Awesome Blog");
	Query query = new Query("Post", blogKey).addSort("date", Query.SortDirection.DESCENDING);
	List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults()); %>
 
<html>
  <head>
  	<title>Awesome Blog</title>
  	<link href="https://fonts.googleapis.com/css?family=Merriweather|Open+Sans:400,400i,700" rel="stylesheet">
  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>

  <body>
  	<div id="top-bar">
  		<div class="wrap">
			<% if (user != null) { %>
				<p id="login">
					<a href="/compose.jsp">Create Post</a>
					<a href='<%= userService.createLogoutURL("/blog.jsp") %>'>Logout</a>
				</p>
			<% } else { %> 
				<p id="login">
					<a href='<%= userService.createLoginURL("/compose.jsp") %>'>Login</a>
				</p>
			<% } %>
			<h1><a href="/blog.jsp">AB</a></h1>
		</div>
	</div>
	<div id="content">
		<div class="wrap">
		<% 	for (Entity post : posts) {
				pageContext.setAttribute("post_title", post.getProperty("title"));
				pageContext.setAttribute("post_content", post.getProperty("content"));
            	pageContext.setAttribute("post_author", post.getProperty("user"));
            	pageContext.setAttribute("post_date", post.getProperty("date")); %>
            	<h2>${fn:escapeXml(post_title)}</h2>
            	<h3>Posted by ${fn:escapeXml(post_author.nickname)} on ${fn:escapeXml(post_date)}</h3>
            	<p>${fn:escapeXml(post_content)}</p>
		<%	} %>
		<a href="/blog.jsp">Home ></a>
		</div>
	</div>
	<div id="footer">
		<div class="wrap">
			<p id="class">EE461L Fall 2016</p>
			<p id="names">Brian White, Ronny MacMaster</p>
		</div>
	</div>
  </body>
</html>