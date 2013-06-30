<g:applyLayout name="board">

	<div class="page-body">
		<table id="example" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th>LOCATION</th>
					<th>NAME</th>
					<th>PROBLEM LIST</th>
					<th>ADDITIONAL INFO</th>
					<th>TASKS</th>
				</tr>
			</thead>
			<tbody>
			<g:each var="p" in="${patients}">
				<tr>
					<td>${p.location}</td>
					<td>
						${p.firstName} ${p.lastName}
					</td>
					<td>
						<ul>
							<g:each var="record" in="${p.records}">
								<li>${record.description}</li>
							</g:each>
						</ul>
					</td>
					<td></td>
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