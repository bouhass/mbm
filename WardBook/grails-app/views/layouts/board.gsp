<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
	<head>
		<meta name="layout" content="bootstrap"/>
		<title><g:layoutTitle/></title>
		<g:layoutHead/>
		<link rel="stylesheet" href="${resource(dir: 'bootstrap-editable/css', file: 'bootstrap-editable.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css',  file: 'ward-book-board.css')}">
	</head>
	<body>
		<div class="second-level-nav navbar">
			<div class="second-level-nav navbar-inner">
				<ul class="nav">
					<li <%= actionName == 'ward' ? ' class="active"' : '' %>><g:link controller="board" action="ward"> WARD </g:link></li>
					<li <%= actionName == 'handover' ? ' class="active"' : '' %>><g:link controller="board" action="handover"> HANDOVER </g:link></li>
				</ul>

                <div class="second-level-nav-item input-prepend">
                    <span class="add-on">
                        <i class="icon-search"></i>
                    </span>
                    <input id="search" type="text" class="span3" placeholder="Search ...">
                </div>

                <g:if test="${actionName == 'handover'}">
                    <div id="columns-selector" class="second-level-nav-item btn-group" data-toggle="buttons-checkbox">
                        <button type="button" class="btn btn-info active" value="HISTORY">HISTORY</button>
                        <button type="button" class="btn btn-info active" value="PROBLEM">PROBLEMS</button>
                        <button type="button" class="btn btn-info active" value="ALERT">ALERTS</button>
                        <button type="button" class="btn btn-info active" value="PROGRESS">PROGRESS</button>
                        <button type="button" class="btn btn-info active" value="JOBS">JOBS</button>
                    </div>
                </g:if>
            </div>
		</div>

		<g:layoutBody/>
	</body>
</html>
