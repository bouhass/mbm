<g:applyLayout name="bootstrap">

<head>
    <title><g:layoutTitle/></title>
    <g:layoutHead/>
    <style>
    body {
        padding-top: 70px !important
    }
    </style>
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
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <%
                def navItems = [
                        [controller: 'patient', action: 'patientlist', title: 'Patient list'],
                        [controller: 'patient', action: 'joblist', title: 'Job list'],
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

    <script src="${resource(dir: 'js', file: 'moment.min.js')}"></script>
    <script>
        $(window).load(function() {
            $('#clock').text(moment().format('Do MMM HH:mm'));
            setInterval(function() {
                $('#clock').text(moment().format('Do MMM HH:mm'));
            }, 1000);
        });
    </script>

    <g:layoutBody/>

</body>

</g:applyLayout>
