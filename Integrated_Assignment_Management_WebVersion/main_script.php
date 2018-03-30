<html>
<head>
<style>
.btn {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;	
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}
.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}



}
</style>
</head>












<?php
$username='None';
$psw='None';
$user_type='None';
//$course_id='something_stupid';
if(isset($_GET['uname'])){
$username=$_GET['uname'];
}
if(isset($_GET['psw'])){
$psw=$_GET['psw'];
}
if(isset($_GET['user_type'])){
$user_type=$_GET['user_type'];
}
?>



<?php

$con = mysqli_connect("localhost","root","","unload_me_db");
//$password = md5($password);

// $query = "SELECT * FROM users WHERE email='$email' AND password='$password'";
if($user_type=='Instructor'){
	$query = "SELECT i.pass,i.name FROM inst as i WHERE i.iid = '$username';";
}
if($user_type=='Student'){
	$query = "SELECT s.pass,s.name FROM stud as s WHERE s.sid = '$username';";
}

$result = mysqli_query($con, $query);

$get = mysqli_fetch_assoc($result);
$numResults = mysqli_num_rows($result);

if($numResults == 1)
{			
	$name_of_user=$get["name"];
	if($get["pass"]==$psw){
		if($user_type=='Instructor'){
			$query=(" SELECT cs.cid, cs.name FROM csem cs INNER JOIN teaches t ON (cs.cid = t.cid AND cs.semid = t.semid) WHERE t.iid ='".$username."' AND t.semid = 'SP2018';");
			$result = mysqli_query($con, $query);
			//finding the right course id from the instructor
			// if confirmed, load a new page
			echo "<html>";
			echo "<form action='calendar.html',method= 'POST'>";
			echo "<input type='hidden' name='user_id' value=$username />";
			echo "<input type='hidden' name='user_type' value=$user_type />";
			echo "<input type='hidden' name='name_of_user' value=$name_of_user />";
			echo "<select name='course_id'>'";
			while ($get=mysqli_fetch_assoc($result)) {
    			echo "<option value= '".$get["cid"]."'>".$get["cid"]." - ".$get["name"]." </option><br><br>";
    		}
    		echo "</select>";
  			echo "<input type='submit'>";
			echo "</form>";
			echo "</html>";
			//include 'calendar.html';
		}
		if($user_type=='Student'){
			header("Location: calendar.html?user_id=".$username."&user_type=".$user_type."&name_of_user=".$name_of_user);
			exit();			
		}	
	}
	// $query = "UPDATE users SET login_count = login_count + 1 WHERE email='$email'";
	// mysqli_query($con, $query);
}
else
{
	echo "<br><br><br><center><h1>Invalid credentials!</h1></center>";
}
// if($get[""])
?>

