<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.ServletRequest.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.UUID.*" %>
<%@ page import="com.amazonaws.*" %>
<%@ page import="com.amazonaws.auth.*" %>
<%@ page import="com.amazonaws.services.s3.*" %>
<%@ page import="com.amazonaws.services.s3.model.*" %>
<%@ page import="com.amazonaws.AmazonClientException" %>
<%@ page import="com.amazonaws.auth.AWSCredentials" %>
<%@ page import="com.amazonaws.auth.profile.ProfileCredentialsProvider" %>
<%@ page import="com.amazonaws.regions.Region" %>
<%@ page import="com.amazonaws.regions.Regions" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3Client" %>
<%@ page import="com.amazonaws.event.ProgressEvent" %>
<%@ page import="com.amazonaws.event.ProgressListener" %>
<%@ page import="com.amazonaws.services.s3.model.PutObjectRequest" %>
<%@ page import="com.amazonaws.services.s3.transfer.TransferManager" %>
<%@ page import="com.amazonaws.services.s3.transfer.Upload" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>s3 Galeria zdjęć</title>
<link href="styles/styles.css" rel="stylesheet" type="text/css">
</head>
<body>
  <div>
    <a href="upload.jsp">Upload</a>
    <a href="gallery.jsp">Gallery</a>
  </div>
<%
final AmazonS3 bucket;
AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
bucket = new AmazonS3Client(credentialsProvider);
Region usWest2 = Region.getRegion(Regions.US_WEST_2);
%>
	<div id="content" class="container">
		<h1>s3 images</h1>
		<div class="gallery">
            <%
            ObjectListing images = bucket.listObjects("aws.ajan","");
            do {
        		for (S3ObjectSummary objectSummary : images.getObjectSummaries()) 
        		{ 
        	%>
        		<img src="https://aws.ajan.s3.amazonaws.com/<%= objectSummary.getKey() %>" 
                alt="Image from s3" class="img" height="200px" width="200px" 
                id="<%=objectSummary.getKey()%>" />
        	<%	}
       		images = bucket.listNextBatchOfObjects(images);
			} while (images.isTruncated());
			%>
        </div>
	</div>
</body>
</html>