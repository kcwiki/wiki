/**
 * Collapsible tables
 *
 * @version 2.0.2 (2014-03-14)
 * @source https://www.mediawiki.org/wiki/MediaWiki:Gadget-collapsibleTables.js
 * @author [[User:R. Koot]]
 * @author [[User:Krinkle]]
 * @deprecated Since MediaWiki 1.20: Use class="mw-collapsible" instead which
 * is supported in MediaWiki core.
 */
/*global $, mw */
var autoCollapse = 2;
var collapseCaption = 'hide';
var expandCaption = 'show';
 
function collapseTable( tableIndex ) {
	var Button = document.getElementById( 'collapseButton' + tableIndex );
	var Table = document.getElementById( 'collapsibleTable' + tableIndex );
 
	if ( !Table || !Button ) {
		return false;
	}
 
	var Rows = Table.rows;
	var i;
 
	if ( Button.firstChild.data === collapseCaption ) {
		for ( i = 1; i < Rows.length; i++ ) {
			Rows[i].style.display = 'none';
		}
		Button.firstChild.data = expandCaption;
	} else {
		for ( i = 1; i < Rows.length; i++ ) {
			Rows[i].style.display = Rows[0].style.display;
		}
		Button.firstChild.data = collapseCaption;
	}
}
 
function createClickHandler( tableIndex ) {
	return function ( e ) {
		e.preventDefault();
		collapseTable( tableIndex );
	};
}
 function createCollapseButtons()
{
    var tableIndex = 0;
    var NavigationBoxes = new Object();
    var Tables = document.getElementsByClassName(document, "table", "collapsible");
 
    for ( var i = 0; i < Tables.length; i++ ) {
            /* only add button and increment count if there is a header row to work with */
            var HeaderRow = Tables[i].getElementsByTagName( "tr" )[0];
            if (!HeaderRow) continue;
            var Header = HeaderRow.getElementsByTagName( "th" )[0];
            if (!Header) continue;
 
            NavigationBoxes[ tableIndex ] = Tables[i];
            Tables[i].setAttribute( "id", "collapsibleTable" + tableIndex );
 
            var Button     = document.createElement( "span" );
            var ButtonLink = document.createElement( "a" );
            var ButtonText = document.createTextNode( collapseCaption );
 
            Button.className = "collapseButton";  //Styles are declared in Common.css
 
            ButtonLink.style.color = Header.style.color;
            ButtonLink.setAttribute( "id", "collapseButton" + tableIndex );
            ButtonLink.setAttribute( "href", "javascript:collapseTable(" + tableIndex + ");" );
            ButtonLink.appendChild( ButtonText );
 
            Button.appendChild( document.createTextNode( "[" ) );
            Button.appendChild( ButtonLink );
            Button.appendChild( document.createTextNode( "]" ) );
 
            Header.insertBefore( Button, Header.childNodes[0] );
            tableIndex++;
    }
 
    var Tables = document.getElementsByClassName(document, "table", "collapsed");
    for ( var i = 0;  i < Tables.length; i++ ) {
        collapseTable( i );
    }
 
    var Tables = document.getElementsByClassName(document, "table", "autocollapse");
    for ( var i = 0;  i < Tables.length; i++ ) {
        if ( i >= autoCollapse ) {
            collapseTable( i );
        } 
    }   
}
mw.hook( 'wikipage.content' ).add( createCollapseButtons );