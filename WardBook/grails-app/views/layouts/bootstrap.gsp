<%@ page import="com.wardbook.User; com.wardbook.Ward; org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="${meta(name: 'app.name')}"/></title>
    <meta name="description" content="">
    <meta name="author" content="">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="format-detection" content="telephone=no">

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->

    <r:require modules="scaffolding"/>
    <r:require modules="typeahead-js"/>
    <r:require modules="typeahead-bootstrap-css"/>

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'mbm-logo.png')}">
    <link rel="apple-touch-icon" sizes="240x240" href="${resource(dir: 'images', file: 'mbm-logo.png')}">

    <g:layoutHead/>
    <r:layoutResources/>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ward-book.css')}">
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="${createLink(uri: '/')}">
            <g:img dir="images" file="mbm-logo.png" width="45" height="45"/>
            %{--<g:meta name="app.name"/>--}%
        </a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse navbar-ex1-collapse">
        <%
            def navItems = [
                    [controller: 'board', action: 'handover', title: 'Patient list'],
                    [controller: 'board', action: 'joblist', title: 'Job list'],
//                    [controller: 'patient', action: 'overview', title: 'Base ward'],
//                    [controller: 'patient', action: 'mylist', title: 'My patients'],
                    [controller: 'task', action: 'mylist', title: 'My tasks'],
                    [controller: 'staff', action: 'list', title: 'Staff'],
                    [controller: 'dashboard', action: 'index', title: '<span class="glyphicon glyphicon-stats"></span>']
            ]
        %>
        <ul class="nav navbar-nav">
            <g:each in="${navItems}" var="navItem">
                <li<%=((controllerName == navItem.controller) && (actionName == navItem.action)) ? ' class="active"' : ''%>>
                    <g:link controller="${navItem.controller}" action="${navItem.action}">${navItem.title}</g:link>
                </li>
            </g:each>
        </ul>

        <ul class="nav navbar-nav navbar-right">
            <li>
                <a id="clock"></a>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">${request.user.ward?.name ?: 'All wards'}<b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="#" onclick="switchWard('')">All wards</a></li>
                    <g:each in="${Ward.list()}" var="ward">
                        <li><a href="#" onclick="switchWard(${ward.id})">${ward.name}</a></li>
                    </g:each>
                </ul>
            </li>
            %{--<li>--}%
                %{--<a class="btn">--}%
                    %{--<span class="glyphicon glyphicon-bell"></span>--}%
                %{--</a>--}%
            %{--</li>--}%
            %{--<li>--}%
                %{--<a class="btn">--}%
                    %{--<span class="glyphicon glyphicon-comment"></span>--}%
                %{--</a>--}%
            %{--</li>--}%
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-user"></span><b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a>
                            <sec:loggedInUserInfo field="username"/>
                        </a>
                    </li>
                    <li role="presentation" class="divider"></li>
                    <li>
                        <a href="#"><span class="glyphicon glyphicon-user"></span> My profile</a>
                    </li>
                    <li role="presentation" class="divider"></li>
                    <li>
                        <g:if test="${request.user.onCall}">
                            <a href="#" onclick="userOnCall(false)"><span class="glyphicon glyphicon-minus"></span> Leave On Call</a>
                        </g:if>
                        <g:if test="${!request.user.onCall}">
                            <a href="#" onclick="userOnCall(true)"><span class="glyphicon glyphicon-earphone"></span> On Call</a>
                        </g:if>
                    </li>
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <li role="presentation" class="divider"></li>
                        <li>
                            <a href="${createLink(controller: 'user')}"><span class="glyphicon glyphicon-cog"></span> Admin </a>
                        </li>
                    </sec:ifAllGranted>
                    <li role="presentation" class="divider"></li>
                    <li>
                        <a href="${createLink(uri: '/logout')}"><span class="glyphicon glyphicon-log-out"></span> Logout </a>
                    </li>
                </ul>
            </li>
        </ul>

    </div><!-- /.navbar-collapse -->
</nav>

<div class="container-fluid">
    <g:layoutBody/>

    %{--<footer>--}%
    %{--<p>&copy; <g:meta name="app.name"/> 2013</p>--}%
    %{--</footer>--}%
</div>

<script>
    WEB_APP_ROOT = '${createLink(uri: '/')}'

    $(window).load(function() {
        $('#clock').text(moment().format('Do MMM HH:mm'));
        setInterval(function() {
            $('#clock').text(moment().format('Do MMM HH:mm'));
        }, 1000);
    });

    $(document).ajaxError(function(e, xhr, settings, exception) {
        if(xhr.status==401) {
            window.location.reload();
        }
    });
</script>

<r:layoutResources/>

<script src="${resource(dir: 'bootstrap-editable/js', file: 'bootstrap-editable.js')}"></script>
<script src="${resource(dir: 'js', file: 'moment.min.js')}"></script>
<script src="${resource(dir: 'js', file: 'ward-book.js')}"></script>
<script src="${resource(dir: 'js', file: 'task.js')}"></script>

</body>
</html>