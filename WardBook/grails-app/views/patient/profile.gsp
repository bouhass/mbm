<g:applyLayout name="patient">

    <div class="col-md-9">

        <div class="row"></div>

        <div class="row">
            <div class="col-md-1">
                <a href="${createLink(controller: 'board')}" type="button"
                   class="btn btn-default">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                </a>
            </div>

            <div class="col-md-9">
                <ul id="view-selector" class="nav nav-tabs">
                    <li class="active"><a href="javascript:;">Overview</a></li>
                    <li><a href="javascript:;">Task history</a></li>
                </ul>
            </div>

            <div class="col-md-2">
                <a class="btn btn-warning">Edit</a>
            </div>
        </div>

        <div>
            <h3>
                ${patient.location} - ${patient} [${patient.gender[0]}] | ${patient.ward}
                <hr/>
            </h3>
        </div>

        <div id="Overview" class="view">

            <div class="row col-md-12">
                <div class="col-md-3">
                    <h4>Patient details</h4>
                    <dl>
                        <dt>CONS</dt>
                        <dd>${patient.consultant}</dd>

                        <dt>NHS</dt>
                        <dd>${patient.nhsNumber}</dd>

                        <dt>DOB</dt>
                        <dd><g:formatDate format="dd-MM-yyyy" date="${patient?.dateOfBirth}"/></dd>

                        <dt>Status</dt>
                        <dd>${patient.status}</dd>
                    </dl>
                </div>

                <div class="col-md-3">
                    <h4>
                        <span class="glyphicon glyphicon-warning-sign" style="color:red;"></span>
                        Alerts
                    </h4>
                    <ul>
                        <li>Recent C.diff</li>
                    </ul>
                </div>

                <div class="col-md-3">
                    <h4>Problem list</h4>
                    <ul>
                        <g:each in="${patient.records}" var="record">
                            <g:if test="${record.type == 'PROBLEM'}">
                                <li>${record}</li>
                            </g:if>
                        </g:each>
                    </ul>
                </div>

                <div class="col-md-3">
                    <h4>Allergies</h4>
                    <ul>
                        <li>Penicilin - Rash</li>
                    </ul>
                </div>
            </div>

            <div class="row col-md-12">
                <div class="col-md-6">
                    <h4>Length of stay</h4>

                    <div class="row">
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
                    </div>

                    <div class="row col-md-12">
                        <span class="label label-info">Patient</span>
                        <span class="label label-primary">Hospital avg</span>
                        <span class="label label-danger">National avg</span>
                    </div>
                </div>

                <div class="col-md-6">
                    <h4>Additional info</h4>
                    <dl>
                        <dt>PDD</dt>
                        <dd><g:formatDate date="${new Date(System.currentTimeMillis() + (1 * 24 * 3600 * 1000))}" format="dd-MM-yyyy"></g:formatDate> - [day 7]</dd>

                        <dt>Medically fit</dt>
                        <dd><g:formatDate date="${new Date(System.currentTimeMillis() - (1 * 24 * 3600 * 1000))}" format="dd-MM-yyyy"></g:formatDate></dd>
                    </dl>
                </div>
            </div>

            <div class="row col-md-12">
                <div class="pull-right">
                    <a class="btn btn-warning">Assign to</a>
                    <a class="btn btn-warning">Move to ward</a>
                    <a class="btn btn-danger">Discharge</a>
                    <hr/>
                </div>
            </div>

            <div class="row col-md-12">
                <div class="col-md-6">
                    <div class="panel panel-default task-panel">
                        <div class="panel-heading">
                            Nursing jobs
                        </div>

                        <div class="panel-body">
                            <g:render template="/shared/taskList" model="[patient: patient, category: 'NURSE', popoverPlacement: 'top']"/>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="panel panel-default task-panel">
                        <div class="panel-heading">
                            Doctor jobs
                        </div>

                        <div class="panel-body">
                            <g:render template="/shared/taskList" model="[patient: patient, category: 'DOCTOR', popoverPlacement: 'top']"/>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div id="Task_history" class="view" style="display: none;">
            <g:render template="/shared/patientHistory" model="[patient: patient]"/>
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
                <g:render template="/shared/comments" model="[commentable: patient]"/>
            </div>
        </div>
    </div>

    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>

    <script>
        $(window).load(function () {

            $('#view-selector li').on('click', function () {
                $(this).siblings().removeClass('active');
                $('.view').hide();

                $(this).addClass('active');
                $('#' + $(this).text().replace(' ', '_')).show();
            });

            $('#calendar').datepicker({
                todayBtn: 'linked'
            });
        });
    </script>

</g:applyLayout>
