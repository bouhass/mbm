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
		<g:layoutBody/>

        <script>
        $(window).load(function() {
            $('#search').keyup(patientTableSearch);
        });
        </script>
	</body>
</html>
