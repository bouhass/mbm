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
        %{--<div class="second-level-nav navbar">--}%
            %{--<div class="second-level-nav navbar-inner">--}%
                %{--<ul class="nav navbar-nav">--}%
                    %{--<li <%= actionName == 'joblist' ? ' class="active"' : '' %>><g:link controller="board" action="joblist"> JOB LIST </g:link></li>--}%
                    %{--<li <%= actionName == 'handover' ? ' class="active"' : '' %>><g:link controller="board" action="handover"> HANDOVER </g:link></li>--}%
                %{--</ul>--}%

                %{--<div class="col-lg-2 input-group second-level-nav-item">--}%
                    %{--<span class="input-group-addon">--}%
                        %{--<span class="glyphicon glyphicon-search"></span>--}%
                    %{--</span>--}%
                    %{--<input id="search" type="text" class="form-control" placeholder="Search ...">--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%

		<g:layoutBody/>
	</body>
</html>
