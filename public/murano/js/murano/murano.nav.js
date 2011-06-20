var megadrop = function ()
{
	var pub = {};
	var self = {};	
	
	pub.init = function ()
	{
		// Add the class hasSubNav to list items if they have a child
		// subNav element.
		$("#megadropdown li").each (function ()
		{
			var target = $(this);
			var child = target.children (".subNav");
						
			if (child.is (".subNav"))
			{
				target.addClass ("hasSubNav");
			}			
		});
		
		// Count the number of columns within the subNav and assign the
		// appropriate layout class
		$('#megadropdown .subNav').each ( function () 
		{
			var target = $(this);
			
			if ( !target.hasClass ('subNavCustomLayout') )
			{
				var columnCount = target.find ('.col').length;
				
				switch ( columnCount )
				{
					case 1:
						target.addClass ('oneCol');				
					break;
					
					case 2:
						target.addClass ('twoCol');
					break;
					
					case 3:
						target.addClass ('threeCol');
					break;
				}	
			}			
		});
		
		// Show and hide the nav items using Jquery Hover Intent
		// Stops the hover event from firing immediately
		$('#megadropdown li.hasSubNav').hoverIntent ({
			interval: 200, // milliseconds delay before onMouseOver
			over: self.showNav, 
			timeout: 250, // milliseconds delay before onMouseOut
			out: self.hideNav			
		});
	}
	
	// Show the subNav menu
	self.showNav = function ()
	{
		$(this).addClass ('hover');		
		$(this).find ('.subNav').show ();		
		return false;
	}
	
	// Hide the subNav menu
	self.hideNav = function ( $this )
	{
		var $this = $(this);		
		$this.find ('.subNav').slideUp ('fast' , function () { $this.removeClass ('hover') });				
		return false;
	}	
	
	return pub;
}();