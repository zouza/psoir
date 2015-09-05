<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.ServletRequest.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.UUID.*" %>
<html> 
  <head>
    <title>S3 POST Form</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="styles/styles.css" rel="stylesheet" type="text/css">
  </head>

  <body>
  <% 
	String id; 
	%>
  <div>
    <a href="upload.html">Upload</a>
    <a href="gallery.jsp">Gallery</a>
  </div>
  	<%
			id = UUID.randomUUID().toString();
			id = id.substring(0, 8);
			id += ".jpg";
			session.setAttribute("img", "img"+id);
	%>
    <form action="https://aws.ajan.s3.amazonaws.com/" method="post" enctype="multipart/form-data">
      <input type="hidden" name="key" value="img<%=id %>">
      <input type="hidden" name="AWSAccessKeyId" value="*****"> 
      <input type="hidden" name="acl" value="public-read"> 
      <input type="hidden" name="success_action_redirect" value="http://52.26.255.78:8080/s3upload/queue.jsp">
      <input type="hidden" name="policy" value="*****">
      <input type="hidden" name="signature" value="*****">
      <input type="hidden" name="Content-Type" value="image/jpeg">
      <!-- Include any additional input fields here -->

      <h2>Wyslij plik na s3: </h2><br />
      <input name="file" type="file"> 
      <br /><br /> 
      <input type="submit" value="Upload File to S3">
    </form>
  </body>
</html>