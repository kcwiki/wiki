(function($){
	"use strict";
	console.log("Sidebar Boxes v0.5");
	
	$(window).load(function(){
		if($("div.move").length > 0){
			$("div.move").prependTo("#WikiaRail");
			$("div.move").show();
		}
	});

}(jQuery));