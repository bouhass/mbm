<%@ page import="org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes" %>
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

		<link rel="stylesheet" href="${resource(dir: 'css',  file: 'ward-book.css')}">
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
                    <li<%= request.forwardURI == "${createLink(uri: '/')}" ? ' class="active"' : '' %>><a href="${createLink(uri: '/')}">HOME</a></li>
                    <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                        <g:if test="${['Board', 'Patient', 'Task'].contains(c.name)}">
                            <li<%= c.logicalPropertyName == controllerName ? ' class="active"' : '' %>><g:link controller="${c.logicalPropertyName}">${c.name.toUpperCase()}</g:link></li>
                        </g:if>
                    </g:each>
                </ul>
                <a class="btn">
                    <span class="glyphicon glyphicon-bell"></span>
                </a>
                <a class="btn">
                    <span class="glyphicon glyphicon-comment"></span>
                </a>
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
        <script src="${resource(dir: 'js', file: 'ward-book.js')}"></script>
        <script src="${resource(dir: 'js', file: 'task.js')}"></script>

	</body>
</html>