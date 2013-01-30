if (jQuery) {  
	$(document).ready(function () {
		if (jQuery().setmaxlength) {
			//this sets the maximum limit of the text area to 200
			//this uses the plugin textarea.maxlength
			$(".max-length-200").setmaxlength(200);
		}

		//SET TextAreaExpander, similar to Facebook's comment text entry
        if (jQuery().TextAreaExpander) {
            $("textarea.text-expand").TextAreaExpander({ 'minHeight': 17, 'maxHeight': 100 });
        }

        $('form').each(function(){
            $(this).validate();
        });

        var timer=null;
        var isBlurred = false;
        var pageRefreshTimer = 120;
        var refreshCounter = 0;

        window.onBlur = function(){
        	isBlurred = true;

        }

        window.onfocus = function(){
        	isBlurred = false;
        }

        window.setInterval(function (a, b) {
        	refreshCounter += 1;

        	if(refreshCounter < pageRefreshTimer)
        	{
// should check a flag which is triggered by cookies or driven by the database to make sure the view has new messages
        	}
        	else
        		window.location.reload();

        	
        }, 1000);
	});
}