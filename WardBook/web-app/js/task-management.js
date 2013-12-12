
$(window).load(function() {
    var modalLoadingDiv = '' +
        '<div class="modal-dialog hidden-print">' +
        '<div class="modal-content">' +
        '<div class="modal-body">' +
        '<img src="'+WEB_APP_ROOT+'images/spinner.gif" class="text-centered"/>' +
        '</div>' +
        '</div>' +
        '</div>';

    $('body').append('<div id="task-edit-modal" class="modal fade" tabindex="-1" data-backdrop="true" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
        modalLoadingDiv +
        '</div>');

    $('#task-edit-modal').on('shown.bs.modal', function () {
    });

    $('#task-edit-modal').on('hidden.bs.modal', function () {
        $(this).html(modalLoadingDiv);
    });

    $('input.add-task-input').keyup(function (e) {
        if (e.keyCode == 13) {
            addNewTask($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-category'));
            $(this).typeahead('setQuery', '');
        }
    });

    $('input.add-task-input').on('typeahead:selected', function() {
        addNewTask($(this).val(), $(this).attr('data-patient_id'), $(this).attr('data-category'));
        $(this).typeahead('setQuery', '');
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
});