<%@ page import="com.wardbook.ReferralList" %>
<g:applyLayout name="bootstrap-navbar">
    <link rel="stylesheet" href="${resource(dir: 'select2/css',  file: 'select2.css')}">

    <div class="col-sm-12 col-md-9">

        <div class="row"></div>

        <div class="row">
            <div class="col-sm-11 col-md-12">
                <ul id="view-selector" class="nav nav-tabs">
                    <li class="active"><a href="javascript:;">Overview</a></li>
                    <li><a href="javascript:;">Task history</a></li>
                </ul>
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
                <div class="col-sm-6 col-md-6">
                    <h4>Patient details</h4>
                    <g:render template="patientInfo" model="[patient: patient]" />
                    <h4>
                        <span class="glyphicon glyphicon-list-alt"></span>
                        Add to list(s)...
                    </h4>
                    <a href="#" id="referralLists" data-type="select2">${patient.referralLists?.join(', ')}</a>
                </div>

                <div class="col-sm-2 col-md-2">
                    <h4>
                        <span class="glyphicon glyphicon-warning-sign" style="color:red;"></span>
                        Alerts
                    </h4>
                    <ul>
                        <li>Recent C.diff</li>
                    </ul>
                </div>

                <div class="col-sm-2 col-md-2">
                    <h4>Problem list</h4>
                    <ul>
                        <g:each in="${patient.records}" var="record">
                            <g:if test="${record.type == 'PROBLEM'}">
                                <li>${record}</li>
                            </g:if>
                        </g:each>
                    </ul>
                </div>

                <div class="col-sm-2 col-md-2">
                    <h4>Allergies</h4>
                    <ul>
                        <li>Penicilin - Rash</li>
                    </ul>
                </div>
            </div>

            <div class="row col-sm-12 col-md-12">
                <div class="col-sm-6 col-md-6">
                    <h4>Weight</h4>
                    <canvas id="weightChart" width="320" height="200"></canvas>
                </div>

                <div class="col-sm-6 col-md-6">
                    <h4>Additional info</h4>
                    <dl>
                        <dt>PDD</dt>
                        <dd><g:formatDate date="${new Date(System.currentTimeMillis() + (1 * 24 * 3600 * 1000))}" format="dd-MM-yyyy"></g:formatDate> - [day 7]</dd>

                        <dt>Medically fit</dt>
                        <dd><g:formatDate date="${new Date(System.currentTimeMillis() - (1 * 24 * 3600 * 1000))}" format="dd-MM-yyyy"></g:formatDate></dd>
                    </dl>

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
            </div>

            <hr/>

            <div class="row col-md-12">
                <div class="col-sm-6 col-md-6">
                    <div class="panel panel-default task-panel">
                        <div class="panel-heading">
                            Jobs
                        </div>

                        <div class="panel-body">
                            <g:render template="/shared/taskList" model="[patient: patient]"/>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div id="Task_history" class="view" style="display: none;">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Location</th>
                    <th>Patient</th>
                    <th>Task</th>
                    <th>Time due</th>
                    <th>Comments</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${patient.tasks}" var="task">
                    <g:if test="${!task.isActive()}">
                        <tr>
                            <td>${task.patient.location}</td>
                            <td>${task.patient}</td>
                            <td>${task.name}</td>
                            <td><g:formatDate format="dd-MM-yyyy HH:mm" date="${task.timeDue}"/></td>
                            <td>${task.comments.size}</td>
                            <td class="task-status" data-status="${task.status}"><img/></td>
                        </tr>
                    </g:if>
                </g:each>
                </tbody>
            </table>
        </div>

        <hr/>

    </div>

    <div class="col-md-3">
        <div class="col-sm-4 col-md-12">
            <div id="calendar" data-date-format="dd-mm-yyyy" class="text-center"></div>
        </div>

        <div class="col-sm-8 col-md-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <g:render template="/shared/comments" model="[commentable: patient]"/>
                </div>
            </div>
        </div>
    </div>

    <script src="${resource(dir: 'js', file: 'patient-management.js')}"></script>
    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>
    <script src="${resource(dir: 'js', file: 'Chart.min.js')}"></script>
    <script src="${resource(dir: 'select2/js', file: 'select2.js')}"></script>

    <script>
        <%
            def weightRecords = patient.records.findAll { it.type == 'WEIGHT' }.sort { it.createdDate }
            def weights = weightRecords?.collect { Double.valueOf(it.name) }
        %>
        var weightData = {
            labels : ${ weightRecords.collect { "'${it.createdDate.format('dd/MMM')}'" } },
            datasets : [
                {
                    fillColor : "rgba(151,187,205,0.5)",
                    strokeColor : "rgba(151,187,205,1)",
                    pointColor : "rgba(151,187,205,1)",
                    pointStrokeColor : "#fff",
                    data : ${ weights }
                }
            ]
        }

        $(window).load(function () {

            $('#view-selector li').on('click', switchView);

            $('#calendar').datepicker({
                todayBtn: 'linked'
            });

            <g:if test="${weights}">
            new Chart($("#weightChart").get(0).getContext("2d")).Line(
                    weightData,
                    {
                        scaleOverride : true,
                        scaleSteps : 10,
                        scaleStepWidth : ${ Math.ceil(weights.max() / 10.0)},
                        scaleStartValue : 0
                    }
            );
            </g:if>

            $('#referralLists').editable({
                title: 'Select list(s)',
                type: 'select2',
                url: WEB_APP_ROOT+"helpers/referralLists",
                pk: ${patient.id},
                onblur: 'submit',
                select2: {
                    placeholder: 'Select list(s)',
                    tokenSeparators: [",", " "],
                    tags: ${ ReferralList.list().collect { "'${it}'" } }
                },
                tpl: '<input type="hidden" style="min-width: 100px">'
            });

            $('.task-status').each(function() {
                $(this).children('img').attr('src', taskStatusToImage($(this).attr('data-status')));
            });
        });
    </script>

</g:applyLayout>
