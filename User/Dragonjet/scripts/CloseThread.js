(function($, ArticleComments, ClosedThreads){
	"use strict";
	console.log("Close Thread v0.6");
 
	function ExecCloseThreads(){
		$(ClosedThreads).each(function(index, comment_id){
console.log("Closing: "+comment_id);
			$("#comm-"+comment_id+" .article-comm-reply").hide();
		});
	}
 
	$(window).load(function(){
		if(ClosedThreads.length > 0){
			var realFunc = ArticleComments.addHover;
			ArticleComments.addHover = function () {
				var result = realFunc.apply(this, arguments);
				ExecCloseThreads();
				return result;
			};
		}
	});
 
}(jQuery, window.ArticleComments, window.CloseThread));