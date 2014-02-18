<%@ page import="com.wardbook.ReferralList" %>
<g:applyLayout name="bootstrap-navbar">
    <link rel="stylesheet" href="${resource(dir: 'select2/css',  file: 'select2.css')}">

    <div class="row col-sm-12 col-md-12">

        <div class="col-sm-3 col-md-3">
            <h4>Demographics</h4>

            <dl>
                <dt>First name</dt>
                <dd><a href="#" data-id="${patient.id}" data-value="${patient.firstName}" class="patient-firstName">${patient.firstName}</a></dd>

                <dt>Last name</dt>
                <dd><a href="#" data-id="${patient.id}" data-value="${patient.lastName}" class="patient-lastName">${patient.lastName}</a></dd>

                <dt>Location</dt>
                <dd><a href="#" data-id="${patient.id}" data-value="${patient.location}" class="patient-location">${patient.location}</a></dd>

                <dt>Ward</dt>
                <dd><a href="#" data-id="${patient.id}" data-value="${patient.ward?.id}" class="patient-ward">${patient.ward?.name}</a></dd>

                <dt>Consultant</dt>
                <dd><a href="#" data-id="${patient.id}" data-value="${patient.consultant}" class="patient-consultant filterable-consultant">${patient.consultant}</a></dd>

                <dt>D.O.B.</dt>
                <dd>
                    <a href="#" data-type="combodate" data-pk="${patient.id}" data-patient-id="${patient.id}" data-value="${patient.dateOfBirth}" class="patient-dob">
                        <g:formatDate format="dd-MM-yyyy" date="${patient.dateOfBirth}"/>
                    </a>
                </dd>

                <dt>NHS number</dt>
                <dd><a href="#" data-id="${patient.id}" data-value="${patient.nhsNumber}" class="patient-nhsNumber">${patient.nhsNumber}</a></dd>

                <dt>Status</dt>
                <dd><a href="#" data-id="${patient.id}" data-value="${patient.status}" class="patient-status filterable-status">${patient.status}</a></dd>
            </dl>

            <div class="row">
                <h4>
                    <span class="glyphicon glyphicon-list-alt"></span>
                    Add to list(s)...
                </h4>
                <a href="#" id="referralLists" data-type="select2">${patient.referralLists?.join(', ')}</a>
            </div>
        </div>

        <div class="col-sm-3 col-md-3">
            <h4>Clinical History</h4>
            <a href="#" data-id="${patient.id}" data-value="${patient.history}" class="patient-history">${patient.history}</a>
        </div>

        <div class="col-sm-3 col-md-3">
            <h4>Current Plan</h4>
            <g:render template="/shared/recordList" model="[patient: patient, recordType: 'PLAN', inputType: 'textarea']" />
        </div>

        <div class="col-sm-3 col-md-3">
            <h4>Tasks</h4>
            <g:render template="/shared/taskList" model="[patient: patient]" />
        </div>

    </div>

    <div class="row col-sm-12 col-md-12">
        <div class="col-sm-6 col-md-6">
            <h4>Weight</h4>
            <canvas id="weightChart" width="320" height="200"></canvas>
        </div>

        %{--<div class="col-sm-6 col-md-4">--}%
            %{--<h4>Additional info</h4>--}%
            %{--<dl>--}%
                %{--<dt>PDD</dt>--}%
                %{--<dd><g:formatDate date="${new Date(System.currentTimeMillis() + (1 * 24 * 3600 * 1000))}" format="dd-MM-yyyy"></g:formatDate> - [day 7]</dd>--}%

                %{--<dt>Medically fit</dt>--}%
                %{--<dd><g:formatDate date="${new Date(System.currentTimeMillis() - (1 * 24 * 3600 * 1000))}" format="dd-MM-yyyy"></g:formatDate></dd>--}%
            %{--</dl>--}%

            %{--<h4>Length of stay</h4>--}%

            %{--<div class="row">--}%
                %{--<div class="col-md-10">--}%
                    %{--<div class="progress">--}%
                        %{--<div class="progress-bar progress-bar-info" style="width: 60%">--}%
                            %{--<span>4.3</span>--}%
                        %{--</div>--}%

                        %{--<div class="progress-bar" style="width: 15%">--}%
                            %{--<span>4.8</span>--}%
                        %{--</div>--}%

                        %{--<div class="progress-bar progress-bar-danger" style="width: 25%">--}%
                            %{--<span>5.4</span>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%

                %{--<div class="col-md-2">--}%
                    %{--days--}%
                %{--</div>--}%
            %{--</div>--}%

            %{--<div class="row col-md-12">--}%
                %{--<span class="label label-info">Patient</span>--}%
                %{--<span class="label label-primary">Hospital avg</span>--}%
                %{--<span class="label label-danger">National avg</span>--}%
            %{--</div>--}%
        %{--</div>--}%

        <div class="col-sm-6 col-md-6">
            <g:render template="/shared/comments" model="[commentable: patient]"/>
        </div>
    </div>

    <div class="row col-sm-12 col-md-12">
        <h2>History</h2>
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
                        <td class="task-status" data-task-status="${task.status}"><img/></td>
                    </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>
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
