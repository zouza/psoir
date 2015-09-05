<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.amazonaws.*" %>
<%@ page import="com.amazonaws.auth.*" %>
<%@ page import="com.amazonaws.AmazonClientException" %>
<%@ page import="com.amazonaws.auth.AWSCredentials" %>
<%@ page import="com.amazonaws.auth.profile.ProfileCredentialsProvider" %>
<%@ page import="com.amazonaws.regions.Region" %>
<%@ page import="com.amazonaws.regions.Regions" %>
<%@ page import="com.amazonaws.services.sqs.AmazonSQS" %>
<%@ page import="com.amazonaws.services.sqs.AmazonSQSClient" %>
<%@ page import="com.amazonaws.services.sqs.model.*" %>


<%
	AmazonSQS queue;
   
   	AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
   	queue = new AmazonSQSClient(credentialsProvider);
   
  	queue.setRegion(Region.getRegion(Regions.US_WEST_2));
   
   	String file = String.valueOf(session.getAttribute("img"));
   
   	CreateQueueRequest req = new CreateQueueRequest("janiszewska1SQS");
	String qUrl = queue.createQueue(req).getQueueUrl();
	queue.sendMessage(new SendMessageRequest(qUrl, file));
%>

<script>
window.location.href = "gallery.jsp";
</script>
