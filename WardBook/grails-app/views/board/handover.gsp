<g:applyLayout name="board">

    <div class="third-level-nav">
        <div class="col-lg-9">
            <ul class="nav nav-tabs nav-justified">
                <li class="active"><a href="#"> Doctors </a></li>
                <li><a href="#"> Nurse </a></li>
                <li><a href="#"> Physio </a></li>
                <li><a href="#"> + </a></li>
            </ul>
        </div>
        <div class="pull-right">
            <a class="btn btn-default">
                <span class="glyphicon glyphicon-print"></span>
            </a>
            <a class="btn btn-default">
                Edit view
            </a>
        </div>
    </div>

	<div class="page-body">
		<table id="patients-table" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th>DEMOGRAPHICS</th>
					<th class="HISTORY">HISTORY</th>
					<th class="PROBLEM">PROBLEMS</th>
					<th class="ALERT">ALERTS</th>
					<th class="PROGRESS">PROGRESS</th>
                    <th class="JOBS">JOBS</th>
				</tr>
			</thead>
			<tbody>
			<g:each var="p" in="${patients}">
				<tr id="${p.id}">
                    <td>
                        <table class="patient-info">
                            <tr>
                                <td>
                                    ${p.location}
                                </td>
                                <td>
                                    ${p} [${p.gender[0]}]
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ${p.consultant}
                                </td>
                                <td>
                                    <g:formatDate format="dd-MM-yyyy" date="${p.dateOfBirth}"/>
                                    [${new Date().year - p.dateOfBirth.year}y]
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ${p.nhsNumber}
                                </td>
                                <td>
                                    <a href="#" data-pid="${p.id}" data-status="${p.status}" class="patient-status">${p.status}</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <g:each var="recordType" in="['HISTORY', 'PROBLEM', 'ALERT', 'PROGRESS']">
                        <td class="${recordType}">
                            <table id="record-${recordType}-${p.id}" class="inner-table">
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-plus" style="color: #3cf"></span>
                                        &nbsp;
                                        <input type="text" placeholder="Type to add" data-patient_id="${p.id}" data-type="${recordType}" class="add-record-input mbm-input-blue" />
                                    </td>
                                </tr>
                                <g:each var="record" in="${p.records}">
                                    <g:if test="${record.type == recordType}">
                                        <tr>
                                            <td data-rid="${record.id}">
                                                ${record.name}
                                            </td>
                                        </tr>
                                    </g:if>
                                </g:each>
                            </table>
                        </td>
                    </g:each>
					<td class="JOBS">
                        <table class="inner-table">
                            <g:each var="task" in="${p.tasks}">
                                <tr>
                                    <td data-tid="${task.id}">
                                        ${task.name}
                                    </td>
                                </tr>
                            </g:each>
                        </table>
                    </td>
				</tr>
			</g:each>
			</tbody>
		</table>
	</div>
	
	<script>
		/* Table initialisation */
		$(document).ready(function() {
            $('.add-record-input').each(function() {
                $(this).keyup(function (e) {
                    if (e.keyCode == 13) {
                        addRecord($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-type'));
                        $(this).val('');
                    }
                });
            });

            $('#columns-selector button').on('click', function() {
                if ($(this).hasClass('active')) {
                    $('.'+$(this).attr('value')).hide();
//                    $('#example tr *:nth-child('+$(this).attr('value')+')').hide();
                }
                else {
                    $('.'+$(this).attr('value')).show();
//                    $('#example tr *:nth-child('+$(this).attr('value')+')').show();
                }
            });

            window.setInterval(function() {
                $.get(WEB_APP_ROOT+'patient/jsonlist', function(patients) {
                    $(patients).each(function(i, patient) {

                        var remoteTasks = [];
                        $(patient.tasks).each(function(j, task) {
                            remoteTasks.push(task.id.toString());
                        });

                        var remoteRecords = [];
                        $(patient.records).each(function(j, record) {
                            remoteRecords.push(record.id.toString());
                        });

                        var localTasks = [];
                        $('tr#'+patient.id+' td').each(function() {
                            if ($(this).attr('data-tid') != undefined) {
                                localTasks.push($(this).attr('data-tid'));
                            }
                        })

                        var localRecords = [];
                        $('tr#'+patient.id+' td').each(function() {
                            if ($(this).attr('data-rid') != undefined) {
                                localRecords.push($(this).attr('data-rid'));
                            }
                        })

                        // delete tasks if applies
                        $(localTasks).each(function(k, taskId) {
                            if ($.inArray(taskId, remoteTasks) == -1) {
                                $('tr#'+patient.id+' td[data-tid="'+taskId+'"]').parent().remove();
                            }
                        });

                        // delete records if applies
                        $(localRecords).each(function(k, recordId) {
                            if ($.inArray(recordId, remoteRecords) == -1) {
                                $('tr#'+patient.id+' td[data-rid="'+recordId+'"]').parent().remove();
                            }
                        });


                        $(patient.tasks).each(function(j, task) {

                            // add new tasks if applies
                            if ($.inArray(task.id.toString(), localTasks) == -1) {
                                $('.JOBS tbody').append('<tr><td data-tid="'+task.id+'">'+task.name+'</td></tr>')
                            }
                            else {
                                // TODO : check update required
                                var taskElement = $('tr#'+patient.id+' td[data-tid="'+task.id+'"]');
                                taskElement.text(task.name);
                            }
                        });

                        $(patient.records).each(function(j, record) {

                            // add new records if applies
                            if ($.inArray(record.id.toString(), localRecords) == -1) {
                                $('.'+record.type+' tbody').append('<tr><td data-rid="'+record.id+'">'+record.name+'</td></tr>')
                            }
                            else {
                                // TODO : check update required
                                var recordElement = $('tr#'+patient.id+' td[data-rid="'+record.id+'"]');
                                recordElement.text(record.name);
                            }
                        });
                    })
                })
                        .fail(function() {
                            console.error('ERROR: could not patient data');
                        })
            }, 3000);
		});
	</script>
		
</g:applyLayout>