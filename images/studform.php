<!DOCTYPE html>
<html>
<head>
	<style>
		body 
		{
		    background: url('assignment.jpg') no-repeat center center fixed;
		    background-size: cover; /* for IE9+, Safari 4.1+, Chrome 3.0+, Firefox 3.6+ */
	        -webkit-background-size: cover; /* for Safari 3.0 - 4.0 , Chrome 1.0 - 3.0 */
	        -moz-background-size: cover; /* optional for Firefox 3.6 */ 
	        -o-background-size: cover; /* for Opera 9.5 */
	        margin: 20px;
	        overflow: hidden;
		    font-size: 200%;
		}
	</style>
</head>
<body>
	<h1 style="font-size: 150%">
		Assignment 1
	</h1>
	<button name="" type="button">
		View Assignment 
	</button>
	<br>
	<form>
		<input type="file" name="subfile" accept=".zip" value=""><br>
		<input type="submit" name = "submitfile" value = "Submit Assignment file (*.zip)">
	</form>
	<form action="studform.php" method="post">
		<br>
		<input type="radio" name="diff" value=1> <img src="easy.png" alt="smile emoji" style="width:25px;"> Easy<br>
		<input type="radio" name="diff" value=2> <img src="moderate.png" alt="unmoved emoji" style="width:25px;"> Moderate<br>
		<input type="radio" name="diff" value=3> <img src="difficult.png" alt="sad emoji" style="width:25px;"> Difficult<br>
		<input type="radio" name="diff" value=4> <img src="verydifficult.png" alt="scared emoji" style="width:25px;"> Very Difficult<br><br>
		<input type="submit" name = "submit" value = "Submit Difficulty">
	</form>
</body>


<?php 

include($_SERVER['DOCUMENT_ROOT'].'/classes/DB.php');

	if(isset($_POST['submit']))
	{
		$diff = $_POST['diff'];
		echo "<br><br>Difficulty selected ".$diff."<br>";
		//DB::query('INSERT INTO studass VALUES (:sid, :cid, :semid, :ano, null, :dif)',array(':sid' => givensid,':cid' => givencid, ':semid' => givensemid, ':ano' => givenano, ':dif' => $diff ));
		echo "Difficulty submitted successfully!";
	}		
?>

</html>