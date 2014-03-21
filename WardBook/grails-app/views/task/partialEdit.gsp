<%@ page import="com.wardbook.User" %>
<g:applyLayout name="bootstrap">

    %{--<div class="modal-dialog">--}%
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">${task.patient}</h4>
            </div>

            <div class="modal-body">
                <dl>
                    <dt>Name</dt>
                    <dd><a href="#" data-id="${task.id}" data-value="${task.name}" class="edit-task-name">${task.name}</a></dd>
                </dl>
                <dl>
                    <dt>Assign to</dt>
                    <dd><a href="#" data-id="${task.id}" data-value="${task.assignee?.id}" class="edit-task-assignee">${task.assignee ?: ''}</a></dd>
                </dl>
                <dl>
                    <dt>Priority</dt>
                    <dd><a href="#" data-id="${task.id}" data-value="${task.priority}" class="edit-task-priority">${task.priority}</a></dd>
                </dl>
                %{--<dl>--}%
                    %{--<dt>Time due</dt>--}%
                    %{--<dd><a href="#" data-type="combodate" data-pk="${task.id}" data-task-id="${task.id}" data-value="${task.timeDue}" class="task-time-due"></a></dd>--}%
                %{--</dl>--}%
                <div>
                    <g:render template="/shared/comments" model="[commentable: task]"/>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div><!-- /.modal-content -->
    %{--</div><!-- /.modal-dialog -->--}%

    <script>
        $(document).ready(function() {
            $('.edit-task-name').each(function() {
                updateEntityField(this, 'task', 'name', 'text', {
                    success: function(task, newValue) {
                        $('[data-task-id="'+task.id+'"] .task-name').text(newValue);
                    }
                });
            });

            $('.edit-task-assignee').each(function() {
                updateEntityField(this, 'task', 'assignee.id', 'select', {
                    source: WEB_APP_ROOT+'helpers/users'
                });
            });

            $('.edit-task-priority').each(function() {
                updateEntityField(this, 'task', 'priority', 'select', {source: { 'NON-URGENT': "NON-URGENT", 'URGENT': "URGENT" }});
            });

//            updateEntityDateTimeField($('.task-time-due'), 'timeDue', 'task');
        });
    </script>

</g:applyLayout>