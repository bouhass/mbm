<g:applyLayout name="board">

	<div class="page-body">
		<table id="patients-table" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th>PATIENT DETAILS</th>
					<th>NURSING JOBS</th>
					<th>DOCTORS JOBS</th>
				</tr>
			</thead>
			<tbody>
			<g:each var="patient" in="${patients}">
				<tr id="${patient.id}">
					<td>
                        <g:render template="patientInfo" model="[patient: patient]" />
					</td>
					<td>
						<g:render template="/shared/taskList" model="[patient: patient, category: 'NURSE', popoverPlacement: 'left']" />
					</td>
					<td>
                        <g:render template="/shared/taskList" model="[patient: patient, category: 'DOCTOR', popoverPlacement: 'left']" />
					</td>
				</tr>
			</g:each>
			</tbody>
		</table>
	</div>

    <div id="task-edit-modal" class="modal fade" tabindex="-1" data-backdrop="true" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    </div><!-- /.modal -->

    <script src="${resource(dir: 'js', file: 'board-patient-management.js')}"></script>
    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>

	<script>
        var modalLoadingDiv = '' +
                '<div class="modal-dialog">' +
                '<div class="modal-content">' +
                '<div class="modal-body">' +
                '<img src="${resource(dir: 'images', file: 'spinner.gif')}" class="text-centered"/>' +
                '</div>' +
                '</div>' +
                '</div>';

        $('#task-edit-modal').on('shown.bs.modal', function () {
        });

        $('#task-edit-modal').on('hidden.bs.modal', function () {
            $(this).html(modalLoadingDiv);
        });

        $(window).load(function() {

            $('#task-edit-modal').html(modalLoadingDiv);

//            window.setInterval(function() {
//                $.get(WEB_APP_ROOT+'patient/jsonlist', function(patients) {
//                    $(patients).each(function(i, patient) {
//
//                        var remoteTasks = [];
//                        $(patient.tasks).each(function(j, task) {
//                            remoteTasks.push(task.id.toString());
//                        });
//
//                        var localTasks = [];
//                        $('tr#'+patient.id+' td div').each(function() {
//                            if ($(this).attr('data-task-id') != undefined) {
//                                localTasks.push($(this).attr('data-task-id'));
//                            }
//                        })
//
//                        // delete tasks if applies
//                        $(localTasks).each(function(k, taskId) {
//                            if ($.inArray(taskId, remoteTasks) == -1) {
//                                $('tr#'+patient.id+' td div[data-task-id="'+taskId+'"]').parent().parent().remove();
//                            }
//                        });
//
//                        $(patient.tasks).each(function(j, task) {
//
//                            // add new tasks if applies
//                            if ($.inArray(task.id.toString(), localTasks) == -1) {
//                                addTask(patient.id, task);
//                            }
//                            else {
//                                // TODO : check update required
//                                var taskElement = $('tr#'+patient.id+' td div[data-task-id="'+task.id+'"]');
//                                taskElement.text(task.name);
//                                taskElement.attr('data-name', task.name);
//                                taskElement.attr('data-status', task.status);
//                                taskElement.attr('data-priority', task.priority);
//                                taskElement.attr('data-comment', task.comment);
//                                taskElement.siblings().children('img').attr('src', taskStatusToImage(task.status));
//                            }
//                        });
//                    })
//                })
//                        .fail(function() {
//                            console.error('ERROR: could not patient data');
//                        })
//            }, 3000);

		});
	</script>
		
</g:applyLayout>