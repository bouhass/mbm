<div class="panel-group" id="patientsAccordion-${groupId}">
    <g:each var="patient" in="${patients}">
        <div id="${patient.id}" class="panel ${patient.status.contains('Unwell') ? 'panel-danger' : 'panel-info'} filterable-element">
            <div class="panel-heading">
                <div class="panel-title row">
                    <div class="pull-left">
                        <input type="checkbox" data-id="${patient.id}" ${patient.handover ? 'checked' : ''} class="patient-handover">
                    </div>

                    <div class="col-sm-1 col-md-1">
                        <a href="#" data-id="${patient.id}" data-value="${patient.location}" class="patient-location">${patient.location}</a>
                    </div>

                    <a data-toggle="collapse" data-parent="#patientsAccordion-${groupId}" href="#collapse-${patient.id}">
                        <div class="col-sm-8 col-md-8">
                            ${patient} - ${new Date().year - patient.dateOfBirth.year} ${patient.gender ? patient.gender[0] : ''}
                            <g:if test="${!request.user.teamList && patient.teamLists}">
                                | ${patient.teamLists}
                            </g:if>
                        </div>

                        <div class="col-sm-2 col-md-2">
                            <%
                                def activeTasks = patient.tasks.findAll { it.isActive() }
                                def taskCountByStatus = activeTasks.countBy { it.status }
                                def nbUrgentTasks = activeTasks.count { it.priority == 'URGENT' }
                            %>

                            <g:each in="['PENDING', 'STARTED', 'COMPLETED']" var="status">
                                <g:if test="${taskCountByStatus["${status}"]}">
                                    ${taskCountByStatus["${status}"]} <g:img dir="images" file="check-square-${status}.png" />
                                    &nbsp;
                                </g:if>
                            </g:each>

                            <g:if test="${nbUrgentTasks}">
                                - (${nbUrgentTasks} urgent <span class="glyphicon glyphicon-fire" style="color: orangered;"></span>)
                            </g:if>
                        </div>

                        <div class="pull-right">
                            <span class="glyphicon glyphicon-plus"></span>
                        </div>
                    </a>
                </div>
            </div>

            <div id="collapse-${patient.id}" class="panel-collapse collapse ${(patient == patients.first() || params['new'] == "${patient.id}") ? 'in' : ''}">
                <div class="panel-body inner-content">

                    <div class="col-sm-2 col-md-2 no-padding-lf">
                        <h5>
                            Demographics
                        </h5>

                        %{--<span class="glyphicon glyphicon-pencil pull-right">edit</span>--}%

                        <div class="row">
                            <a href="#" data-id="${patient.id}" data-value="${patient.consultant}" class="patient-consultant filterable-consultant">${patient.consultant}</a>
                        </div>

                        <div class="row">
                            <g:formatDate format="dd-MM-yyyy" date="${patient.dateOfBirth}"/>
                        </div>

                        <div class="row">
                            ${patient.hospitalIdentifier}
                        </div>

                        <div class="row">
                            <a href="#" data-id="${patient.id}" data-value="${patient.status}" class="patient-status filterable-status">${patient.status}</a>
                        </div>

                        <div class="row">
                            <h5>
                                <span class="glyphicon glyphicon-list-alt"></span>
                                Add to list(s)...
                            </h5>
                            <a href="#" class="teamLists" data-type="select2" data-id="${patient.id}">${patient.teamLists?.join(', ')}</a>
                        </div>

                        <div class="row">
                            <g:link controller="patient" action="profile" id="${patient.id}" class="btn btn-secondary btn-md">
                               <span class="glyphicon glyphicon-eye-open"></span> View profile
                            </g:link>
                        </div>
                    </div>

                    <div class="col-sm-7 col-md-7 no-padding">
                        <div class="col-sm-6 col-md-6">
                            <h5>Clinical History</h5>
                            <a href="#" data-id="${patient.id}" data-value="${patient.history ?: message(code: 'patient.history.input.placeholder')}" class="patient-history">${patient.history}</a>
                        </div>

                        <div class="col-sm-6 col-md-6 record-plan">
                            <h5>Current Plan</h5>
                            <g:render template="/shared/recordList" model="[
                                    patient: patient,
                                    recordType: 'PLAN',
                                    inputType: 'textarea',
                                    placeholder: message(code: 'add.plan.record.input.placeholder')]" />
                        </div>
                    </div>

                    <div class="col-sm-3 col-md-3 no-padding-rt">
                        <h5>Tasks</h5>
                        <g:render template="/shared/taskList" model="[patient: patient]" />
                    </div>
                </div>
            </div>
        </div>
    </g:each>
</div>