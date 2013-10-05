<%@ page import="com.wardbook.Ward; org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes" %>
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

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->

    <r:require modules="scaffolding"/>
    <r:require modules="typeahead-js"/>
    <r:require modules="typeahead-bootstrap-css"/>

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

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
            <g:img dir="images" file="mbm-logo.png" width="20" height="20"/>
            %{--<g:meta name="app.name"/>--}%
        </a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse navbar-ex1-collapse">
        <%
            def navItems = [
                    [controller: 'dashboard', action: 'index', title: 'Dashboard'],
                    [controller: 'board', action: 'joblist', title: 'Job list'],
                    [controller: 'board', action: 'handover', title: 'Patient info'],
                    [controller: 'patient', action: 'overview', title: 'Base ward'],
                    [controller: 'patient', action: 'mylist', title: 'My patients'],
                    [controller: 'task', action: 'mylist', title: 'My tasks']
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
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Select ward <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <g:each in="${Ward.list()}" var="ward">
                        <li><a href="#">${ward}</a></li>
                    </g:each>
                </ul>
            </li>
            <li>
                <a class="btn">
                    <span class="glyphicon glyphicon-bell"></span>
                </a>
            </li>
            <li>
                <a class="btn">
                    <span class="glyphicon glyphicon-comment"></span>
                </a>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><sec:loggedInUserInfo field="username"/> <b
                        class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="#"><span class="glyphicon glyphicon-user"></span> My profile</a></li>
                    <li role="presentation" class="divider"></li>
                    <li><a href="${createLink(uri: '/logout')}"><span class="glyphicon glyphicon-log-out"></span> Logout
                    </a></li>
                </ul>
            </li>
        </ul>

        <div class="col-sm-2 col-md-2 pull-right">
            <form class="navbar-form" role="search">
                <g:if test="${controllerName == 'board'}">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search" name="search" id="search">

                        <div class="input-group-btn">
                            <button class="btn btn-default">
                                <span class="glyphicon glyphicon-search"></span>
                            </button>
                        </div>
                    </div>
                </g:if>
            </form>
        </div>

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
</script>

<r:layoutResources/>

<script src="${resource(dir: 'bootstrap-editable/js', file: 'bootstrap-editable.js')}"></script>
<script src="${resource(dir: 'moment', file: 'moment.min.js')}"></script>
<script src="${resource(dir: 'js', file: 'ward-book.js')}"></script>
<script src="${resource(dir: 'js', file: 'task.js')}"></script>

</body>
</html>