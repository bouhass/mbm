<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
	<head>
		<meta name="layout" content="bootstrap"/>
		<title><g:layoutTitle/></title>
		<g:layoutHead/>
		<link rel="stylesheet" href="${resource(dir: 'bootstrap-editable/css', file: 'bootstrap-editable.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css',  file: 'ward-book-board.css')}">
        <style type="text/css" media="print">
        nav,
        input,
        button,
        .toolbar,
        #customizeView {
            display: none;
        }
        </style>
	</head>
	<body>
		<g:layoutBody/>
	</body>
</html>
