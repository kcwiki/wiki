/*global mw, $, importScript */

// Add "mainpage" class to the body element
if (
	mw.config.get( 'wgIsMainPage' ) &&
	mw.config.get( 'wgAction' ) === 'view'
) {
	$( function() {
		document.body.className += ' mainpage';
	});
}

/* End of extra pages */

/**
 * Hide prefix in category
 *
 * @source www.mediawiki.org/wiki/Snippets/Hide_prefix_in_category
 * @rev 5
 */

var prefix = $.trim( $( '#mw-cat-hideprefix' ).text() ) || ( mw.config.get( 'wgTitle' ) + '/' );
$( '#mw-pages' ).find( 'a' ).text( function ( i, val ) {
    return val.slice( 0, prefix.length ) === prefix ? val.slice( prefix.length ) : val;
} );

/**
 * Load the CodeReview 'tooltips' gadget on [[MediaWiki roadmap]] subpages,
 * so it's available for the revision reports where it's particularly useful
 * @author: Happy-melon
 */
if ( mw.config.get( 'wgPageName' ).match( /^MediaWiki_roadmap/ ) ) {
	mw.loader.load( 'ext.codereview.tooltips' );
}

/**
 * @source https://www.mediawiki.org/wiki/Snippets/Load_JS_and_CSS_by_URL
 * @revision 2017-05-16
 */
mw.loader.using( ['mediawiki.util', 'mediawiki.notify'], function () {
	var extraCSS = mw.util.getParamValue( 'withCSS' ),
		extraJS = mw.util.getParamValue( 'withJS' ),
		extraModule = mw.util.getParamValue( 'withModule' );

	if ( extraCSS ) {
		// WARNING: DO NOT REMOVE THIS "IF" - REQUIRED FOR SECURITY (against XSS/CSRF attacks)
		if ( /^MediaWiki:[^&<>=%#]*\.css$/.test( extraCSS ) ) {
			mw.loader.load( '/w/index.php?title=' + encodeURIComponent( extraCSS ) + '&action=raw&ctype=text/css', 'text/css' );
		} else {
			mw.notify( 'Only pages from the MediaWiki namespace are allowed.', { title: 'Invalid withCSS value' } );
		}
	}

	if ( extraJS ) {
		// WARNING: DO NOT REMOVE THIS "IF" - REQUIRED FOR SECURITY (against XSS/CSRF attacks)
		if ( /^MediaWiki:[^&<>=%#]*\.js$/.test( extraJS ) ) {
			mw.loader.load( '/w/index.php?title=' + encodeURIComponent( extraJS ) + '&action=raw&ctype=text/javascript' );
		} else {
			mw.notify( 'Only pages from the MediaWiki namespace are allowed.', { title: 'Invalid withJS value' } );
		}
	}

	if ( extraModule ) {
		if ( /^ext\.gadget\.[^,\|]+$/.test( extraModule ) ) {
			mw.loader.load( extraModule );
		} else {
			mw.notify( 'Only gadget modules are allowed.', { title: 'Invalid withModule value' } );
		}
	}
});

/**
 * Hide specified prefixen
 *
 * @rev: 1
 * @author: MZMcBride
 */
$( function () {
	$('.hide-prefix').find('li a').text( function( i, val ) { return val.replace($('.hide-prefix').data('prefix'), '') } );
});