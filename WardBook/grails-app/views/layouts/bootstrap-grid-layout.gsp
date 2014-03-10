<g:applyLayout name="bootstrap-navbar">

<head>
    <title><g:layoutTitle/></title>
    <g:layoutHead/>

    %{--<link rel='stylesheet' media='print' href='css/print-view.css' />--}%

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


        .print-mode {
            font-size: 11px;
        }

        .print-mode th {
             text-align: left;
        }

        .print-mode td {
            padding: 2px;
            width: auto !important;
        }

        .print-mode .inner-table td {
            line-height: 16px;
        }

        .print-mode textarea {
            display: none;
        }

        .print-mode .delete-record{
            display: none;
        }

        .print-mode .patient-info td:first-child{
            border:none;
        }

    </style>
</head>

<body>
    <g:layoutBody/>
    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>
</body>

</g:applyLayout>
