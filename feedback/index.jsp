<html>
<head>
<title>Student Feedback System</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<div class="card">

<h2>Student Feedback System</h2>

<form action="feedback" method="post">

<label>Name</label>
<input type="text" name="name" required>

<label>Email</label>
<input type="email" name="email" required>

<label>Course</label>
<select name="course">
<option>Java</option>
<option>Python</option>
<option>Web Development</option>
<option>Data Science</option>
</select>

<label>Rating</label>
<select name="rating">
<option>Excellent</option>
<option>Good</option>
<option>Average</option>
<option>Poor</option>
</select>

<label>Comments</label>
<textarea name="comment"></textarea>

<input type="submit" value="Submit Feedback">

</form>

</div>

</body>
</html>