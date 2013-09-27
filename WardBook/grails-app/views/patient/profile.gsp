<g:applyLayout name="patient">

    <div>

        <div class="col-md-9">

            <div class="row col-md-12"></div>

            <div class="row">
                <div class="col-md-1">
                    <a href="${createLink(controller: 'patient', action: 'overview')}" type="button" class="btn btn-default">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </a>
                </div>
                <div class="col-md-9">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="javascript:;">Overview</a></li>
                        <li><a href="javascript:;">History</a></li>
                        <li><a href="javascript:;">Tasks</a></li>
                    </ul>
                </div>
                <div class="col-md-2">
                    <a class="btn btn-warning">Edit</a>
                </div>
            </div>

            <div class="row col-md-12">
                <h3>
                    ${patient.location} - ${patient} [${patient.gender[0]}] | ${patient.ward}
                    <hr/>
                </h3>
            </div>

            <div class="row col-md-12">
                <div class="col-md-3 text-center">
                    <img src="${resource(dir: 'images', file: 'patient-profile_icon.png')}" />
                </div>

                <div class="col-md-3">
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

                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-6">
                            <h4>Problem list</h4>
                            <ul>
                            <g:each in="${patient.records}" var="record">
                                <g:if test="${record.type == 'PROBLEM'}">
                                    <li>${record}</li>
                                </g:if>
                            </g:each>
                            </ul>
                        </div>

                        <div class="col-md-6">
                            <h4>Allergies</h4>
                            <ul>
                                <li>Penicilin - Rash</li>
                            </ul>
                        </div>
                    </div>

                    <div class="row col-md-12">
                        <h4>Length of stay</h4>
                        <div class="col-md-10">
                            <div class="progress">
                                <div class="progress-bar progress-bar-info" style="width: 60%">
                                    <span>4.3</span>
                                </div>
                                <div class="progress-bar" style="width: 15%">
                                    <span>4.8</span>
                                </div>
                                <div class="progress-bar progress-bar-danger" style="width: 25%">
                                    <span>5.4</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            days
                        </div>
                        <div class="row col-md-12">
                            <span class="label label-info">Patient</span>
                            <span class="label label-primary">Hospital avg</span>
                            <span class="label label-danger">National avg</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row col-md-12">
                <a class="btn btn-warning">Assign to</a>
                <a class="btn btn-warning">Move to ward</a>
                <a class="btn btn-danger">Dismiss</a>
                <hr/>
            </div>

            <div class="row col-md-12">
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Nursing jobs
                        </div>
                        <div class="panel-body">
                            <table>
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
                                    </td>
                                    <td>
                                        <input type="text" placeholder="Type to add" data-patient_id="${patient.id}" data-category="NURSE" class="add-task-input mbm-input-blue" />
                                    </td>
                                    <td></td>
                                </tr>
                                <g:each var="t" in="${patient.tasks}">
                                    <g:if test="${t.category == 'NURSE'}">
                                        <tr>
                                            <td class="delete-task">
                                                <button type="button" class="btn btn-danger btn-xs hidden">
                                                    <span class="glyphicon glyphicon-remove"></span>
                                                </button>
                                            </td>
                                            <td>
                                                <div data-type="task"
                                                     data-tid="${t.id}"
                                                     data-name="${t.name}"
                                                     data-status="${t.status}"
                                                     data-priority="${t.priority}"
                                                     data-comment="${t.comment}"
                                                     data-category="${t.category}"
                                                     data-pid="${patient.id}"
                                                     class="editable editable-click task">
                                                    ${t.name}
                                                </div>
                                            </td>
                                            <td class="update-task-status">
                                                <img/>
                                            </td>
                                        </tr>
                                    </g:if>
                                </g:each>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Doctor jobs
                        </div>
                        <div class="panel-body">
                            <table>
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
                                    </td>
                                    <td>
                                        <input type="text" placeholder="Type to add" data-patient_id="${patient.id}" data-category="DOCTOR" class="add-task-input mbm-input-blue" />
                                    </td>
                                    <td></td>
                                </tr>
                                <g:each var="t" in="${patient.tasks}">
                                    <g:if test="${t.category == 'DOCTOR'}">
                                        <tr>
                                            <td class="delete-task">
                                                <button type="button" class="btn btn-danger btn-xs hidden">
                                                    <span class="glyphicon glyphicon-remove"></span>
                                                </button>
                                            </td>
                                            <td>
                                                <div data-type="task"
                                                     data-tid="${t.id}"
                                                     data-name="${t.name}"
                                                     data-status="${t.status}"
                                                     data-priority="${t.priority}"
                                                     data-comment="${t.comment}"
                                                     data-category="${t.category}"
                                                     data-pid="${patient.id}"
                                                     class="editable editable-click task">
                                                    ${t.name}
                                                </div>
                                            </td>
                                            <td class="update-task-status">
                                                <img/>
                                            </td>
                                        </tr>
                                    </g:if>
                                </g:each>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="col-md-3">
            <div>
                <div id="calendar" data-date-format="dd-mm-yyyy" class="text-center"></div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    Comments
                </div>
                <div class="panel-body">
                    Today
                    <div>
                        Patient will have outpatient ECHO on 07/07/13
                    </div>
                    <div>
                        Wife is aware of appointment
                    </div>
                </div>
                <div class="panel-footer">
                    <textarea name="comment" class="form-control" placeholder="Write your comment"></textarea>
                    <a class="btn btn-default">Send</a>
                </div>
            </div>
        </div>

    </div>

    <script>
        // TODO : need to move these functions to a common script
        $(window).load(function() {
            $('#calendar').datepicker({
                todayBtn: 'linked'
            });

            $('.task').each(function() {
                $(this).parent().siblings().children('img').attr('src', taskStatusToImage($(this).attr('data-status')));
            });

            $('.update-task-status').live('click', updateTaskStatus);

            $('.delete-task').live('click', deleteTask);

            $('.inner-table tr').live('mouseover', function() { $(this).find('.delete-task button').removeClass('hidden') });
            $('.inner-table tr').live('mouseout', function() { $(this).find('.delete-task button').addClass('hidden') });
        });
    </script>

</g:applyLayout>
