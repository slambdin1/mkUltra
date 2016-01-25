$(function () {

    var years = $('.nav-container');
    var delay=250;
    var setTimeoutConst;

    for(var i = 0; i < years.length; i++) {
        $(years[i]).hover(function () {
            var year = this;
            setTimeoutConst = setTimeout(function(){
                $($(year).children(".preview-container")[0]).children("video")[0].play();
            }, delay);
        }, function () {
            clearTimeout(setTimeoutConst);
            var el = $($(this).children(".preview-container")[0]).children("video")[0];
            el.pause();
            el.currentTime = 0;
        });
    }

    

});