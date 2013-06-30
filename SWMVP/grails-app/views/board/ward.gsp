<g:applyLayout name="board">

	<div class="page-body">
		<table id="example" class="patients-table bordered-table zebra-striped">
			<thead>
				<tr>
					<th>PATIENT INFO</th>
					<th>NURSING JOBS</th>
					<th>DOCTORS JOBS</th>
				</tr>
			</thead>
			<tbody>
			<g:each var="p" in="${patients}">
				<tr>
					<td>
						${p.firstName} ${p.lastName}
					</td>
					<td>
						<table id="task-NURSE-${p.id}" class="inner-table">
							<tr><td><a onclick="addTask('${p.id}', 'NURSE')">+ ADD NEW</a></td></tr>
							<g:each var="t" in="${p.tasks}">
								<g:if test="${t.category == 'NURSE'}">
									<tr><td>${t.name}</td></tr>
								</g:if>
							</g:each>
						</table>
					</td>
					<td>
						<table id="task-DOCTOR-${p.id}" class="inner-table">
							<tr><td><a onclick="addTask('${p.id}', 'DOCTOR')">+ ADD NEW</a></td></tr>
							<g:each var="t" in="${p.tasks}">
								<g:if test="${t.category == 'DOCTOR'}">
									<tr><td>${t.name}</td></tr>
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
	
	<script>
		$.fn.editable.defaults.mode = 'inline';
		
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