<!doctype html>
<html>
<head>
    <title><g:meta name="app.name"/></title>
    <meta name="layout" content="bootstrap"/>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div style="color: white; text-align: center;">
        <h3>WardBook</h3>
    </div>
</nav>

<div class="col-xs-10 col-sm-6 col-md-4 col-xs-offset-1 col-sm-offset-3 col-md-offset-4 box-middle">

    <g:if test='${flash.message}'>
        <div class='error-box'>${flash.message}</div>
    </g:if>

    <form action='${postUrl}' method='POST' id='loginForm'>

        <div class="form-group">
            <input type="email" class="form-control" name="j_username" id="username" placeholder="NHS.NET email address" />
        </div>

        <div class="form-group">
            <input type="password" class="form-control" name="j_password" id="password" placeholder="Password" />
        </div>

        %{--<p id="remember_me_holder">--}%
        %{--<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>--}%
        %{--<label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>--}%
        %{--</p>--}%

        <button type="submit" class="btn btn-primary btn-block btn-lg pull-right">
            Login
            &nbsp;
            <span class="glyphicon glyphicon-log-in"></span>
        </button>

    </form>
</div>

<script type='text/javascript'>
    (function() {
        document.forms['loginForm'].elements['j_username'].focus();
    })();

    $(window).load(function () {
        // in case screen locked, then session expires, to avoid used logging in only to find the screen locked
        localStorage['locked'] = '';
    });
</script>

</body>
</html>