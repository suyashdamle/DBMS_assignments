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
</html>

<?php
/* connect to the db */
$connection = mysql_connect('localhost','root','');
mysql_select_db('unload_me_db',$connection);

/* show tables */

	
	echo '<h3>Assignment Stats</h3>';

	$result2 = mysql_query('SELECT cid,semid,ano,avg(mks),avg(dif) from studass group by cid,semid,ano order by cid,semid,ano;',$connection) or die('cannot show columns from '.$table);
	if(mysql_num_rows($result2)) {
		echo '<table cellpadding="10" cellspacing="10" class="db-table">';
		echo '<tr><th>Course Id</th><th>SEM</th><th>Assignment No</th><th>Avg Marks</th><th>Avg Difficulty Rating</th></tr>';
		while($row2 = mysql_fetch_row($result2)) {
			echo '<tr>';
			foreach($row2 as $key=>$value) {
				echo '<td>',$value,'</td>';
			}
			echo '</tr>';
		}
		echo '</table><br />';
	}


?>

