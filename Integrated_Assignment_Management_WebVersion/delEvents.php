<?php
$db_host = "localhost";
$db_user = "root";
$db_pswd = "";
$database = "unload_me_db";
// // 1. Create a connection to the server. 
// $con = mysql_connect($db_host, $db_user,$db_pswd);

// // make sure a connection has been made
// if (!$con){
// die("Database connection failed: " . mysql.error());
// }

// // 2. Select the database on the server
// $db_select = mysql_select_db($database, $con);
// if (!$db_select){
// die("Database selection failed: " . mysql.error());
// }


$con = mysqli_connect("localhost","root","","unload_me_db");
//$password = md5($password);

// $query = "SELECT * FROM users WHERE email='$email' AND password='$password'";
//I want to fetch the event data from here.
// $query = "SELECT i.pass FROM inst as i WHERE i.iid = '$username';";

// CREATE TABLE ass
// (
// 	ps			VARCHAR(1000)	NOT NULL,
// 	cid			CHAR(7)			NOT NULL,
// 	semid		CHAR(6)			NOT NULL,
// 	ano			INT				NOT NULL,
// 	subbyi		CHAR(9)			NOT NULL,
// 	duedt		TIMESTAMP		NOT NULL,
// 	maxmks		INT				NOT NULL,
// 	wtge		DECIMAL(5,2),
// 	avgmks		INT,
// 	avgdifi		INT,
// 	avgdifs		INT,		-- out of 5
// 	PRIMARY KEY (cid, semid, ano),
// 	FOREIGN KEY (cid,semid)		REFERENCES csem(cid,semid),
// 	FOREIGN KEY (subbyi)		REFERENCES inst(iid)
// );

function debug_to_console( $data ) {
    $output = $data;
    if ( is_array( $output ) )
        $output = implode( ',', $output);

    echo "<script>console.log( 'Debug Objects: " . $output . "' );</script>";
}

// $ps = $_POST['ps'];

//debug_to_console($ps);
$ano = $_GET['ano'];
$cid = $_GET['course_id'];
$semid = "SP2018";
debug_to_console("assignment no.".$ano);
$subbyi = "usernamem";
// 2038-01-19 03:14:07 format
// $duedt =  $_POST['duedt'];
//debug_to_console($duedt);
$maxmks = 50;
$wtge = 25.3;
$avgmks = 10;
$avgdifi = 0;
$avgdifs = 0;

// INSERT INTO ass(ps,cid,semid,ano,subbyi,duedt,maxmks,wtge,avgmks,avgdifi,avgdifs) VALUES ('adsfa','coursid','semisd',10,'usernamem','2038-01-19 03:14:07',50,25.3,10,0,0);

// UPDATE ass SET WHERE
// UPDATE ass SET ps='DDDD',subbyi='usernamem',duedt='2038-01-19 03:14:07',maxmks='50',wtge='25.3',avgmks='10',avgdifi='0',avgdifs='0' WHERE cid='coursid' AND semid='semisd' AND ano='10' ;


$query = "DELETE FROM ass WHERE cid='".$cid."' AND semid='".$semid."' AND ano='".$ano."' ;";
echo $query;


debug_to_console($query);
// $sql = "UPDATE MyGuests SET lastname='Doe' WHERE id=2";
// $query = "INSERT INTO ass(ps,cid,semid,ano,subbyi,duedt,maxmks,wtge,avgmks,avgdifi,avgdifs) VALUES ('$ps','$cid','$semid','$ano','$subbyi','$duedt','$maxmks','$wtge','$avgmks','$avgdifi','$avgdifs');";


$result = mysqli_query($con, $query);
debug_to_console($result);
echo "$result"
// $get = mysqli_fetch_assoc($result);
// $numResults = mysqli_num_rows($result);

// if($numResults == 1)
// {			
// 	if($get["pass"]==$psw){
// 	include 'calendar.html';}
// 	// $query = "UPDATE users SET login_count = login_count + 1 WHERE email='$email'";
// 	// mysqli_query($con, $query);
// }
// else
// {
// 	echo "<br><br><br><center><h1>Invalid credentials!</h1></center>";
// }
// // if($get[""])
?>
