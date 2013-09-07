<g:applyLayout name="board">

	<div class="page-body">
        <div id="columns-selector" class="btn-group" data-toggle="buttons-checkbox">
            <button type="button" class="btn btn-info active" value="HISTORY">HISTORY</button>
            <button type="button" class="btn btn-info active" value="PROBLEM">PROBLEMS</button>
            <button type="button" class="btn btn-info active" value="ALERT">ALERTS</button>
            <button type="button" class="btn btn-info active" value="PROGRESS">PROGRESS</button>
            <button type="button" class="btn btn-info active" value="JOBS">JOBS</button>
        </div>

		<table id="example" class="patients-table bordered-table zebra-striped">
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
    <script src="${resource(dir: 'js', file: 'ward-book.js')}"></script>
	
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

            $('#columns-selector button').on('click', function() {
                if ($(this).hasClass('active')) {
                    $('.'+$(this).attr('value')).hide();
//                    $('#example tr *:nth-child('+$(this).attr('value')+')').hide();
                }
                else {
                    $('.'+$(this).attr('value')).show();
//                    $('#example tr *:nth-child('+$(this).attr('value')+')').show();
                }
            })
		} );
	</script>
		
</g:applyLayout>