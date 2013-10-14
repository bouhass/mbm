<table class="table table-striped">
    <thead>
    <tr>
        <th>Location</th>
        <th>Patient</th>
        <th>Task</th>
        <th>Time due</th>
        <th>Comments</th>
        <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${patient.tasks}" var="task">
        <g:if test="${!task.isActive()}">
            <tr>
                <td>${task.patient.location}</td>
                <td>${task.patient}</td>
                <td>${task.name}</td>
                <td><g:formatDate format="dd-MM-yyyy HH:mm" date="${task.timeDue}"/></td>
                <td>${task.comments.size}</td>
                <td class="task-status" data-status="${task.status}"><img/></td>
            </tr>
        </g:if>
    </g:each>
    </tbody>
</table>

<script>
    $(window).load(function() {
        $('.task-status').each(function() {
            $(this).children('img').attr('src', taskStatusToImage($(this).attr('data-status')));
        });
    });
</script>