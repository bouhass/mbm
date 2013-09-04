<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="bootstrap"/>
		<title><g:layoutTitle/></title>
		<g:layoutHead/>
		<link rel="stylesheet" href="${resource(dir: 'bootstrap-editable/css', file: 'bootstrap-editable.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css',  file: 'smart-ward-board.css')}">
	</head>
	<body>
		<div class="second-level-nav navbar">
			<div class="second-level-nav navbar-inner">
				<ul class="nav">
					<li <%= actionName == 'ward' ? ' class="active"' : '' %>><g:link controller="board" action="ward"> WARD </g:link></li>
					<li <%= actionName == 'handover' ? ' class="active"' : '' %>><g:link controller="board" action="handover"> HANDOVER </g:link></li>
				</ul>
			</div>
		</div>
		
		<g:layoutBody/>
	</body>
</html>
