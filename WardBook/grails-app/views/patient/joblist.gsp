<g:applyLayout name="board">

    <div class="third-level-nav">
        <div class="col-sm-5 col-md-5">
        </div>

        <div class="col-sm-7 col-md-7">
            <div class="pull-right col-sm-4 col-md-4">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search" name="search" id="search">

                    <div class="input-group-btn">
                        <button class="btn btn-primary">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </div>
                </div>
            </div>

            <div class="pull-right">
                <a id="handover" class="btn btn-primary" style="margin-bottom: 8px">
                    Handover
                </a>
            </div>
        </div>
    </div>

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
				<tr id="${patient.id}" ${patient.status.contains('Unwell') ? 'class="patient-unwell"' : ''}>
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

    <script src="${resource(dir: 'js', file: 'board-management.js')}"></script>
    <script src="${resource(dir: 'js', file: 'task-management.js')}"></script>

	<script>
        $(window).load(function() {

            $('#handover').on('click', function() {
                var $rows = $('#patients-table > tbody > tr');
                if ($(this).hasClass('active')) {
                    $rows.show();
                    $(this).removeClass('active');
                }
                else {
                    $rows.hide().filter(function() {
                        return $(this).find('input[type="checkbox"]').is(':checked');
                    }).show();
                    $(this).addClass('active');
                }
            });

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
//                                taskElement.parent().siblings().children('img').attr('src', taskStatusToImage(task.status));
//                            }
//                        });
//                    })
//                })
//                        .fail(function() {
//                            console.error('ERROR: could not patient data');
//                        })
//            }, 10000);

		});
	</script>
		
</g:applyLayout>