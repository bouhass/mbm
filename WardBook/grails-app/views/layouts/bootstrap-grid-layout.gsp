<g:applyLayout name="bootstrap-navbar">

<head>
    <title><g:layoutTitle/></title>
    <g:layoutHead/>
    <style type="text/css" media="print">
        #patients-table {
            width: 100%;
        }

        #patients-table > tbody > tr > td {
            border: 1px solid #bbb;
        }

        nav,
        input,
        button,
        .hidden-print { /* TODO : this is a hack as bootstrap hidden-print is not working */
            display: none !important;
        }
    </style>
</head>

<body>
    <g:layoutBody/>
    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>
</body>

</g:applyLayout>
