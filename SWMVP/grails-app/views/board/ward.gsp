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
									<tr><td data-type="task" data-pid="${p.id}" data-tid="${t.id}" data-category="${t.category}" class="editable editable-click">${t.name}</td></tr>
								</g:if>
							</g:each>
						</table>
					</td>
					<td>
						<table id="task-DOCTOR-${p.id}" class="inner-table">
							<tr><td><a onclick="addTask('${p.id}', 'DOCTOR')">+ ADD NEW</a></td></tr>
							<g:each var="t" in="${p.tasks}">
								<g:if test="${t.category == 'DOCTOR'}">
									<tr><td data-type="task" data-pid="${p.id}" data-tid="${t.id}" data-category="${t.category}" class="editable editable-click">${t.name}</td></tr>
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

		/* Table initialisation */
		$(document).ready(function() {
			$('#example').dataTable( {
				"sDom": "<'row'<'span8'l><'span8'f>r>t<'row'<'span8'i><'span8'p>>"
			} );
		} );

		
		$('.editable').each(function() {
			$(this).editable({
				type : 'text',
				pk : $(this).attr('data-tid'),
				url : '/SmartWardMVP/task/saveOrUpdate',
				params : function(params) {
					return {
						'id' : $(this).attr('data-tid'),
						'name' : params.value.name,
						'status' : params.value.status,
						'category' : $(this).attr('data-category'),
						'patient.id' : $(this).attr('data-pid')
					}
				}
			});
		});
	</script>
		
</g:applyLayout>