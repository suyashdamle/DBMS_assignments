<!DOCTYPE html>
<html>
<head>
<style>
		body 
		{
		    background: url('images/assignment.jpg') no-repeat center center fixed;
		    background-size: cover; /* for IE9+, Safari 4.1+, Chrome 3.0+, Firefox 3.6+ */
	        -webkit-background-size: cover; /* for Safari 3.0 - 4.0 , Chrome 1.0 - 3.0 */
	        -moz-background-size: cover; /* optional for Firefox 3.6 */ 
	        -o-background-size: cover; /* for Opera 9.5 */
	        margin: 20px;
	        overflow: hidden;
		    font-size: 200%;
		}
	</style>
	<title></title>
</head>

<body>
<?php
if(isset($_GET['ano'])){
$ano=$_GET['ano'];
echo "<h1> ASSIGNMENT ".$ano."</h1>";

}?>
	<button name="" type="button">
		View Assignment 
	</button>
<br>
	<form>
		<input type="file" name="subfile" accept=".zip" value=""><br>
		<input type="submit" name = "submitfile" value = "Submit Assignment file (*.zip)"><br><br>
	</form>
	<form action="studform.php" method="get">
		<br>
		<input type="radio" name="diff" id="diff" value=1> <img src="images/easy.png" alt="smile emoji" style="width:25px;">Easy<br>
		<input type="radio" name="diff" id="diff" value=2> <img src="images/moderate.png" alt="unmoved emoji" style="width:25px;">Moderate<br>
		<input type="radio" name="diff" id="diff" value=3> <img src="images/difficult.png" alt="sad emoji" style="width:25px;">Difficult<br>
		<input type="radio" name="diff" id="diff" value=4> <img src="images/verydifficult.png" alt="scared emoji" style="width:25px;">Very Difficult<br><br>
		<input type="submit" name = "submit" value = "Submit Difficulty">
	</form>
</body>
</html>

<?php 
$ano='None';
$sid='None';
$course_id='None';
//$course_id='something_stupid';

if(isset($_GET['sid'])){
$sid=$_GET['sid'];}

if(isset($_GET['course_id'])){
$course_id=$_GET['course_id'];}

if(isset($_GET['name_of_user'])){
$name_of_user=$_GET['name_of_user'];}

if(isset($_GET['user_type'])){
$user_type=$_GET['user_type'];}
//echo $sid;
//echo $course_id;

//$str="Location: calendar.html?user_id=".$sid2."&user_type=".$user_type2."&name_of_user".$name_of_user2;
$con = mysqli_connect("localhost","root","","unload_me_db");

	if(isset($_GET['submit']))
	{
		$diff = $_GET['diff'];
		echo "<br><br>Difficulty selected ".$diff."<br>";
		$query = "INSERT INTO studass VALUES (".$sid.",".$course_id.",'SP2018',".$ano.",NULL,".$diff.");";
//		DB::query('INSERT INTO studass VALUES (:sid, :cid, :semid, :ano, null, :dif)',array(':sid' => givensid,':cid' => givencid, ':semid' => givensemid, ':ano' => givenano, ':dif' => $diff ));
		$result = mysqli_query($con, $query);
		//echo $query;
		echo "Difficulty submitted successfully!";		
	}
			
?>
