<g:applyLayout name="board">

	<div class="page-body">
		<table id="patients-table" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th>PATIENT INFO</th>
					<th class="HISTORY">HISTORY</th>
					<th class="PROBLEM">PROBLEMS</th>
					<th class="ALERT">ALERTS</th>
					<th class="PROGRESS">PROGRESS</th>
                    <th class="JOBS">JOBS</th>
				</tr>
			</thead>
			<tbody>
			<g:each var="p" in="${patients}">
				<tr>
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
                                        <input type="text" placeholder="+ ADD NEW" data-patient_id="${p.id}" data-type="${recordType}" class="add-record-input" />
                                    </td>
                                </tr>
                                <g:each var="record" in="${p.records}">
                                    <g:if test="${record.type == recordType}">
                                        <tr>
                                            <td>
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
                                    <td>
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

    <script src="${resource(dir: 'bootstrap-editable/js', file: 'bootstrap-editable.js')}"></script>
    <script src="${resource(dir: 'js', file: 'ward-book-board.js')}"></script>
	
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
		});
	</script>
		
</g:applyLayout>