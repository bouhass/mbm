
function openTaskEditModal(taskId) {
    var taskElement = $('[data-task-id='+taskId+']');
    var timeDue = (taskElement.attr('data-time-due') == undefined ? '' : taskElement.attr('data-time-due'));

    var modal = $('\
                <div class="modal" id="task-edit-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">\
                    <div class="modal-dialog">\
                        <div class="modal-content">\
                            <div class="modal-header">\
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>\
                                <h4 class="modal-title">'+taskElement.attr('data-name')+'</h4>\
                            </div>\
                            <div class="modal-body">\
                                <dl>\
                                    <dt>Assign to</dt>\
                                    <dd><a href="#" class="task-assignee">'+taskElement.attr('data-assignee')+'</a></dd>\
                                </dl>\
                                <dl>\
                                    <dt>Priority</dt>\
                                    <dd><a href="#" class="task-priority">'+taskElement.attr('data-priority')+'</a></dd>\
                                </dl>\
                                <dl>\
                                    <dt>Time due</dt>\
                                    <dd><a href="#" data-type="combodate" data-pk="'+taskId+'" data-task-id="'+taskId+'" data-value="'+timeDue+'" class="task-time-due"></a></dd>\
                                </dl>\
                            <div>\
                                TODO : comments\
                            </div>\
                        </div>\
                        <div class="modal-footer">\
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>\
                        </div>\
                    </div>\
                </div>\
            </div>');

    updateBeanField(modal.find('.task-assignee'), taskElement, 'task', taskId, 'assignee.id', 'select', taskElement.attr('data-priority'), WEB_APP_ROOT+'helpers/users');
    updateBeanField(modal.find('.task-priority'), taskElement, 'task', taskId, 'priority', 'select', taskElement.attr('data-priority'), { NORMAL: "NORMAL", HIGH: "HIGH", URGENT: "URGENT" });
    updateTaskTimeDue(modal.find('.task-time-due'));
    modal.modal('show');
}

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
//        prefetch: WEB_APP_ROOT+'task/names',
        prefetch: WEB_APP_ROOT+'data/common-tasks.json',
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
//    $('.task').each(function() {
//        $(this).editable({
//            type : 'text',
//            placement: $(this).attr('data-popover-placement'),
//            pk : $(this).attr('data-task-id'),
//            url : WEB_APP_ROOT+'task/saveOrUpdate',
//            value: {
//                name: $(this).attr('data-name'),
//                status: $(this).attr('data-status'),
//                priority: $(this).attr('data-priority'),
//                comment: $(this).attr('data-comment')
//            },
//            params : function(params) {
//                return {
//                    'id' : $(this).attr('data-task-id'),
//                    'name' : params.value.name,
//                    'status' : params.value.status,
//                    'priority': params.value.priority,
//                    'comment': params.value.comment,
//                    'category' : $(this).attr('data-category'),
//                    'patient.id' : $(this).attr('data-pid')
//                }
//            }
//        });
//    });
});