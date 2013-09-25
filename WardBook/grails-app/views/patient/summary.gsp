<%@ page import="com.wardbook.Patient" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap-plain">
    <g:set var="entityName" value="${message(code: 'patient.label', default: 'Patient')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="row">

        <ul class="nav nav-tabs">
            <li class="active"><a href="javascript:;">Overview</a></li>
            <li><a href="javascript:;">History</a></li>
            <li><a href="javascript:;">Tasks</a></li>
        </ul>

        <div class="page-header">
            <h3>${patient.location} - ${patient} [${patient.gender[0]}]</h3>
        </div>

        <dl>

            <dt>Consultant</dt>
            <dd>${patient.consultant}</dd>

            <dt>NHS</dt>
            <dd>${patient.nhsNumber}</dd>

            <dt>DOB</dt>
            <dd><g:formatDate format="dd-MM-yyyy" date="${patient?.dateOfBirth}"/></dd>

            <dt>Status</dt>
            <dd>${patient.status}</dd>

        </dl>

        <g:form>
            <g:hiddenField name="id" value="${patient?.id}"/>
            <div class="form-actions">
                <g:link class="btn btn-info" action="show" id="${patient?.id}">
                    <span class="glyphicon glyphicon-user"></span>
                    <g:message code="patient.show.label" default="Full profile"/>
                </g:link>
                <g:link class="btn btn-warning" action="edit" id="${patient?.id}">
                    <span class="glyphicon glyphicon-pencil"></span>
                    <g:message code="default.button.edit.label" default="Edit"/>
                </g:link>
                <button class="btn btn-danger" type="submit" name="_action_delete">
                    <span class="glyphicon glyphicon-trash icon-white"></span>
                    <g:message code="default.button.delete.label" default="Delete"/>
                </button>
            </div>
        </g:form>

    </div>
</div>

</body>
</html>
