$(window).load(function() {
    $('input.add-task-input').each(function() {
        $(this).keyup(function (e) {
            if (e.keyCode == 13) {
                addNewTask($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-category'));
                $(this).val('');
            }
        });
    });

    $('input.add-task-input').typeahead({
        name: 'task-names',
        prefetch: WEB_APP_ROOT+'task/names',
        remote: WEB_APP_ROOT+'task/names?q=%QUERY'
    });

    /* Init tasks status icons. */
    $('.task').each(function() {
        $(this).parent().siblings().children('img').attr('src', taskStatusToImage($(this).attr('data-status')));
    });

    $('.update-task-status').live('click', updateTaskStatus);

    $('.delete-task').live('click', deleteTask);

    $('.inner-table tr').live('mouseover', function() { $(this).find('.delete-task button').removeClass('hidden') });
    $('.inner-table tr').live('mouseout', function() { $(this).find('.delete-task button').addClass('hidden') });

    /* Init popover functionality. */
    $('.task').each(function() {
        $(this).editable({
            type : 'text',
            placement: $(this).attr('data-popover-placement'),
            pk : $(this).attr('data-tid'),
            url : WEB_APP_ROOT+'task/saveOrUpdate',
            value: {
                name: $(this).attr('data-name'),
                status: $(this).attr('data-status'),
                priority: $(this).attr('data-priority'),
                comment: $(this).attr('data-comment')
            },
            params : function(params) {
                return {
                    'id' : $(this).attr('data-tid'),
                    'name' : params.value.name,
                    'status' : params.value.status,
                    'priority': params.value.priority,
                    'comment': params.value.comment,
                    'category' : $(this).attr('data-category'),
                    'patient.id' : $(this).attr('data-pid')
                }
            }
        });
    });
});