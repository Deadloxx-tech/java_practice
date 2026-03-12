package com.demo.bean;

public class FeedbackBean {

private String name;
private String email;
private String course;
private String rating;
private String comment;

public void setName(String name){
this.name = name;
}

public String getName(){
return name;
}

public void setEmail(String email){
this.email = email;
}

public String getEmail(){
return email;
}

public void setCourse(String course){
this.course = course;
}

public String getCourse(){
return course;
}

public void setRating(String rating){
this.rating = rating;
}

public String getRating(){
return rating;
}

public void setComment(String comment){
this.comment = comment;
}

public String getComment(){
return comment;
}

}