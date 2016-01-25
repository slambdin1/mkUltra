$(function () {

    $('#uncoverSecretsButton').click(function(e) {
        $('html, body').animate({
            scrollTop: $("#chapterSelection").offset().top
        }, 500);
    });

    var chapters = $('.chapter');
    var delay=250;
    var setTimeoutConst;

    for(var i = 0; i < chapters.length; i++) {
        $(chapters[i]).hover(function () {
            var chapter = this;
            setTimeoutConst = setTimeout(function(){
                $(chapter).children("video")[0].play();
            }, delay);
        }, function () {
            clearTimeout(setTimeoutConst);
            var el = $(this).children("video")[0];
            el.pause();
            el.currentTime = 0;
        });
    }

    

});