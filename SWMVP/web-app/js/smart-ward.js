
function addTask(patient_id, category) {
	var id = new Date().getTime();
	$('#task-'+category+'-'+patient_id).append('<tr><td id="'+id+'"></td></tr>');
	$('#'+id).editable({
	    type: 'text',
	    pk: patient_id,
	    url: '/SmartWardMVP/task/create',
	    params: function(params) {
	        //originally params contain pk, name and value
	        // override name as Task domain class need name field
	        params['name'] = params.value;
	        params['status'] = 'PENDING';
	        params['category'] = category;
	        params['patient.id'] = patient_id;
	        return params;
	    }
	});
}
