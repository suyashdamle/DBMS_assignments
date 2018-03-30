var id=parseInt(Math.random()*100);
$(function() {
  loadEvents();
  showTodaysDate();
  initializeCalendar();
  getCalendars();
  initializeRightCalendar();
  initializeLeftCalendar();
  disableEnter();
});
/*----------------------------------initial events-----------------------*/

function getSearchParameters() {
      var prmstr = window.location.search.substr(1);
      return prmstr != null && prmstr != "" ? transformToAssocArray(prmstr) : {};
}

function transformToAssocArray( prmstr ) {
    var params = {};
    var prmarr = prmstr.split("&");
    for ( var i = 0; i < prmarr.length; i++) {
        var tmparr = prmarr[i].split("=");
        params[tmparr[0]] = tmparr[1];
    }
    return params;
}

var params = getSearchParameters();
var user_id=params['user_id'];
var user_type=params['user_type'];
var course_id=params['course_id'];
var name_of_user=params['name_of_user'];

/******************************   ADDING HERE ***************************************************/
var deleventDatabase = function(assData){  
var saveData = $.ajax({
       type:"GET",
       url:"http://localhost/delEvents.php",
       data: assData,
       success:function( msg ) {
                console.log(msg);

              }

              });
}

var editDatabase = function(assData){  
var saveData = $.ajax({
       type:"GET",
       url:"http://localhost/editEvents.php",
       data: assData,
       success:function( msg ) {
                console.log(msg);

              }

              });
}

var insertDatabase = function(assData){  
var saveData = $.ajax({
       type:"GET",
       url:"http://localhost/insertEvents.php",
       data: assData,
       success:function( msg ) {
                console.log(msg);
              }

              });
// alert("Something went wrong");
// saveData.error(function() { alert("Something went wrong"); });
}




/*---------------------------------global id which will continuously get incremented with additional events ---------------------*/


/*********************************************   TILL HERE   *********************************************************************/








/*---------------------------right panel global variable date-------------*/
var globaldate = new Date();
/* --------------------------initialize calendar-------------------------- */
var initializeCalendar = function() {
  $('.calendar').fullCalendar({
    customButtons: {
        add_event: {
            text: 'Add Assignment',
            click: function() {
               newEvent_2(); 
            }
        }
    },
	
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      // create events
     events:{url:'/get_events.php',
	type:'GET',
	data:{
		uname:user_id,
		user_type:user_type,
		course_id:course_id
	},
	
	},

      defaultTimedEventDuration: '00:00:00',
      forceEventDuration: true,
      eventBackgroundColor: '#337ab7',
      editable: true,
      height: screen.height - 160,
      timezone: 'America/Chicago',
    });
}

/*--------------------------calendar variables--------------------------*/
var getCalendars = function() {
  $cal = $('.calendar');
  $cal1 = $('#calendar1');
  $cal2 = $('#calendar2');
}

/* -------------------manage cal2 (right pane)------------------- */
var initializeRightCalendar = function()  {
  $cal2.fullCalendar('changeView', 'listDay');
	
  $cal2.fullCalendar('option', {
  
    slotEventOverlap: false,
    allDaySlot: false,
    header: {
      center:'add_event',
      right: 'prev,next'
    },
    selectable: true,
    selectHelper: true,
    select: function(start, end) {
        newEvent(start);
    },
    eventClick: function(calEvent, jsEvent, view) {
        editEvent(calEvent);
    },
  });
}

/* -------------------manage cal1 (left pane)------------------- */
var initializeLeftCalendar = function() {
  $cal1.fullCalendar('option', {
  
      header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month'
      },
      navLinks: false,
      dayClick: function(date) {
          globaldate = date;
          //console.log(date.format("DD-MM-YYYY"));
          cal2GoTo(date);
      },
      eventClick: function(calEvent) {
          cal2GoTo(calEvent.start);
      }
  });
}

/* -------------------moves right pane to date------------------- */
var cal2GoTo = function(date) {
	globaldate = date;
  $cal2.fullCalendar('gotoDate', date);
}


var loadEvents = function() {
  return events;
}

var newEvent_2=function(){
	if(user_type=='Student'){
		alert("YOU ARE NOT ALLOWED TO GIVE ASSIGNEMNTS");
		return;
	}
 $('input#title').val("");
 $('input#due_date').val("");
  $('input#due_time').val("11:55 pm");
$('input#max_marks').val("100");
$('input#optradio').val("");
  $('#newEvent').modal('show');
  $('#submit').unbind();
  $('#submit').on('click', function() {
  var title = $('input#title').val();
  var du_date = moment(globaldate).format("DD-MM-YYYY");           // made changes here
  var du_time = $('input#due_time').val();
  var max_marks = $('input#max_marks').val();
	var optradio=$('input#diff3').val();
	 
  du_date = moment(du_date+" "+du_time,"DD-MM-YYYY hh:mm a");
console.log(optradio);
  if (title) {
    var eventData = {
        id: id,
        title: title,
        start: new Date(du_date),
        end: new Date(du_date),
        allDay:false
    };
	id=id+1;
    //events.push(eventData);
	setTimeout(function(){	
	$cal.fullCalendar('removeEvents');//    $cal.fullCalendar('removeEventSource',events);
	$cal.fullCalendar('refetchEvents');    
	//$cal.fullCalendar('addEventSource',events);
    $cal.fullCalendar('rerenderEvents');
	},1);

	/**********************************************************************************/	
	//contact the database and update it.
	var assData = {
		ano: eventData.id,
		ps: eventData.title,
		user_id: user_id,
		course_id: course_id,
		max_marks: max_marks,
		difficulty_rating: optradio,
		duedt: moment(du_date).format("YYYY-MM-DD hh:mm:ss")             // made changes here
	};
	// console.log(du_date.format("YYYY-MM-DD hh:mm:ss"));
	// alert("Something went wrong");
	insertDatabase(assData); 
	
	/*********************************************************************************/

    // $cal.fullCalendar('renderEvent', eventData, true);
    $('#newEvent').modal('hide');
    }
  else {
    alert("Title can't be blank. Please try again.")
  }
  });	

}

//////
var newEvent = function(start) {
  $('input#title').val("");
  $('#newEvent').modal('show');
  $('#submit').unbind();
  $('#submit').on('click', function() {
  var title = $('input#title').val();
  if (title) {
    var eventData = {
        title: title,
        start: start
    };
    $cal.fullCalendar('renderEvent', eventData, true);
    $('#newEvent').modal('hide');
    }
  else {
    alert("Title can't be blank. Please try again.")
  }
  });
}

var editEvent = function(calEvent) {
	
	if(calEvent.subbyi!=user_id){
		if(user_type=='Instructor'){
			alert("YOU ARE NOT ALLOWED TO MODIFY THIS ASSIGNMENT");	
			return;
		}
		if(user_type=='Student'){
	
		 var assData = {
        ano: calEvent.id,
		sid: user_id,
		course_id: course_id
      	};
              window.location.href="http://localhost/studform.php?ano="+calEvent.id+"&sid="+user_id+"&course_id="+calEvent.title.split("-")[0].trim()+"&user_type="+user_type+"&name_of_user="+name_of_user;
              return;
		}
	} 
	
  $('input#editTitle').val(calEvent.title);
  $('input#editTime').val(""); 
  $('#editEvent').modal('show');
  $('#update').unbind();
  $('#update').on('click', function() {
    var title = $('input#editTitle').val();
    $('#editEvent').modal('hide');
    var eventData;
	/****************************************************************/
	 //if given due time is blank then don't update the time
	var editdu_timestamp = $('input#editTime').val();
	if(editdu_timestamp){
		//create the updated timestamp
		var datestr = moment(globaldate).format("DD-MM-YYYY");
		console.log("updating ... "+datestr);
		editdu_timestamp = moment(datestr+" "+$('input#editTime').val(),"DD-MM-YYYY hh:mm a/p");
	}
	else{
	    //else initialize it with original timestamp
	    editdu_timestamp = calEvent.start;
	} 

	/**********************************************************************/



    if (title) {
      calEvent.title = title;
		calEvent.start = editdu_timestamp;
      calEvent.end = editdu_timestamp;
      $cal.fullCalendar('updateEvent', calEvent);


	/************************************************************************/
	//now you can edit the database safely.
      //alert("calling editDatabase.");
      //assignment no. ano is assumed to be the event Id.
      var assData = {
        ano: calEvent.id,
        ps: calEvent.title,
		user_id: user_id,
		course_id: course_id,
        duedt: moment(editdu_timestamp).format("YYYY-MM-DD hh:mm:ss")   // changing here
      };
      editDatabase(assData);
	/************************************************************************/

    } else {
    alert("Title can't be blank. Please try again.");
    }
  });
  $('#delete').on('click', function() {
    $('#delete').unbind();
    if (calEvent._id.includes("_fc")){
      $cal1.fullCalendar('removeEvents', [getCal1Id(calEvent._id)]);
      $cal2.fullCalendar('removeEvents', [calEvent._id]);
    } else {
      $cal.fullCalendar('removeEvents', [calEvent._id]);
    }

	/*************************************************************************/
	var assData = {
        ano: calEvent.id,
		course_id: course_id
    };
    deleventDatabase(assData);
	/*************************************************************************/


    $('#editEvent').modal('hide');
  });
}

/* --------------------------load date in navbar-------------------------- */
var showTodaysDate = function() {
  n =  new Date();
  y = n.getFullYear();
  m = n.getMonth() + 1;
  d = n.getDate();
  $("#todaysDate").html("Today is " + m + "/" + d + "/" + y);
};

/* full calendar gives newly created given different ids in month/week view
    and day view. create/edit event in day (right) view, so correct for
    id change to update in month/week (left)
  */
var getCal1Id = function(cal2Id) {
  var num = cal2Id.replace('_fc', '') - 1;
  var id = "_fc" + num;
  return id;
}

var disableEnter = function() {
  $('body').bind("keypress", function(e) {
      if (e.keyCode == 13) {
          e.preventDefault();
          return false;
      }
  });
}
