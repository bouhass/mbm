
function taskStatusToImage(status) {
    if      (status == 'STARTED')    return WEB_APP_ROOT+'images/check-square-half.png';
    else if (status == 'COMPLETED')  return WEB_APP_ROOT+'images/check-square-full.png';
    else /* (status == 'PENDING') */ return WEB_APP_ROOT+'images/check-square-empty.png';
}

var updateTaskStatus = function() {
    var self = $(this)
    self.children('img').attr('src', WEB_APP_ROOT+'images/spinner.gif');
    var taskElement = $(self.siblings()[1]).children('div');
    var taskId = taskElement.attr('data-tid');
    var currentStatus = taskElement.attr('data-status');
    var newStatus = {
        'PENDING': 'STARTED',
        'STARTED': 'COMPLETED',
        'COMPLETED': 'PENDING'
    }[currentStatus]

    $.post(WEB_APP_ROOT+'task/partialUpdate', {
        'id': taskId,
        'status': newStatus
    })
        .done(function(task) {
            self.children('img').attr('src', taskStatusToImage(task.status));
            taskElement.attr('data-status', task.status);
        })
        .fail(function() {
            alert("ERROR: could not update the task status");
        })
}

var deleteTask = function() {
    var self = $(this);
    var taskElement = $(self.siblings()[0]).children('div');
    if (confirm('Are you sure you want to delete this job? ('+taskElement.attr('data-name')+')')) {
        self.children().removeClass('glyphicon');
        self.children().removeClass('glyphicon-remove');
        self.append('<img src="'+WEB_APP_ROOT+'images/spinner.gif" />');
        var taskId = taskElement.attr('data-tid');
        $.get(WEB_APP_ROOT+'task/delete/'+taskId)
            .done(function(task) {
                self.parent().remove();
            })
            .fail(function() {
                self.children('img').remove();
                self.children().addClass('glyphicon');
                self.children().addClass('glyphicon-remove');
                alert("ERROR: could not delete task");
            })
    }
}

var deleteRecord = function() {
    var self = $(this);
    var taskElement = self.siblings();
    if (confirm('Are you sure you want to delete this record? ('+taskElement.text().trim()+')')) {
        self.children().removeClass('glyphicon');
        self.children().removeClass('glyphicon-remove');
        self.append('<img src="'+WEB_APP_ROOT+'images/spinner.gif" />');
        var recordId = taskElement.attr('data-rid');
        $.get(WEB_APP_ROOT+'record/delete/'+recordId)
            .done(function(record) {
                self.parent().remove();
            })
            .fail(function() {
                self.children('img').remove();
                self.children().addClass('glyphicon');
                self.children().addClass('glyphicon-remove');
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
            '<td id="'+taskDeleteId+'" class="delete-task"><button type="button" class="btn btn-danger btn-xs hidden"><span class="glyphicon glyphicon-remove"></span></button></td>' +
            '<td><div id="'+taskNameId+'" data-type="task" data-tid="'+task.id+'" data-status="PENDING" data-name="'+task.name+'" class="editable editable-click">'+task.name+'</div></td>' +
            '<td id="'+taskImageId+'" class="update-task-status"><img src="'+taskStatusToImage(task.status)+'"/></td>' +
        '</tr>');
    $('#'+taskNameId).editable({
        type: 'text',
        placement: 'left',
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

function addNewRecord(name, patient_id, type) {
    $.post(WEB_APP_ROOT+'record/saveOrUpdate', {
        'name': name,
        'type': type,
        'patient.id': patient_id
    })
        .done(function(record) {
            var id = new Date().getTime();
            var elId = '#record-'+type+'-'+patient_id;
            $(elId).append('' +
                '<tr>' +
                    '<td class="delete-record"><button type="button" class="btn btn-danger btn-xs hidden"><span class="glyphicon glyphicon-remove"></span></button></td>' +
                    '<td id="'+id+'" data-rid="'+record.id+'" class="record">'+name+'</td>' +
                '</tr>');
            $('[data-rid='+record.id+']').editable({
                mode: 'inline',
                type: 'text',
                pk : record.id,
                url: WEB_APP_ROOT+'record/saveOrUpdate',
                showbuttons: false,
                params : function(params) {
                    return {
                        'id' : record.id,
                        'name' : params.value
                    }
                }
            });
        })
        .fail(function() {
            alert("ERROR: could not add the task");
        })
}

var patientTableSearch = function() {
    var $rows = $('#patients-table > tbody > tr');
    var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

    $rows.show().filter(function() {
        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
        return !~text.indexOf(val);
    }).hide();
}

var updatePatientLocation = function() {
    $(this).editable({
        mode: 'inline',
        type: 'text',
        pk : $(this).attr('data-pid'),
        url: WEB_APP_ROOT+'patient/partialUpdate',
        value: $(this).attr('data-value'),
        showbuttons: false,
        params : function(params) {
            return {
                'id' : $(this).attr('data-pid'),
                'location' : params.value
            }
        }
    });
}

var updatePatientStatus = function() {
    $(this).editable({
        mode: 'inline',
        type: 'select',
        pk : $(this).attr('data-pid'),
        url: WEB_APP_ROOT+'patient/partialUpdate',
        value: $(this).attr('data-status'),
        source: WEB_APP_ROOT+'patient/statuses',
        showbuttons: false,
        params : function(params) {
            return {
                'id' : $(this).attr('data-pid'),
                'status' : params.value
            }
        }
    });
}

