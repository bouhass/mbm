
function statusToImage(status) {
    if (status == 'PENDING')    return WEB_APP_ROOT+'/images/empty-square.png';
    if (status == 'STARTED')    return WEB_APP_ROOT+'/images/half-square.png';
    if (status == 'COMPLETED')  return WEB_APP_ROOT+'/images/full-square.png';
}

function addTask(patient_id, category) {
	var id = new Date().getTime();
	$('#task-'+category+'-'+patient_id).append('<tr><td id="'+id+'" data-type="task" class="editable editable-click"></td></tr>');
	$('#'+id).editable({
	    type: 'text',
	    pk: patient_id,
	    url: WEB_APP_ROOT+'/task/saveOrUpdate',
	    params: function(params) {
	    	return {
	    		'id': $(this).attr('data-tid'),
	    		'name': params.value.name,
	    		'status': params.value.status,
                'priority': params.value.priority,
                'comment': params.value.comment,
	    		'category': category,
	    		'patient.id': patient_id
	    	}
	    },
	    success: function(task, newValue) {
	    	$(this).attr('data-tid', task.id);
        }
	});
}
