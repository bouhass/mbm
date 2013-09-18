<g:applyLayout name="board">

    <div class="third-level-nav">
        <div class="col-lg-9">
            %{--<ul class="nav nav-tabs nav-justified">--}%
            <ul id="view-selector" class="nav nav-tabs">
                <li><a href="#"> Doctor </a></li>
                <li><a href="#"> Nurse </a></li>
                <li><a href="#"> Physio </a></li>
                <li><a data-toggle="modal" href="#customizeView"> <span class="glyphicon glyphicon-plus"></span> </a></li>
            </ul>
        </div>
        <div class="pull-right">
            <a class="btn btn-default">
                <span class="glyphicon glyphicon-print"></span>
            </a>
            <a data-toggle="modal" href="#customizeView" class="btn btn-default">
                Edit view
            </a>
        </div>
    </div>

	<div class="page-body">
		<table id="patients-table" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th>DEMOGRAPHICS</th>
					<th class="HISTORY">PMH</th>
					<th class="PROBLEM">PROBLEM LIST</th>
					<th class="PROGRESS">PROGRESS</th>
					<th class="PLAN">PLAN</th>
					<th class="NOTE">NOTES</th>
					<th class="DIET">DIET</th>
					<th class="PREMORBID">PRE-MORBID STATUS</th>
					<th class="MOBILITY">MOBILITY</th>
					<th class="SOCIAL">SOCIAL</th>
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
                                    <a href="#" data-pid="${p.id}" data-value="${p.status}" class="patient-status">${p.status}</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <g:each var="recordType" in="['HISTORY', 'PROBLEM', 'PROGRESS', 'PLAN', 'NOTE', 'DIET', 'PREMORBID', 'MOBILITY', 'SOCIAL']">
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
				</tr>
			</g:each>
			</tbody>
		</table>

        <!-- Modal -->
        <div class="modal fade" id="customizeView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Customize your view</h4>
                    </div>
                    <div class="modal-body">
                        <span class="glyphicon glyphicon-search" style="color: #3cf"></span>
                        &nbsp;
                        <input type="text" placeholder="Search for column" class="mbm-input-blue" />
                        <form role="form">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="PROBLEM"> PROBLEM LIST
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="PROGRESS"> PROGRESS
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="PLAN"> PLAN
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="NOTE"> NOTES
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="DIET"> DIET
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="PREMORBID"> PRE-MORBID STATUS
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="MOBILITY"> MOBILITY
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="SOCIAL"> SOCIAL
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> RESUS STATUS
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> CONTINENCE
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> EWS
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> DATE OF ADMISSION
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> DISCHARGE PLAN
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> MRSA
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> PDD
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> DATE OF ARRIVAL
                                </label>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Save <span class="glyphicon glyphicon-chevron-right"></span></button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Save as new <span class="glyphicon glyphicon-chevron-right"></span></button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
	</div>
	
	<script>
		$(window).load(function() {
            $('#search').keyup(patientTableSearch);

            $('.patient-location').each(updatePatientLocation);
            $('.patient-status').each(updatePatientStatus);

            var handoverViewsColumnsMapping = {
                Doctor: ['HISTORY', 'PROBLEM', 'PROGRESS', 'PLAN', 'NOTE'],
                Nurse: ['HISTORY', 'PROBLEM', 'DIET', 'MOBILITY', 'SOCIAL'],
                Physio: ['HISTORY', 'PROBLEM', 'PREMORBID', 'MOBILITY', 'SOCIAL']
            }

            $(['HISTORY', 'PROBLEM', 'PROGRESS', 'PLAN', 'NOTE', 'DIET', 'PREMORBID', 'MOBILITY', 'SOCIAL']).each(function(j, columnToHide) {
                $('.'+columnToHide).hide();
            });

            $('#view-selector li a:not([data-toggle])').on('click', function() {
                $(this).parent().siblings().removeClass('active');
                $(this).parent().addClass('active');
                $(['HISTORY', 'PROBLEM', 'PROGRESS', 'PLAN', 'NOTE', 'DIET', 'PREMORBID', 'MOBILITY', 'SOCIAL']).each(function(j, columnToHide) {
                    $('.'+columnToHide).hide();
                });
                $('#customizeView input').attr('checked', false);
                $(handoverViewsColumnsMapping[$(this).text().trim()]).each(function(i, columnName) {
                    $('.'+columnName).show();
                    $('#customizeView input[value='+columnName+']').attr('checked', true);
                });
            });

            // TODO : displayHandoverViewFor('Doctor')
            $('#view-selector li a:contains(Doctor)').click();

            $('.add-record-input').each(function() {
                $(this).keyup(function (e) {
                    if (e.keyCode == 13) {
                        addRecord($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-type'));
                        $(this).val('');
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