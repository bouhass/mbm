<%@ page import="com.wardbook.User; com.wardbook.Task" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
</head>

<body>
<div class="container">
    <div class="row">

        <div class="page-header">
            <h3>
                ${task.name} - ${task.priority}
                <div class="task-status pull-right" data-status="${task.status}">
                    <img />
                </div>
            </h3>
        </div>

        <dl>
            <dt>Time due</dt>
            <dd>UNASSIGNED</dd>

            <dt>Created by</dt>
            <dd>${User.get(task.createdBy)}</dd>

            <dt>Assigned to</dt>
            <dd>${task.assignee ?: 'NOT ASSIGNED'}</dd>
        </dl>

        <g:link class="btn btn-warning" action="edit" id="${task?.id}">
            <span class="glyphicon glyphicon-pencil"></span>
            <g:message code="default.button.edit.label" default="Edit"/>
        </g:link>

        <div class="page-header">
            <h3>${task.patient.location} - ${task.patient} [${task.patient.gender[0]}]</h3>
        </div>

        <div id="Overview" class="view">
            <dl>

                <dt>Consultant</dt>
                <dd>${task.patient.consultant}</dd>

                <dt>NHS</dt>
                <dd>${task.patient.nhsNumber}</dd>

                <dt>DOB</dt>
                <dd><g:formatDate format="dd-MM-yyyy" date="${task.patient.dateOfBirth}"/></dd>

                <dt>Status</dt>
                <dd>${task.patient.status}</dd>

            </dl>
        </div>

        <g:form>
            <g:hiddenField name="id" value="${task.patient?.id}"/>
            <div class="form-actions">
                <a href="javascript:;" onclick="top.window.location = '${createLink(controller: 'patient', action: 'profile', id: task.patient.id)}'" class="btn btn-info">
                    <span class="glyphicon glyphicon-user"></span>
                    <g:message code="patient.show.label" default="Full profile"/>
                </a>
            </div>
        </g:form>

        <br/>
        <div class="panel panel-default">
            <div class="panel-heading">
                Comments
            </div>

            <div class="panel-body">
                <g:render template="/shared/comments" model="[commentable: task]"/>
            </div>
        </div>

    </div>
</div>

<script>
    $(window).load(function() {
        $('.task-status').each(function() {
            $(this).children('img').attr('src', taskStatusToImage($(this).attr('data-status')));
        });
    });
</script>

</body>
</html>
