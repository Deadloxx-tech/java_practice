<%@ page import="com.demo.bean.FeedbackBean" %>

<html>
<head>
<title>Feedback Result</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<div class="result">

<h2>Thank You For Your Feedback</h2>

<%
FeedbackBean fb = (FeedbackBean)request.getAttribute("fb");
%>

<table>

<tr>
<td>Name</td>
<td><%=fb.getName()%></td>
</tr>

<tr>
<td>Email</td>
<td><%=fb.getEmail()%></td>
</tr>

<tr>
<td>Course</td>
<td><%=fb.getCourse()%></td>
</tr>

<tr>
<td>Rating</td>
<td><%=fb.getRating()%></td>
</tr>

<tr>
<td>Comment</td>
<td><%=fb.getComment()%></td>
</tr>

</table>

<br>

<a href="index.jsp">Give Another Feedback</a>

</div>

</body>
</html>