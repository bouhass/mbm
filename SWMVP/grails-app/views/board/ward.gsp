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
						<table id="table-${p.id}" class="inner-table">
							<tr><td><a onclick="addRow('#table-${p.id}')">+ ADD NEW</a></td></tr>
						</table>
					</td>
					<td>${p.id}</td>
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