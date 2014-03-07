<%@ page import="com.wardbook.User" %>
<g:applyLayout name="bootstrap-mobile">

    <g:set var="navTitle" value="${patient}" scope="request" />

    <div class="col-sm-12">
        <h4>
            ${patient.location ? "${patient.location}" : ''} -
            ${patient.consultant ? "${patient.consultant}" : ''} -
            ${new Date().year - patient.dateOfBirth.year}y -
            ${patient.gender ? patient.gender[0] : ''}
        </h4>

        <ul id="view-selector" class="nav nav-tabs task-view">
            <li class="active"><a href="javascript:;"><span class="glyphicon glyphicon-th-list"></span>Tasks</a></li>
            <li><a href="javascript:;"><span class="glyphicon glyphicon-folder-open"></span>Archive</a></li>
        </ul>
    </div>

    <div id="Tasks" class="view list-group" style="height: 100%">
        <div class="list-group-item" style="z-index: 100; position: absolute; bottom: 45px; width: 100%">
            <div class="input-group">
                <input type="text" placeholder="${message(code: 'add.entry.input.default.placeholder')}" data-patient_id="${patient.id}" class="add-task-input mbm-input-blue form-control" maxlength="60" />

                <div class="input-group-btn">
                    <span class="glyphicon glyphicon-pencil"></span>
                </div>
            </div>
        </div>
        <div id="task-list">
            <g:each in="${patient.tasks}" var="task">
                <g:if test="${task.isActive()}">
                    <div class="list-group-item">
                        <div class="row">
                            <div class="col-xs-1 update-task-status" data-target-task-id="${task.id}">
                                <img />
                            </div>
                            <g:link controller="task" action="partialEdit" id="${task.id}" class="task" data-task-id="${task.id}" data-task-status="${task.status}">
                                <div class="col-xs-9">
                                    ${task} - <span class="task-creator">${User.get(task.createdBy)}</span>
                                </div>
                                <div class="pull-right">
                                    <span class="glyphicon glyphicon-chevron-right"></span>
                                </div>
                            </g:link>
                        </div>
                    </div>
                </g:if>
            </g:each>
        </div>
    </div>

    <div id="Archive" class="view list-group" style="display: none">
        <g:each in="${patient.tasks}" var="task">
            <g:if test="${!task.isActive()}">
                <g:link controller="task" action="partialEdit" id="${task.id}" class="list-group-item">
                    ${task}
                    <div class="pull-right">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </div>
                </g:link>
            </g:if>
        </g:each>
    </div>

    <script>
        $(window).load(function() {
            $('#view-selector li').on('click', switchView);

            /* Init tasks status icons. */
            $('.task').each(function() {
                var taskId = $(this).attr('data-task-id');
                var taskStatusImage = $('[data-target-task-id="'+taskId+'"]').children('img');
                taskStatusImage.attr('src', taskStatusToImage($(this).attr('data-task-status')));
            });

            $('.update-task-status').live('click', updateTaskStatus);

            var addNewTaskMobile = function(patient_id, task) {
                $("#task-list").prepend('\
                <div class="list-group-item">\
                    <div class="row">\
                        <div class="col-xs-1 update-task-status" data-target-task-id="'+task.id+'">\
                            <img src="'+taskStatusToImage(task.status)+'"/>\
                        </div>\
                        <a href="'+WEB_APP_ROOT+'task/partialEdit/'+task.id+'" class="task" data-task-id="'+task.id+'" data-task-status="'+task.status+'">\
                            <div class="col-xs-9">\
                                <span>'+task.name+'</span>\
                            </div>\
                            <div class="pull-right">\
                                <span class="glyphicon glyphicon-chevron-right"></span>\
                            </div>\
                        </a>\
                    </div>\
                </div>');
            }

            $('input.add-task-input').keyup(function (e) {
                if (e.keyCode == 13) {
                    addNewTask($(this).val(), $(this).attr('data-patient_id'), 'DOCTOR', addNewTaskMobile);
                    $(this).typeahead('setQuery', '');
                }
            });

            $('input.add-task-input').on('typeahead:selected', function() {
                addNewTask($(this).val(), $(this).attr('data-patient_id'), 'DOCTOR', addNewTaskMobile);
                $(this).typeahead('setQuery', '');
            });

            $('input.add-task-input').typeahead({
                name: 'task-names',
                prefetch: WEB_APP_ROOT+'data/common-tasks.json',
                remote: WEB_APP_ROOT+'task/names?q=%QUERY'
            });
        });
    </script>

</g:applyLayout>