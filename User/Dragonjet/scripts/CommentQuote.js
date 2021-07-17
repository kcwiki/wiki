(function($, ArticleComments){
	"use strict";
	console.log("Comment Quotes v0.4");
	
	function AddButtons(){
		$("#article-comments-ul .comment").each(function(){
			$(".tools", this).prepend('<a href="#article-comments" class="quoteBtn actionButton" data-id="'+$(this).attr("id")+'">Quote</a>');
		});
		
		$(".quoteBtn").on("click", function(){
			var origMsg = $(".article-comm-text", $("#"+$(this).data("id"))).text();
			$("textarea#article-comm").val("> ''"+origMsg.trim()+"''");
			return true;
		});
		
	}
	
	$(window).load(function(){
		
		if(ArticleComments){
			var realFunc = ArticleComments.addHover;
			ArticleComments.addHover = function () {
				var result = realFunc.apply(this, arguments);
				AddButtons();
				return result;
			};
		}
	});

}(jQuery, window.ArticleComments));