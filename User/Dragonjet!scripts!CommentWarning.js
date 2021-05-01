(function($, ArticleComments){
	"use strict";
	console.log("Comment Warning v0.5");
	
	$(window).load(function(){
		if(ArticleComments){
			var realFunc = ArticleComments.init;
			ArticleComments.init= function () {
				var result = realFunc.apply(this, arguments);
				$(".kcCommentWarning").prependTo("#article-comments");
				$(".kcCommentWarning").show();
				return result;
			};
		}	
	});
 
}(jQuery, window.ArticleComments));