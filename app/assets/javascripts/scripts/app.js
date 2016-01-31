// $( document ).ready(function() {
// 	
	// //Twitter Bootstrap Tooltip 				
	// $("[data-toggle='tooltip']").tooltip();
// 	
	// //Twitter Bootstrap Popover
	// $("[data-toggle='popover']").popover({trigger: "hover"});
// 		
// });

var ready = function() {
	
	//Twitter Bootstrap Tooltip 				
	$("[data-toggle='tooltip']").tooltip();
	
	//Twitter Bootstrap Popover
	$("[data-toggle='popover']").popover({trigger: "hover"});
		
};

$(document).ready(ready);
$(document).on('page:load', ready);


