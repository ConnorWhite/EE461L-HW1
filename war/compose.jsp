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
 
<html>
  <head>
  	<title>Awesome Blog</title>
  	<link href="https://fonts.googleapis.com/css?family=Merriweather|Open+Sans" rel="stylesheet">
  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>
  <body>
  	<div id="top-bar">
  		<div class="wrap">
			<%  UserService userService = UserServiceFactory.getUserService();
				User user = userService.getCurrentUser();
				if (user != null) { %>
				<p id="login">
					<a href="/blog.jsp">Home</a>
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
	<div id="post-editor">
		<div class="wrap">
  			<h2>Post Editor</h2>
			<form action="/blog" method="post">
				<div>
					<textarea id="post-title" name="title" placeholder="Enter Title Here" rows="1" cols="60"></textarea>
				</div>
		  		<div>
		  			<textarea id="post-name" name="content" rows="20" cols="100"></textarea>
		  		</div>
		  		<div>
		  			<input type="submit" value="Submit Post" />
		  			<a class="cancelButton" href="/blog.jsp">Cancel</a>
		  		</div>
		  		<input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>
			</form>
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