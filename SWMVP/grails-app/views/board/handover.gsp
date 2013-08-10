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
					<td>
                        <ul>
                            <g:each var="record" in="${p.records}">
                                <g:if test="${record.type == 'HISTORY'}">
                                    <li>${record.name}</li>
                                </g:if>
                            </g:each>
                        </ul>
					</td>
					<td>
						<ul>
							<g:each var="record" in="${p.records}">
                                <g:if test="${record.type == 'PROBLEM'}">
								    <li>${record.name}</li>
                                </g:if>
							</g:each>
						</ul>
					</td>
					<td>
                        <ul>
                            <g:each var="record" in="${p.records}">
                                <g:if test="${record.type == 'ALERT'}">
                                    <li>${record.name}</li>
                                </g:if>
                            </g:each>
                        </ul>
					</td>
					<td>
                        <ul>
                            <g:each var="record" in="${p.records}">
                                <g:if test="${record.type == 'PROGRESS'}">
                                    <li>${record.name}</li>
                                </g:if>
                            </g:each>
                        </ul>
					</td>
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
	
	<script src="${resource(dir: 'datatables/js', file: 'jquery.dataTables.js')}"></script>
	
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
		} );
	</script>
		
</g:applyLayout>