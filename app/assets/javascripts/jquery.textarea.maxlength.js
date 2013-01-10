(function($) {
 
   $.fn.setmaxlength = function(limit) { 
     //set the default plugin state
     var state = $.extend({}, $.fn.setmaxlength.state);
    
     this.each(function() {
        // is a textarea?
        if (this.nodeName.toLowerCase() != "textarea" && this.nodeName.toLowerCase() != "input") return;
        
        $this = $(this);
        
        //bind to the each object the default plugin state
        $this.extend(state);
        
        $this.keydown(function(event){          
            var key = event.which;
                        
            //all keys including return.  
            //if(key >= 33 || key == 13) {  
                var maxLength = (limit == null) ? $(this).attr("textlimit") : limit;
                var length = this.value.length;
                //alert(key);
                if(!$this.isSelected)
                {
                    if(length >= maxLength && key > 46) //removed the >= to allow delete key to work
                    {
                        event.preventDefault();
                    }
                    else if(length >= maxLength && key == 32)
                        event.preventDefault();
                }
            //}  
            //set selected flag to false after keydown
            $this.isSelected = false;
        })
        .select(function(){
            $this.isSelected = true;
        });
     });
         
    $.fn.setmaxlength.state = {
        isSelected: false
    }
    
     return this; 
};
 
 })(jQuery);
