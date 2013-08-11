<g:applyLayout name="board">

	<div class="page-body">
		<table id="example" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th>PATIENT INFO</th>
					<th>HISTORY</th>
					<th>PROBLEMS</th>
					<th>ALERTS</th>
					<th>PROGRESS</th>
                    <th>JOBS</th>
				</tr>
			</thead>
			<tbody>
			<g:each var="p" in="${patients}">
				<tr>
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
                                    <b>STATUS</b> ${p.status}
                                </td>
                                <td>
                                    <b>CONS</b> ${p.consultant}
                                </td>
                            </tr>
                        </table>
                    </td>
                    <g:each var="recordType" in="['HISTORY', 'PROBLEM', 'ALERT', 'PROGRESS']">
                        <td>
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
					<td>
						<ul>
							<g:each var="task" in="${p.tasks}">
								<li>${task.name}</li>
							</g:each>
						</ul>
					</td>
				</tr>
			</g:each>
			</tbody>
		</table>
	</div>

    <script src="${resource(dir: 'bootstrap-editable/js', file: 'bootstrap-editable.js')}"></script>
    <script src="${resource(dir: 'datatables/js', file: 'jquery.dataTables.js')}"></script>
    <script src="${resource(dir: 'js', file: 'smart-ward.js')}"></script>
	
	<script>
		// data tables
		/* Default class modification */
		$.extend( $.fn.dataTableExt.oStdClasses, {
			"sSortAsc": "header headerSortDown",
			"sSortDesc": "header headerSortUp",
			"sSortable": "header"
		} );

		/* Table initialisation */
		$(document).ready(function() {
			$('#example').dataTable( {
				"sDom": "<'row'<'span8'l><'span8'f>r>t<'row'<'span8'i><'span8'p>>"
			} );

            $('.add-record-input').each(function() {
                $(this).keyup(function (e) {
                    if (e.keyCode == 13) {
                        addRecord($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-type'));
                        $(this).val('');
                    }
                });
            });
		} );
	</script>
		
</g:applyLayout>