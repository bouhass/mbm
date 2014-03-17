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
            font-size: 10px;
        }

        .print-mode th {
             text-align: left;
        }

        .print-mode td {
            padding: 2px;
            width: auto !important;
            vertical-align: top;
        }

        .patient-info tr td {
            padding-bottom: 0;
        }

        .print-mode .inner-table td {
            line-height: 12px;
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

        .WEIGHT {
            display: none;
        }

        .input-tr  {
            display: none;
        }

        .DEMOGRAPHICS {
            min-width: 250px;
        }

        .editable, a {
            text-decoration: none;
            border-bottom: none !important;
            color: black;
        }

        img {
            max-height: 12px;
        }

        #patients-table {
            position: absolute;
            top: 0;
            left: 0;
        }

        .patient-info tr {
            display: inline;
        }

        .patient-info td {
            display: inline;
            border-right: 1px solid !important;
        }

        table {
            border: none !important;
            border-spacing: 0;
        }

    </style>
</head>

<body>
    <g:layoutBody/>
    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>
</body>

</g:applyLayout>
