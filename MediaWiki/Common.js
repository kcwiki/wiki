function filterTable(){
	$("table.filterable").each(function(){
		var i=0;
		var cols;
		$(this).find("tr:first-child th, tr:first-child td").each(function(){
			if (!$(this).hasClass("unfilterable")){
				cols=[];
				$(this).closest("table").find("tr td:nth-child("+(i+1)+")").each(function(){
					cols.push($(this).text());
				});
				cols = arrayUnique(cols);
				l=0;
				for (j=0; j<cols.length; j++){
					t=charLength(cols[j]);
					if (l<t) l=t;
				}
				$(this).css("position","relative");
				$(this).html('<a href="javascript:void(0)" class="showFilterMenu">'+$(this).html()+'▼</a>');
				$(this).append($('<div class="filterMenu hidden" style="position: absolute; top: '+$(this).height()+35+'px; left: 0; width: '+(50+l*7)+'px; text-align: left; padding: 5px; border: 1px #333333 solid; -moz-border-radius: 8px; -webkit-border-radius: 8px; border-radius: 8px; background: inherit; z-index: 1"></div>'));
				for (j=0; j<cols.length; j++){
					$(this).find(".filterMenu").append('<div><input type="checkbox" value="'+cols[j]+'" col="'+(i+1)+'" class="filterOption" checked>'+cols[j]+'</div>');
				}
			}
			i++;
		});
		$(this).find("tr:nth-child(n+1)").attr("condition", 0);
	});
	$(".showFilterMenu").click(function(){
		if ($(this).parent().find(".filterMenu:visible").length){
			$(".filterMenu").slideUp(150);
		}else{
			$(".filterMenu").slideUp(150);
			$(this).parent().find(".filterMenu").slideDown(150);
		}
	});
	$(document).mouseup(function(e){
		var container = $(".filterMenu");
	    if (!container.is(e.target) && container.has(e.target).length === 0){
	        container.slideUp(150);
	    }
	});
	$(".filterOption").click(function(){
		col=$(this).attr("col");
		val=$(this).val();
		if ($(this).is(":checked")) chg=1; else chg=-1;
		$(this).closest("table").find("tr:nth-child(n+1)").each(function(){
			if ($(this).find("td:nth-child("+col+")").text()==val){
				var cond=$(this).attr("condition");
				cond=Number(cond)+chg;
				$(this).attr("condition", cond);
				if (cond===0) $(this).show();
				else $(this).hide();
			}
		});
	});
}

function arrayUnique(a) {
    return a.reduce(function(p, c) {
        if (p.indexOf(c) < 0) p.push(c);
        return p;
    }, []);
}

function charLength(s){
	return s.length+(encodeURI(s).split(/%..|./).length-1-s.length)/2;
}

/**
 * Shows and hides content and picture (if available) of navigation bars
 * Parameters:
 *     indexNavigationBar: the index of navigation bar to be toggled
 **/
window.toggleNavigationBar = function ( indexNavigationBar, event ) {
    var NavToggle = document.getElementById( 'NavToggle' + indexNavigationBar );
    var NavFrame = document.getElementById( 'NavFrame' + indexNavigationBar );
    var NavChild;
 
    if ( !NavFrame || !NavToggle ) {
        return false;
    }
 
    /* if shown now */
    if ( NavToggle.firstChild.data === NavigationBarHide ) {
        for ( NavChild = NavFrame.firstChild; NavChild !== null; NavChild = NavChild.nextSibling ) {
            if ( $( NavChild ).hasClass( 'NavContent' ) || $( NavChild ).hasClass( 'NavPic' ) ) {
                NavChild.style.display = 'none';
            }
        }
    NavToggle.firstChild.data = NavigationBarShow;
 
    /* if hidden now */
    } else if ( NavToggle.firstChild.data === NavigationBarShow ) {
        for ( NavChild = NavFrame.firstChild; NavChild !== null; NavChild = NavChild.nextSibling ) {
            if ( $( NavChild ).hasClass( 'NavContent' ) || $( NavChild ).hasClass( 'NavPic' ) ) {
                NavChild.style.display = 'block';
            }
        }
        NavToggle.firstChild.data = NavigationBarHide;
    }
 
    event.preventDefault();
};
 
/* adds show/hide-button to navigation bars */
function createNavigationBarToggleButton( $content ) {
    var NavChild;
    /* iterate over all < div >-elements */
    var $divs = $content.find( 'div' );
    $divs.each( function ( i, NavFrame ) {
        /* if found a navigation bar */
        if ( $( NavFrame ).hasClass( 'NavFrame' ) ) {
 
            indexNavigationBar++;
            var NavToggle = document.createElement( 'a' );
            NavToggle.className = 'NavToggle';
            NavToggle.setAttribute( 'id', 'NavToggle' + indexNavigationBar );
            NavToggle.setAttribute( 'href', '#' );
            $( NavToggle ).on( 'click', $.proxy( window.toggleNavigationBar, window, indexNavigationBar ) );
 
            var isCollapsed = $( NavFrame ).hasClass( 'collapsed' );
            /**
             * Check if any children are already hidden.  This loop is here for backwards compatibility:
             * the old way of making NavFrames start out collapsed was to manually add style="display:none"
             * to all the NavPic/NavContent elements.  Since this was bad for accessibility (no way to make
             * the content visible without JavaScript support), the new recommended way is to add the class
             * "collapsed" to the NavFrame itself, just like with collapsible tables.
             */
            for ( NavChild = NavFrame.firstChild; NavChild !== null && !isCollapsed; NavChild = NavChild.nextSibling ) {
                if ( $( NavChild ).hasClass( 'NavPic' ) || $( NavChild ).hasClass( 'NavContent' ) ) {
                    if ( NavChild.style.display === 'none' ) {
                        isCollapsed = true;
                    }
                }
            }
            if ( isCollapsed ) {
                for ( NavChild = NavFrame.firstChild; NavChild !== null; NavChild = NavChild.nextSibling ) {
                    if ( $( NavChild ).hasClass( 'NavPic' ) || $( NavChild ).hasClass( 'NavContent' ) ) {
                        NavChild.style.display = 'none';
                    }
                }
            }
            var NavToggleText = document.createTextNode( isCollapsed ? NavigationBarShow : NavigationBarHide );
            NavToggle.appendChild( NavToggleText );
 
            /* Find the NavHead and attach the toggle link (Must be this complicated because Moz's firstChild handling is borked) */
            for( var j = 0; j < NavFrame.childNodes.length; j++ ) {
                if ( $( NavFrame.childNodes[j] ).hasClass( 'NavHead' ) ) {
                    NavToggle.style.color = NavFrame.childNodes[j].style.color;
                    NavFrame.childNodes[j].appendChild( NavToggle );
                }
            }
            NavFrame.setAttribute( 'id', 'NavFrame' + indexNavigationBar );
        }
    } );
}
 
mw.hook( 'wikipage.content' ).add( createNavigationBarToggleButton );

// Fix Table Header
var TableHeadFix = function () {
    var obj, $table, $newtable, $win;
    obj = this;
 
    this.clonehead = function () {
        $newtable = $table.clone();
        $newtable.find('tr:gt(0)').remove();
 
        $newtable.css('top', '0');
        $newtable.css('position', 'fixed');
        // Fixed by kk @ 2015-04-03
        $newtable.css('margin-top', '0');
        $newtable.hide();
    };
 
 
    this.check = function () {
        if($table.size() === 0){
             return;
        }
        var scrollTop = $win.scrollTop();
        var start_offset = $table.offset();
        if (scrollTop > start_offset.top && scrollTop <= (start_offset.top + $table.height())) {
            $newtable.show();
        } else {
            $newtable.hide();
        }
    };
 
    this.event = function () {
        $win.bind('scroll', obj.check);
    };
 
    this.init = function (obj) {
        $win = $(window);
        $table = $(obj);
        this.clonehead();
        $table.after($newtable);
 
        this.event();
        this.check();
    };
};

$(function() {

	// Extension:SoundManager2Button
	// TODO: initialize properly so this isn't needed
	if (window.soundManager && window.soundManager.beginDelayedInit && !window.soundManager.enabled) {
		console.debug('KLUDGE: calling window.soundManager.beginDelayedInit()');
		window.soundManager.beginDelayedInit();
	}

	// Table things

    $(".showExtra").click(function() {
    	$(this).closest("table").find(".extraRow").fadeIn("slow");$(this).closest("tr").remove();
    });

    filterTable();

    $('.fixtable').each(function(){
    	var tableHeadFix = new TableHeadFix();
    	tableHeadFix.init(this);
    });

    // Template:Map/ImageNode

    function supportTemplateMapImageNode() {
    	$('.map-node a').off('click');
    	$('.map-node a').click(function (e) {
        	e.preventDefault();
    		var $element = $($(this).attr('href'));
    		var $container = $element.parent();
    		$container.scrollTop($container.scrollTop() - $container.offset().top + $element.offset().top);
    	});
	}
	supportTemplateMapImageNode();
	mw.hook('wikipage.content').add(supportTemplateMapImageNode);

});