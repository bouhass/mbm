<div class="panel-group" id="patientsAccordion-${groupId}">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <div class="panel-title row">
                    <div class="col-sm-1 col-md-1">
                        LOC
                    </div>

                    <div class="col-sm-5 col-md-5">
                        Patient
                    </div>

                    <div class="col-sm-5 col-md-5">
                        Tasks
                    </div>
                </div>
            </h4>
        </div>
    </div>
    <g:each var="patient" in="${patients}">
        <div class="panel panel-info">
            <div class="panel-heading">
                <a data-toggle="collapse" data-parent="#patientsAccordion-${groupId}" href="#collapse-${patient.id}">
                    <div class="panel-title row">
                        <div class="col-sm-1 col-md-1">
                            ${patient.location}
                        </div>

                        <div class="col-sm-5 col-md-5">
                            ${patient} - ${new Date().year - patient.dateOfBirth.year} ${patient.gender[0]}
                        </div>

                        <div class="col-sm-5 col-md-5">
                            <%
                                def taskCountByStatus = patient.tasks.countBy { it.status }
                                def nbUrgentTasks = patient.tasks.count { it.priority == 'URGENT' }
                            %>

                            <g:each in="['PENDING', 'STARTED', 'COMPLETED']" var="status">
                                <g:if test="${taskCountByStatus["${status}"]}">
                                    ${taskCountByStatus["${status}"]} <g:img dir="images" file="check-square-${status}.png" />
                                </g:if>
                                &nbsp;
                            </g:each>

                            <g:if test="${nbUrgentTasks}">
                                - (${nbUrgentTasks} urgent <span class="glyphicon glyphicon-fire" style="color: orangered;"></span>)
                            </g:if>
                        </div>

                        <div class="pull-right">
                            <span class="glyphicon glyphicon-plus"></span>
                        </div>
                    </div>
                </a>
            </div>

            <div id="collapse-${patient.id}" class="panel-collapse collapse ${patient == patients.first() ? 'in' : ''}">
                <div class="panel-body">

                    <div class="col-sm-2 col-md-2">
                        <h4>Demographics</h4>

                        <div class="row">
                            <a href="#" data-id="${patient.id}" data-value="${patient.consultant}" class="patient-consultant">${patient.consultant}</a>
                        </div>

                        <div class="row">
                            <g:formatDate format="dd-MM-yyyy" date="${patient.dateOfBirth}"/>
                        </div>

                        <div class="row">
                            ${patient.nhsNumber}
                        </div>

                        <div class="row">
                            <a href="#" data-id="${patient.id}" data-value="${patient.status}" class="patient-status">${patient.status}</a>
                        </div>
                    </div>

                    <div class="col-sm-4 col-md-4">
                        <div class="col-sm-6 col-md-6">
                            <h4>PMH</h4>
                            <g:render template="/shared/recordList" model="[patient: patient, recordType: 'HISTORY']" />
                        </div>

                        <div class="col-sm-6 col-md-6">
                            <h4>Plan</h4>
                            <g:render template="/shared/recordList" model="[patient: patient, recordType: 'PLAN']" />
                        </div>
                    </div>

                    <div class="col-sm-6 col-md-6">
                        <h4>Tasks</h4>
                        <g:render template="/shared/taskList" model="[patient: patient]" />
                    </div>
                </div>
            </div>
        </div>
    </g:each>
</div>