
function addRow(table_id) {
	var id = new Date().getTime();
	$(table_id).append('<tr><td id="'+id+'"></td></tr>');
	$('#'+id).editable({
	    type: 'text',
	    pk: table_id,
	    url: '/SmartWard/task/save',
	    params: function(params) {
	        //originally params contain pk, name and value
	        // override name as Task domain class need name field
	        params.name = params.value;
	        return params;
	    }
	});
}
