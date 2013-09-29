$(document).ready(function() {
  if (navigator.geolocation != null) {
  	$('.geo').on('click', function() {
      var field = $(this).attr('data-field');
      navigator.geolocation.getCurrentPosition(function(position) {
	      $.ajax({
		      type     : 'GET',
		      dataType : 'jsonp',
		      url      : '/locations.json',
		      data     : 'lat='+position.coords.latitude+'&lng='+position.coords.longitude,
		      success  : 
		        function(data) {
		          $('#'+field).val(data[0].name);
		        } 
	     });
      }, function(e) {
      	alert(e.message);
      });
    });
  }
  else {
  	$('.geo').hide();
  }
});