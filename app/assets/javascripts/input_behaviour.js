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
	});
}