/**
 * Scrolling text
 *
 * Original from touhouwiki
 */

window.AutoScroll = function(objNotice) {
    $(objNotice).find("ul:first").animate(
    	{
    		marginTop:"-25px"
    	},
    	500,
    	function(){
    	    $(this).css({marginTop: "0px"}).find("li:first").appendTo(this);
    	}
    )
}

$(function() {
    setInterval('AutoScroll("#scrollDiv")',10000);
    //image loading effect
    $('img').on('load', function(e){
         var target = $(this);
         target.css('opacity', 0).animate({opacity: 1}, 1000);
   })
})