package com.demo.bean;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class FeedbackServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

response.setContentType("text/html");

String name = request.getParameter("name");
String email = request.getParameter("email");
String course = request.getParameter("course");
String rating = request.getParameter("rating");
String comment = request.getParameter("comment");

FeedbackBean fb = new FeedbackBean();

fb.setName(name);
fb.setEmail(email);
fb.setCourse(course);
fb.setRating(rating);
fb.setComment(comment);

request.setAttribute("fb", fb);

RequestDispatcher rd = request.getRequestDispatcher("/result.jsp");
rd.forward(request, response);

}

}