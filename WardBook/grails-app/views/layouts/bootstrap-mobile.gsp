<g:applyLayout name="bootstrap">

<head>
    <title><g:layoutTitle/></title>
    <g:layoutHead/>
    <style>
    body {
        padding-top: 50px !important
    }
    </style>
</head>

<body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <ul class="nav navbar-nav">
            <li>
                <a>
                    %{--<div class="pull-left">--}%
                        <span class="glyphicon glyphicon-list" />
                    %{--</div>--}%
                </a>
            </li>
            <li>
                <a>
                    %{--<div class="pull-right">--}%
                        <span class="glyphicon glyphicon-search" />
                    %{--</div>--}%
                </a>
            </li>
        </ul>
    </nav>

    <g:layoutBody/>
</body>

</g:applyLayout>
