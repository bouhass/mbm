<g:applyLayout name="bootstrap-mobile">

    <g:set var="navTitle" value="${task.patient}" scope="request" />

    <div class="col-sm-12">
        <h4>${task.name}</h4>

        <hr/>

        <dl>
            <dt>Assign to</dt>
            <dd><a href="#" data-id="${task.id}" data-value="${task.assignee?.id}" class="task-assignee">${task.assignee ?: ''}</a></dd>
        </dl>
        <dl>
            <dt>Priority</dt>
            <dd><a href="#" data-id="${task.id}" data-value="${task.priority}" class="task-priority">${task.priority}</a></dd>
        </dl>
        <dl>
            <dt>Time due</dt>
            <dd><a href="#" data-type="combodate" data-pk="${task.id}" data-task-id="${task.id}" data-value="${task.timeDue}" class="task-time-due"></a></dd>
        </dl>
        <div>
            <g:render template="/shared/comments" model="[commentable: task]"/>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('.task-assignee').each(function() {
                updateBeanField(this, this, 'task', $(this).attr('data-id'), 'assignee.id', 'select', $(this).attr('data-value'), WEB_APP_ROOT+'helpers/users');
            });

            $('.task-priority').each(function() {
                updateBeanField(this, this, 'task', $(this).attr('data-id'), 'priority', 'select', $(this).attr('data-value'), { NORMAL: "NORMAL", URGENT: "URGENT" });
            });

            updateBeanDateTimeField($('.task-time-due'), 'task');
        });
    </script>

</g:applyLayout>