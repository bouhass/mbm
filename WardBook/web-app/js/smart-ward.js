
function taskStatusToImage(status) {
    if      (status == 'STARTED')    return WEB_APP_ROOT+'images/half-square.png';
    else if (status == 'COMPLETED')  return WEB_APP_ROOT+'images/full-square.png';
    else /* (status == 'PENDING') */ return WEB_APP_ROOT+'images/empty-square.png';
}

var updateTaskStatus = function() {
    var self = $(this)
    self.children('img').attr('src', WEB_APP_ROOT+'images/spinner.gif');
    var taskId = self.siblings().attr('data-tid');
    var currentStatus = self.siblings().attr('data-status');
    var newStatus = {
        'PENDING': 'STARTED',
        'STARTED': 'COMPLETED',
        'COMPLETED': 'PENDING'
    }[currentStatus]

    $.post(WEB_APP_ROOT+'task/updateStatus', {
        'id': taskId,
        'status': newStatus
    })
        .done(function(task) {
            self.children('img').attr('src', taskStatusToImage(task.status));
            self.siblings().attr('data-status', task.status);
        })
        .fail(function() {
            alert("ERROR: could not update the task status");
        })
}

var deleteTask = function() {
    var self = $(this);
    var taskElement = $(self.siblings()[1]);
    if (confirm('Are you sure you want to delete this job? ('+taskElement.attr('data-name')+')')) {
        self.children().removeClass('icon-remove');
        self.append('<img src="'+WEB_APP_ROOT+'images/spinner.gif" />');
        var taskId = taskElement.attr('data-tid');
        $.get(WEB_APP_ROOT+'task/delete/'+taskId)
            .done(function(task) {
                self.parent().remove();
            })
            .fail(function() {
                self.addClass('icon-remove')
                alert("ERROR: could not delete task");
            })
    }
}

function addTask(patient_id, task) {
    var taskNameId = 'task-name-id'+new Date().getTime();
    var taskImageId = 'task-image'+new Date().getTime();
    var taskDeleteId = 'task-delete'+new Date().getTime();
    $('#task-'+task.category+'-'+patient_id).append('' +
        '<tr>' +
            '<td id="'+taskImageId+'" class="update-task-status"><img src="'+taskStatusToImage(task.status)+'"/></td>' +
            '<td id="'+taskNameId+'" data-type="task" data-tid="'+task.id+'" data-status="PENDING" data-name="'+task.name+'" class="editable editable-click">'+task.name+'</td>' +
            '<td id="'+taskDeleteId+'" class="delete-task"><i class="icon-remove" /></td>' +
        '</tr>');
    $('#'+taskNameId).editable({
        type: 'text',
        pk: task.id,
        url: WEB_APP_ROOT+'task/saveOrUpdate',
        value: {
            name: task.name
        },
        params: function(params) {
            return {
                'id': $(this).attr('data-tid'),
                'name': params.value.name,
                'status': params.value.status,
                'priority': params.value.priority,
                'comment': params.value.comment,
                'category': task.category,
                'patient.id': patient_id
            }
        }
    });
    $('#'+taskImageId).on('click', updateTaskStatus);
    $('#'+taskDeleteId).on('click', deleteTask);
}

function addNewTask(name, patient_id, category) {
    $.post(WEB_APP_ROOT+'task/saveOrUpdate', {
        'name': name,
        'category': category,
        'patient.id': patient_id
    })
        .done(function(task) {
            addTask(patient_id, task);
        })
        .fail(function() {
            alert("ERROR: could not add the task");
        })
}

function addRecord(name, patient_id, type) {
    $.post(WEB_APP_ROOT+'record/saveOrUpdate', {
        'name': name,
        'type': type,
        'patient.id': patient_id
    })
        .done(function(record) {
            var id = new Date().getTime();
            $('#record-'+type+'-'+patient_id).append('<tr><td id="'+id+'" data-rid="'+record.id+'">'+name+'</td></tr>');
        })
        .fail(function() {
            alert("ERROR: could not add the task");
        })
}
