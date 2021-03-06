﻿(function ($) {

    var methods = {
        init: function (options) {
            var settings = $.extend({
                'minHeight': 17,
                'maxHeight': 99999
            }, options);

            return this.each(function () {

                // is a textarea?
                if (this.nodeName.toLowerCase() != "textarea") return;

                // set height restrictions
                var p = this.className.match(/expand(\d+)\-*(\d+)*/i);
                //this.expandMin = minHeight || (p ? parseInt('0' + p[1], 10) : 0);
                //this.expandMax = maxHeight || (p ? parseInt('0' + p[2], 10) : 99999);
                this.expandMin = settings.minHeight;
                this.expandMax = settings.maxHeight;

                // initial resize
                ResizeTextarea(this);

                // add events
                if (!this.Initialized) {
                    this.Initialized = true;
                    $(this).css("padding-top", 0).css("padding-bottom", 0);
                    $(this).bind("keyup", ResizeTextarea).bind("focus", ResizeTextarea);
                }
            });

        },
        resize: function () {
            $(this).keyup();
        }
    };

    // jQuery plugin definition
    $.fn.TextAreaExpander = function (method) {

        // initialize
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.tooltip');
        }
    };

    // resize a textarea
    function ResizeTextarea(e) {

        // event or element?
        e = e.target || e;

        // find content length and box width
        var vlen = e.value.length, ewidth = e.offsetWidth;
        if (vlen != e.valLength || ewidth != e.boxWidth) {

            //if (hCheck && (vlen < e.valLength || ewidth != e.boxWidth)) e.style.height = "0px";
            var h = Math.max(e.expandMin, Math.min(e.scrollHeight, e.expandMax));

            e.style.overflow = (e.scrollHeight > h ? "auto" : "hidden");
            e.style.height = h + "px";

            e.valLength = vlen;
            e.boxWidth = ewidth;
        }

        return true;
    };


})(jQuery);
