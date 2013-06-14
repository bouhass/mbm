<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		
		
		<link rel="stylesheet" href="${resource(dir: 'bootstrap/css', file: 'bootstrap.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css',  file: 'flat-ui.css')}">
		<link rel="stylesheet" href="${resource(dir: 'bootstrap-editable/css', file: 'bootstrap-editable.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css',  file: 'smart-ward.css')}"> 
		
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body>
	
		<div id="header">
			<div class="first-level-nav navbar navbar-inverse">
				<div class="first-level-nav navbar-inner">
					<ul class="nav">
						<li><g:link controller="home"> HOME </g:link></li>
						<li><g:link controller="board">BOARD</g:link></li>
						<li><g:link controller="patient">PATIENTS</g:link></li>
						<li><g:link controller="task">TASKS</g:link></li>
					</ul>
				</div>
			</div>
		</div>
		
		<g:layoutBody/>
		
		<div id="footer">
			<footer>
				<div class="copyright">
					Copyright © SmartWard 2013
				</div>
			</footer>
		</div>
		
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>
