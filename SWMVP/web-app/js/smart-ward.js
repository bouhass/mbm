
function statusToClass(status) {
    if (status == 'PENDING')    return 'icon-pause';
    if (status == 'STARTED')    return 'icon-play';
    if (status == 'COMPLETED')  return 'icon-stop';
}

function addTask(patient_id, category) {
	var id = new Date().getTime();
	$('#task-'+category+'-'+patient_id).append('<tr><td id="'+id+'" data-type="task" class="editable editable-click"></td></tr>');
	$('#'+id).editable({
	    type: 'text',
	    pk: patient_id,
	    url: '/SmartWardMVP/task/saveOrUpdate',
	    params: function(params) {
	    	return {
	    		'id': $(this).attr('data-tid'),
	    		'name': params.value.name,
	    		'status': params.value.status,
	    		'category': category,
	    		'patient.id': patient_id
	    	}
	    },
	    success: function(task, newValue) {
	    	$(this).attr('data-tid', task.id);
        }
	});
}
