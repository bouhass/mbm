<!doctype html>
<html>
<head>
    <title><g:meta name="app.name"/></title>
    <meta name="layout" content="bootstrap-plain"/>
</head>

<body>

<nav class="navbar navbar-default" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="${createLink(uri: '/')}">
            <g:img dir="images" file="mbm-logo.png" width="40" height="40"/>
            %{--<g:meta name="app.name"/>--}%
        </a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="first-level-nav collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav">
            <li>
                <a>
                    LOG IN
                </a>
            </li>
        </ul>
    </div>
</nav>

<div class="col-md-4 col-md-offset-4" style="position: absolute; top: 20%; padding: 50px; border: 1px solid #aaa;">

    <g:img dir="images" file="login_avatar.png" style="margin-left: auto; margin-right: auto; display: block" />

    <br>

    <g:if test='${flash.message}'>
        <div class='login_message'>${flash.message}</div>
    </g:if>

    <form action='${postUrl}' method='POST' id='loginForm'>

        <div class="form-group">
            <input type="email" class="form-control" name="j_username" id="username" placeholder="Type your NHS.NET email address" />
        </div>

        <div class="form-group">
            <input type="password" class="form-control" name="j_password" id="password" placeholder="Type your password" />
        </div>

        <div class="checkbox">
            <label>
                <input type="checkbox"> I AM ON-CALL
            </label>
        </div>

        %{--<p id="remember_me_holder">--}%
        %{--<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>--}%
        %{--<label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>--}%
        %{--</p>--}%

        <button type="submit" class="btn btn-default pull-right">Log in ></button>

    </form>
</div>

<script type='text/javascript'>
    <!--
    (function() {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
    // -->
</script>

</body>
</html>
