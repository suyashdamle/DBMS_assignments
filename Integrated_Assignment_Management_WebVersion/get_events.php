<?php
//Find all the events
//$events = Event::find_all();
$uname='None';
$user_type='None';
$course_id='None';
$uname=$_GET["uname"];
$user_type=$_GET['user_type'];
if(isset($_GET['course_id'])){
$course_id=$_GET['course_id'];}
$con = mysqli_connect("localhost","root","","unload_me_db");
//$password = md5($password);

if($user_type=='Instructor'){
$query = "SELECT a.ps, a.ano, a.cid, a.duedt, a.avgdifi,a.subbyi, n.nstuds FROM cidcid c INNER JOIN (ass a, nstudbycid n) ON (c.cid1 = a.cid AND c.semid = a.semid AND c.cid1 = n.cid AND c.semid = n.semid) WHERE c.cid2 = '".$course_id."' AND c.semid = 'SP2018';";
}
if($user_type=='Student'){
$query="SELECT a.ps, a.ano, a.cid, a.duedt, a.avgdifi, a.maxmks,a.subbyi
FROM stud s JOIN reg r ON (s.sid = r.sid) JOIN ass a ON (r.cid=a.cid AND a.semid = r.semid)
WHERE s.sid ='".$uname."' AND a.semid = 'SP2018';";
//echo $query;
}
$result = mysqli_query($con, $query);
$resultset = array();
while($get = mysqli_fetch_assoc($result)){
	$resultset[] = $get;
}
$count=0;
$eventList = array();            // Assemble list of all events here

     foreach($resultset as $event):
	     ++$count;
       $eventList[] = array(              // Add our event as the next element in the event list
            'id'    => $event['ano'],//$event['ano'],//(int) $event->id,
            'title' => $event['cid']." - ".$event['ps']." - ( ".$event['avgdifi']." )",
            'start' => explode(" ",$event['duedt'])[0]."T".explode(" ",$event['duedt'])[1].".000Z",
            'end'   => null,
			'subbyi'=> $event['subbyi']
            //'url'   => "event_detail.php"
	    //'id'=> 4,
  		//'title'=> $user_type,
  		//'start'=> "2018-03-13T13:30:00.000Z",
  		//'end'=> null 	 	
  	);         
    endforeach;

    echo json_encode($eventList);       // encode and output the whole list.
//SELECT a.ps, a.ano, a.cid, a.duedt, a.avgdifi, n.nstuds
//FROM cidcid c INNER JOIN (ass a, nstudbycid n) ON (c.cid1 = a.cid AND c.semid = a.semid AND c.cid1 = n.cid AND c.semid = n.semid)
//WHERE c.cid2 = givencid AND c.semid = currsemid;
?>


