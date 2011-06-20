$('document').ready ( function () {

	var noOfColors = $('link.styleswitch').length;
	
	$('#topMenu .left').append ('<div id="themeTrigger">' + noOfColors + ' Theme Colors</div>');

	$('#topMenu').hoverIntent ({
		interval: 50, // milliseconds delay before onMouseOver
		over: function () 
		{ 
			var $to = $(this).find ('#theme-options');
						// 
						// if ( $to.is (":visible") )
						// 	return false;
				
			$to.fadeIn ('medium');
			$('#themeTrigger').fadeOut ();
			
			return false;
		}, 
		timeout: 1250, // milliseconds delay before onMouseOut
		out: function () 
		{ 
			var $to = $(this).find ('#theme-options');				
			$to.fadeOut ('fast');
			$('#themeTrigger').fadeIn ();
		}			
	});
		

});


/**
* Stylesheet toggle variation on styleswitch stylesheet switcher.
* Built on jQuery.
* Under an CC Attribution, Share Alike License.
* By Kelvin Luck ( http://www.kelvinluck.com/ )
**/

(function($)
	{
		// Local vars for toggle
		var availableStylesheets = [];
		var activeStylesheetIndex = 0;
		
		// To loop through available stylesheets
		$.stylesheetToggle = function()
		{
			activeStylesheetIndex ++;
			activeStylesheetIndex %= availableStylesheets.length;
			$.stylesheetSwitch(availableStylesheets[activeStylesheetIndex]);
		};
		
		// To switch to a specific named stylesheet
		$.stylesheetSwitch = function(styleName)
		{
			$('link').each(
				function(i) 
				{
					this.disabled = true;
					if ($(this).attr ('id') == styleName) {
						console.log ( styleName )
						this.disabled = false;
						//activeStylesheetIndex = i;
					}
					
					
					if ( $(this).attr ('class') != 'styleswitch' )
					{
						this.disabled = false;
					}
					
					
					//console.log ('-----------------------------------------------------')
				}
			);
			createCookie('style', styleName, 365);
		};
		
		// To initialise the stylesheet with it's 
		$.stylesheetInit = function( defaultColor )
		{
			// $('link[rel*=style][title]').each(
			// 	function(i) 
			// 	{
			// 		availableStylesheets.push(this.getAttribute('title'));
			// 	}
			// );
			var c = readCookie('style');
			if (c) {
				$.stylesheetSwitch(c);
			}
			else
			{
				$.stylesheetSwitch ( defaultColor );
			}
		};
	}
)(jQuery);



// cookie functions http://www.quirksmode.org/js/cookies.html
function createCookie(name,value,days)
{
	if (days)
	{
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}
function readCookie(name)
{
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++)
	{
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}
function eraseCookie(name)
{
	createCookie(name,"",-1);
}
// /cookie functions