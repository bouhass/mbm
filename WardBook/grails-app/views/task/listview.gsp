<%@ page import="com.wardbook.User; com.wardbook.Task" %>

<g:applyLayout name="bootstrap-navbar">

    <div class="col-sm-2 col-md-2">
        <div class="row panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Filters</h3>
            </div>
            <div class="panel-body">
                <g:each var="status" in="${Task.constraints.status.inList}">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"
                                   value="${status}"
                                   class="checkbox-filter"
                                   data-filter-mode="attribute"
                                   data-filter-type="task-status"
                                   onclick="javascript:filterableFilter()"/> ${status}
                        </label>
                    </div>
                </g:each>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"
                               value="${request.user}"
                               class="checkbox-filter"
                               data-filter-type="assignee"
                               onclick="javascript:filterableFilter()"/> My tasks
                    </label>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-10 col-md-10">

        <g:render template="/shared/listViewToolbar" model="[showPrintButton: false]" />

        <div class="panel-group" id="tasksAccordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <div class="panel-title row">
                            <div class="col-sm-1 col-md-1">
                                LOC
                            </div>

                            <div class="col-sm-3 col-md-3">
                                Patient
                            </div>

                            <div class="col-sm-3 col-md-3">
                                Task
                            </div>

                            <div class="col-sm-2 col-md-2">
                                Time due
                            </div>

                            <div class="col-sm-1 col-md-1">
                                <span class="glyphicon glyphicon-comment"></span>
                            </div>

                            <div class="col-sm-1 col-md-1">
                                Status
                            </div>
                        </div>
                    </h4>
                </div>
            </div>
            <g:each var="task" in="${tasks}">
                <div class="panel panel-info filterable-element">
                    <div class="panel-heading">
                        <div class="panel-title row">
                            <a data-toggle="collapse" data-parent="#tasksAccordion" href="#collapse-${task.id}">
                                <div class="col-sm-1 col-md-1">
                                    ${task.patient.location}
                                </div>

                                <div class="col-sm-3 col-md-3">
                                    ${task.patient}
                                </div>

                                <div class="col-sm-3 col-md-3">
                                    ${task.name}
                                </div>

                                <div class="col-sm-2 col-md-2">
                                    <g:formatDate format="dd-MM-yyyy HH:mm" date="${task.timeDue}"/>
                                </div>

                                <div class="col-sm-1 col-md-1">
                                    ${task.comments.size}
                                </div>
                            </a>

                            <div class="col-sm-1 col-md-1 update-task-status filterable-task-status"
                                 data-task-id="${task.id}"
                                 data-target-task-id="${task.id}"
                                 data-task-status="${task.status}">
                                <img />
                            </div>

                            <a data-toggle="collapse" data-parent="#tasksAccordion" href="#collapse-${task.id}">
                                <div class="pull-right">
                                    <span class="glyphicon glyphicon-plus"></span>
                                </div>
                            </a>
                        </div>
                    </div>

                    <div id="collapse-${task.id}" class="panel-collapse collapse">
                        <div class="panel-body">

                            <div class="col-sm-6 col-md-6">
                                <div class="row">
                                    <dl>
                                        <dt>Created by</dt>
                                        <dd>${User.get(task.createdBy)}</dd>
                                    </dl>

                                    <dl>
                                        <dt>Assign to</dt>
                                        <dd><a href="#" data-id="${task.id}" data-value="${task.assignee?.id}" class="task-assignee filterable-assignee">${task.assignee ?: ''}</a></dd>
                                    </dl>
                                    <dl>
                                        <dt>Priority</dt>
                                        <dd><a href="#" data-id="${task.id}" data-value="${task.priority}" class="task-priority">${task.priority}</a></dd>
                                    </dl>
                                    <dl>
                                        <dt>Time due</dt>
                                        <dd><a href="#" data-type="combodate" data-pk="${task.id}" data-task-id="${task.id}" data-value="${task.timeDue}" class="task-time-due"></a></dd>
                                    </dl>
                                </div>

                                <div class="row">
                                    <h4>Patient</h4>

                                    <div class="row">
                                        <a href="#" data-id="${task.patient.id}" data-value="${task.patient.consultant}" class="patient-consultant filterable-consultant">${task.patient.consultant}</a>
                                    </div>

                                    <div class="row">
                                        <g:formatDate format="dd-MM-yyyy" date="${task.patient.dateOfBirth}"/>
                                    </div>

                                    <div class="row">
                                        ${task.patient.nhsNumber}
                                    </div>

                                    <div class="row">
                                        <a href="#" data-id="${task.patient.id}" data-value="${task.patient.status}" class="patient-status filterable-status">${task.patient.status}</a>
                                    </div>

                                    <div class="row">
                                        <g:link controller="patient" action="profile" id="${task.patient.id}" class="btn btn-default">
                                            View profile
                                        </g:link>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6 col-md-6">
                                <g:render template="/shared/comments" model="[commentable: task]"/>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </div>
    </div>

    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>
    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>

    <script>
        $(window).load(function() {
            $('.task-assignee').each(function() {
                updateBeanField(this, this, 'task', $(this).attr('data-id'), 'assignee.id', 'select', $(this).attr('data-value'), WEB_APP_ROOT+'helpers/users');
            });

            $('.task-priority').each(function() {
                updateBeanField(this, this, 'task', $(this).attr('data-id'), 'priority', 'select', $(this).attr('data-value'), { NORMAL: "NORMAL", URGENT: "URGENT" });
            });

            updateBeanDateTimeField($('.task-time-due'), 'timeDue', 'task');
        });
    </script>

</g:applyLayout>
