<g:applyLayout name="bootstrap-mobile">

    <g:set var="navTitle" value="${patient}" scope="request" />

    <div class="col-sm-12">
        <h4>
            ${patient.location ? "${patient.location}" : ''} -
            ${patient.consultant ? "${patient.consultant}" : ''} -
            ${new Date().year - patient.dateOfBirth.year}y -
            ${patient.gender[0]}
        </h4>

        <ul id="view-selector" class="nav nav-tabs">
            <li class="active"><a href="javascript:;">Tasks</a></li>
            <li><a href="javascript:;">Archive</a></li>
        </ul>
    </div>

    <div id="Tasks" class="view list-group">
        <g:each in="${patient.tasks}" var="task">
            <g:if test="${task.isActive()}">
                <div class="list-group-item">
                    <div class="row">
                        <div class="col-xs-1 update-task-status" data-target-task-id="${task.id}">
                            <img />
                        </div>
                        <g:link controller="task" action="partialEdit" id="${task.id}" class="task" data-task-id="${task.id}" data-status="${task.status}">
                            <div class="col-xs-9">
                                <span>${task}</span>
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

    <div class="col-sm-12">
        <g:link controller="task" action="add" params="['patient.id': patient.id]" class="btn btn-primary form-control">Add task</g:link>
    </div>

    <script>
        $(window).load(function() {
            $('#view-selector li').on('click', switchView);

            /* Init tasks status icons. */
            $('.task').each(function() {
                var taskId = $(this).attr('data-task-id');
                var taskStatusImage = $('[data-target-task-id="'+taskId+'"]').children('img');
                taskStatusImage.attr('src', taskStatusToImage($(this).attr('data-status')));
            });

            $('.update-task-status').live('click', updateTaskStatus);
        });
    </script>

</g:applyLayout>