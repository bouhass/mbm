<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="${meta(name: 'app.name')}"/></title>
    <meta name="description" content="">
    <meta name="author" content="">

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

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

    <link rel="stylesheet" href="${resource(dir: 'bootstrap-editable/css', file: 'bootstrap-editable.css')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ward-book.css')}">
</head>

<body>

<div class="container">
    <g:layoutBody/>
</div>

<script>
    WEB_APP_ROOT = '${createLink(uri: '/')}'

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

</body>

</html>