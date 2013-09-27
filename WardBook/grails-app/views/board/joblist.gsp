<g:applyLayout name="board">


	<div class="page-body">
		<table id="patients-table" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th>DEMOGRAPHICS</th>
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
                                    <a href="#" data-pid="${p.id}" data-value="${p.location}" class="patient-location">${p.location}</a>
                                </td>
                                <td>
                                    <g:link controller="patient" action="profile" id="${p.id}">
                                        ${p} [${p.gender[0]}]
                                    </g:link>
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
                                    <a href="#" data-pid="${p.id}" data-value="${p.status}" class="patient-status">${p.status}</a>
                                </td>
                            </tr>
                        </table>
					</td>
					<td>
						<table id="task-NURSE-${p.id}" class="inner-table">
							<tr>
                                <td>
                                    <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
                                </td>
                                <td>
                                    <input type="text" placeholder="Type to add" data-patient_id="${p.id}" data-category="NURSE" class="add-task-input mbm-input-blue" />
                                </td>
                                <td></td>
                            </tr>
							<g:each var="t" in="${p.tasks}">
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
                                                 data-pid="${p.id}"
                                                 class="editable editable-click task">
                                                ${t.name}
                                                %{--&nbsp;--}%
                                                %{--<span class="glyphicon glyphicon-comment task-comment-notification">--}%
                                                    %{--<p class="task-comment-number">1</p>--}%
                                                %{--</span>--}%
                                            </div>
                                        </td>
                                        <td class="update-task-status">
                                            <img/>
                                        </td>
                                    </tr>
								</g:if>
							</g:each>
						</table>
					</td>
					<td>
						<table id="task-DOCTOR-${p.id}" class="inner-table">
							<tr>
                                <td>
                                    <span class="glyphicon glyphicon-plus mbm-icon-blue"></span>
                                </td>
                                <td>
                                    <input type="text" placeholder="Type to add" data-patient_id="${p.id}" data-category="DOCTOR" class="add-task-input mbm-input-blue" />
                                </td>
                                <td></td>
                            </tr>
							<g:each var="t" in="${p.tasks}">
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
                                                 data-pid="${p.id}"
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
					</td>
				</tr>
			</g:each>
			</tbody>
		</table>
	</div>

	<script>
        $(window).load(function() {

            $.fn.editable.defaults.mode = 'popup';

            $('#search').keyup(patientTableSearch);

            $('.patient-location').each(updatePatientLocation);
            $('.patient-status').each(updatePatientStatus);

            $('input.add-task-input').each(function() {
                $(this).keyup(function (e) {
                    if (e.keyCode == 13) {
                        addNewTask($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-category'));
                        $(this).val('');
                    }
                });
            });

            $('input.add-task-input').typeahead({
                name: 'task-names',
                prefetch: WEB_APP_ROOT+'task/names',
                remote: WEB_APP_ROOT+'task/names?q=%QUERY'
            });

            /* Init tasks status icons. */
            $('.task').each(function() {
                $(this).parent().siblings().children('img').attr('src', taskStatusToImage($(this).attr('data-status')));
            });

            $('.update-task-status').live('click', updateTaskStatus);

            $('.delete-task').live('click', deleteTask);

            $('.inner-table tr').live('mouseover', function() { $(this).find('.delete-task button').removeClass('hidden') });
            $('.inner-table tr').live('mouseout', function() { $(this).find('.delete-task button').addClass('hidden') });

            /* Init popover functionality. */
            $('.task').each(function() {
                $(this).editable({
                    type : 'text',
                    placement: 'left',
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

            window.setInterval(function() {
                $.get(WEB_APP_ROOT+'patient/jsonlist', function(patients) {
                    $(patients).each(function(i, patient) {

                        var remoteTasks = [];
                        $(patient.tasks).each(function(j, task) {
                            remoteTasks.push(task.id.toString());
                        });

                        var localTasks = [];
                        $('tr#'+patient.id+' td div').each(function() {
                            if ($(this).attr('data-tid') != undefined) {
                                localTasks.push($(this).attr('data-tid'));
                            }
                        })

                        // delete tasks if applies
                        $(localTasks).each(function(k, taskId) {
                            if ($.inArray(taskId, remoteTasks) == -1) {
                                $('tr#'+patient.id+' td div[data-tid="'+taskId+'"]').parent().parent().remove();
                            }
                        });

                        $(patient.tasks).each(function(j, task) {

                            // add new tasks if applies
                            if ($.inArray(task.id.toString(), localTasks) == -1) {
                                addTask(patient.id, task);
                            }
                            else {
                                // TODO : check update required
                                var taskElement = $('tr#'+patient.id+' td div[data-tid="'+task.id+'"]');
                                taskElement.text(task.name);
                                taskElement.attr('data-name', task.name);
                                taskElement.attr('data-status', task.status);
                                taskElement.attr('data-priority', task.priority);
                                taskElement.attr('data-comment', task.comment);
                                taskElement.siblings().children('img').attr('src', taskStatusToImage(task.status));
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