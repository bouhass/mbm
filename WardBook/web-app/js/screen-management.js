function lockScreen() {
    $.cookie('locked', 'true');
    $('#unlocked').hide();
    $('#unlockedNavbar').hide();
    $('#locked').show();
    $('#lockedNavbar').show();
    $('#locked #password').focus();
}

function unlockScreen() {
    $.post(WEB_APP_ROOT+'helpers/authenticate', {
        password: $('#locked #password').val()
    })
        .done(function(patient) {
            $.removeCookie('locked');
            $('#locked').hide();
            $('#lockedNavbar').hide();
            $('#unlocked').show();
            $('#unlockedNavbar').show();
        })
        .fail(function() {
            $('.error-box').text('Sorry, password incorrect.');
        }).always(function() {
            $('#locked #password').val('');
        });
}

var idleTime = 0;

$(window).load(function () {
    $.cookie.raw = true;

    if ($.cookie('locked') == 'true') {
        lockScreen();
    }

    setInterval(timerIncrement, 60000); // 1 minute

    $(this).mousemove(function (e) {
        idleTime = 0;
        $.removeCookie('locked');
    });
    $(this).keypress(function (e) {
        idleTime = 0;
        $.removeCookie('locked');
    });
    $(this).click(function (e) {
        idleTime = 0;
        $.removeCookie('locked');
    });

    $('#locked #password').keyup(function (e) {
        if (e.keyCode == 13) {
            unlockScreen();
        }
    });

    $(window).keyup(function(e) {
        if (e.keyCode == 123) { // F12
            lockScreen();
        }
    });
});

function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime > 5) { // 5 minutes
        lockScreen();
    }
}
