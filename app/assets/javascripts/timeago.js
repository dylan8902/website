function timestamp(d) {
	var timestamp = d;
	var string;
	var future;
	var second = 1;
	var minute = 60;
	var hour = 60*60;
	var day = 60*60*24;
	var week = 60*60*24*7;
	var month = 60*60*24*30;
	var year = 60*60*24*30*12;
	if(d<0) {
		future = true;
		d = d * -1;
	}
	if(d<minute) {
		string = Math.floor(d)+' second';
		if(Math.floor(d/second)>1)
			string += 's';
	}
	else if(d<hour) {
		string = Math.floor(d/minute)+' minute';
		if(Math.floor(d/minute)>1)
			string += 's';
	}
	else if(d<day) {
		string = Math.floor(d/hour)+' hour';
		if(Math.floor(d/hour)>1)
			string += 's';
	}
	else if(d<week) {
		string = Math.floor(d/day)+' day';
		if(Math.floor(d/day)>1)
			string += 's';
	}
	else if(d<month) {
		string = Math.floor(d/week)+' week';
		if(Math.floor(d/week)>1)
			string += 's';
	}
	else if(d<year){			
		string = Math.floor(d/month)+' month';
		if(Math.floor(d/month)>1)
			string += 's';
	}
	else {			
		string = Math.floor(d/year)+' year';
		if(Math.floor(d/year)>1)
			string += 's';
	}
	var t = new Date(0);
	t.setUTCSeconds(d);
	if(future)
		return '<time title="'+t.toUTCString().toLocaleString()+'" datetime="'+t.toUTCString()+'" data-timestamp="'+timestamp+'" class="ago">'+string+' from now</time>';
	else
		return '<time title="'+t.toUTCString().toLocaleString()+'" datetime="'+t.toUTCString()+'" data-timestamp="'+timestamp+'" class="ago">'+string+' ago</time>';
}
function timeago() {
	$('time.ago').each(function() {
		var future = false;
		var now = new Date()/1000;
		var d = Math.floor(now - $(this).attr('data-timestamp'));
		var string;
		var second = 1;
		var minute = 60;
		var hour = 60*60;
		var day = 60*60*24;
		var week = 60*60*24*7;
		var month = 60*60*24*30;
		var year = 60*60*24*30*12;
		if(d<0) {
			future = true;
			d = d * -1;
		}
		if(d<minute) {
			string = Math.floor(d)+' second';
			if(Math.floor(d/second)>1)
				string += 's';
		}
		else if(d<hour) {
			string = Math.floor(d/minute)+' minute';
			if(Math.floor(d/minute)>1)
				string += 's';
		}
		else if(d<day) {
			string = Math.floor(d/hour)+' hour';
			if(Math.floor(d/hour)>1)
				string += 's';
		}
		else if(d<week) {
			string = Math.floor(d/day)+' day';
			if(Math.floor(d/day)>1)
				string += 's';
		}
		else if(d<month) {
			string = Math.floor(d/week)+' week';
			if(Math.floor(d/week)>1)
				string += 's';
		}
		else if(d<year){
			string = Math.floor(d/month)+' month';
			if(Math.floor(d/month)>1)
				string += 's';
		}
		else {			
			string = Math.floor(d/year)+' year';
			if(Math.floor(d/year)>1)
				string += 's';
		}
		if(future)
			$(this).html(string+' from now');
		else
			$(this).html(string+' ago');
	});
}
function dateToString(timestamp) {
    var dys = new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
	var mns = new Array('Jaunary','February','March','April','May','June','July','August','September', 'October','November','December');
	var nd = new Date(timestamp*1000);
	var dt = nd.getDay();
	var fin = dys[dt];
	var daynumber = nd.getDate(); 
	if(daynumber==10 && daynumber==19)
		daynumber =  daynumber + 'th';
	else if( (daynumber % 10) == 1)
		daynumber =  daynumber + 'st';
	else if( (daynumber % 10) == 2)
		daynumber =  daynumber + 'nd';
	else if( (daynumber % 10) == 3)
		daynumber =  daynumber + 'rd';
	else
		daynumber = daynumber + 'th'; 
	fin = fin + ', '+ daynumber + ' '+mns[nd.getMonth()]+' '+nd.getFullYear();
	return fin;
}
var timeagoRefresh = setInterval('timeago', 500);
