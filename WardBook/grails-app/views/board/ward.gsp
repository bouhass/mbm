<g:applyLayout name="board">


	<div class="page-body">
		<table id="example" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th width="40%">PATIENT INFO</th>
					<th>NURSING JOBS</th>
					<th>DOCTORS JOBS</th>
				</tr>
			</thead>
			<tbody>
			<g:each var="p" in="${patients}">
				<tr id="${p.id}">
					<td>
                        <table class="patient-info">
                            <tr>
                                <td>
                                    ${p} - ${p.gender[0]}
                                </td>
                                <td>
                                    <b>LOC</b> ${p.location}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>DOB</b> <g:formatDate format="dd-MM-yyyy" date="${p.dateOfBirth}"/>
                                    (${new Date().year - p.dateOfBirth.year}y)
                                </td>
                                <td>
                                    <b>NHS</b> ${p.nhsNumber}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>STATUS</b> <a href="#" data-pid="${p.id}" data-status="${p.status}" class="patient-status">${p.status}</a>
                                </td>
                                <td>
                                    <b>CONS</b> ${p.consultant}
                                </td>
                            </tr>
                        </table>
					</td>
					<td>
						<table id="task-NURSE-${p.id}" class="inner-table">
							<tr>
                                <td></td>
                                <td>
                                    <input type="text" placeholder="+ ADD NEW" data-patient_id="${p.id}" data-category="NURSE" class="add-task-input" />
                                </td>
                                <td></td>
                            </tr>
							<g:each var="t" in="${p.tasks}">
								<g:if test="${t.category == 'NURSE'}">
									<tr>
                                        <td class="update-task-status">
                                            <img/>
                                        </td>
                                        <td data-type="task"
                                            data-tid="${t.id}"
                                            data-name="${t.name}"
                                            data-status="${t.status}"
                                            data-priority="${t.priority}"
                                            data-comment="${t.comment}"
                                            data-category="${t.category}"
                                            data-pid="${p.id}"
                                            class="editable editable-click task">
                                            ${t.name}
                                        </td>
                                        <td class="delete-task">
                                            <i class="icon-remove" />
                                        </td>
                                    </tr>
								</g:if>
							</g:each>
						</table>
					</td>
					<td>
						<table id="task-DOCTOR-${p.id}" class="inner-table">
							<tr>
                                <td></td>
                                <td>
                                    <input type="text" placeholder="+ ADD NEW" data-patient_id="${p.id}" data-category="DOCTOR" class="add-task-input" />
                                </td>
                                <td></td>
                            </tr>
							<g:each var="t" in="${p.tasks}">
								<g:if test="${t.category == 'DOCTOR'}">
									<tr>
                                        <td class="update-task-status">
                                            <img/>
                                        </td>
                                        <td data-type="task"
                                            data-tid="${t.id}"
                                            data-name="${t.name}"
                                            data-status="${t.status}"
                                            data-priority="${t.priority}"
                                            data-comment="${t.comment}"
                                            data-category="${t.category}"
                                            data-pid="${p.id}"
                                            class="editable editable-click task">
                                            ${t.name}
                                        </td>
                                        <td class="delete-task">
                                            <i class="icon-remove" />
                                        </td>
                                    </tr>
								</g:if>
							</g:each>
						</table>
					</td>
				</tr>
			</g:each>
			</tbody>
		</table>
	</div>
	
	<script src="${resource(dir: 'bootstrap-editable/js', file: 'bootstrap-editable.js')}"></script>
	<script src="${resource(dir: 'datatables/js', file: 'jquery.dataTables.js')}"></script>
	<script src="${resource(dir: 'js', file: 'smart-ward.js')}"></script>
	<script src="${resource(dir: 'js', file: 'task.js')}"></script>
	
	<script>
		$.fn.editable.defaults.mode = 'popup';
		
		// data tables
		/* Default class modification */
		$.extend( $.fn.dataTableExt.oStdClasses, {
			"sSortAsc": "header headerSortDown",
			"sSortDesc": "header headerSortUp",
			"sSortable": "header"
		} );


		$(document).ready(function() {

            /* Table initialisation */
			$('#example').dataTable( {
				"sDom": "<'row'<'span8'l><'span8'f>r>t<'row'<'span8'i><'span8'p>>"
			});

            $('.add-task-input').each(function() {
                $(this).keyup(function (e) {
                    if (e.keyCode == 13) {
                        addNewTask($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-category'));
                        $(this).val('');
                    }
                });
            });

            /* Init tasks status icons. */
            $('.task').each(function() {
                $(this).siblings().children('img').attr('src', taskStatusToImage($(this).attr('data-status')));
            });

            $('.update-task-status').on('click', updateTaskStatus);

            $('.delete-task').on('click', deleteTask);

            /* Init popover functionality. */
            $('.task').each(function() {
                $(this).editable({
                    type : 'text',
                    pk : $(this).attr('data-tid'),
                    url : '${createLink(controller: 'task', action: 'saveOrUpdate')}',
                    value: {
                        name: $(this).attr('data-name'),
                        status: $(this).attr('data-status'),
                        priority: $(this).attr('data-priority'),
                        comment: $(this).attr('data-comment')
                    },
                    params : function(params) {
                        return {
                            'id' : $(this).attr('data-tid'),
                            'name' : params.value.name,
                            'status' : params.value.status,
                            'priority': params.value.priority,
                            'comment': params.value.comment,
                            'category' : $(this).attr('data-category'),
                            'patient.id' : $(this).attr('data-pid')
                        }
                    }
                });
            });

            $('.patient-status').each(function() {
                $(this).editable({
                    mode: 'inline',
                    type: 'select',
                    pk : $(this).attr('data-pid'),
                    url: '${createLink(controller: 'patient', action: 'updateStatus')}',
                    value: $(this).attr('data-status'),
                    source: '${createLink(controller: 'patient', action: 'statuses')}',
//                    source: [
//                        {value: 'Default (no concerns)', text: 'Default (no concerns)'},
//                        {value: 'New Admission', text: 'New Admission'},
//                        {value: 'Unwell', text: 'Unwell'},
//                        {value: 'For Home', text: 'For Home'}
//                    ],
                    showbuttons: false,
                    params : function(params) {
                        return {
                            'id' : $(this).attr('data-pid'),
                            'status' : params.value
                        }
                    }
                });
            });

            window.setInterval(function() {
                $.get(WEB_APP_ROOT+'patient/jsonlist', function(patients) {
                    $(patients).each(function(i, patient) {

                        var remoteTasks = [];
                        $(patient.tasks).each(function(j, task) {
                            remoteTasks.push(task.id.toString());
                        });

                        var localTasks = [];
                        $('tr#'+patient.id+' td').each(function() {
                            if ($(this).attr('data-tid') != undefined) {
                                localTasks.push($(this).attr('data-tid'));
                            }
                        })

                        // delete tasks if applies
                        $(localTasks).each(function(k, taskId) {
                            if ($.inArray(taskId, remoteTasks) == -1) {
                                $('tr#'+patient.id+' td[data-tid="'+taskId+'"]').parent().remove();
                            }
                        });

                        $(patient.tasks).each(function(j, task) {

                            // add new tasks if applies
                            if ($.inArray(task.id.toString(), localTasks) == -1) {
                                addTask(patient.id, task);
                            }
                            else {
                                // TODO : check for update
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