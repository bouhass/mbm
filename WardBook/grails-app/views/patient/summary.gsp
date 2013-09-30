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

        <ul id="view-selector" class="nav nav-tabs">
            <li class="active"><a href="javascript:;">Overview</a></li>
            <li><a href="javascript:;">History</a></li>
        </ul>

        <div class="page-header">
            <h3>${patient.location} - ${patient} [${patient.gender[0]}]</h3>
        </div>

        <div id="Overview" class="view">
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
        </div>

        <div id="History" class="view" style="display: none;">
            <g:render template="/shared/patientHistory" model="[patient: patient]" />
        </div>

        <g:form>
            <g:hiddenField name="id" value="${patient?.id}"/>
            <div class="form-actions">
                <a href="javascript:;" onclick="top.window.location = '${createLink(controller: 'patient', action: 'profile', id: patient.id)}'" class="btn btn-info">
                    <span class="glyphicon glyphicon-user"></span>
                    <g:message code="patient.show.label" default="Full profile"/>
                </a>
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

<script>
    $(window).load(function() {
        $('#view-selector li').on('click', function() {
            $(this).siblings().removeClass('active');
            $('.view').hide();

            $(this).addClass('active');
            $('#'+$(this).text()).show();
        });
    });
</script>

</body>
</html>
